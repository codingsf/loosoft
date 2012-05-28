using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Memcached.ClientLibrary;
using System.Configuration;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// Memcached Client Class
    /// </summary>
    public class MemcachedClientSatat
    {        

        //存储解析过的可以列表
        private string analyzedkey = "analyzedkey";
        private string poolName = "DataAnalyze";//和数据收发服务保持一致
        private int msgnum = 0;
        private String[] serverlist = { "127.0.0.1:11211" };//要改为配置文件读取
        private MemcachedClient mc = null;
        private SockIOPool pool;
        private static IDictionary<string, MemcachedClientSatat> instances = new Dictionary<string, MemcachedClientSatat>();

        private MemcachedClientSatat()
        {
            string memchached = ConfigurationSettings.AppSettings["memchached"];
            string msgnumstr = ConfigurationSettings.AppSettings["msgnum"];
            msgnum = msgnumstr == null ? 0 : int.Parse(msgnumstr);
            string keystr = ConfigurationSettings.AppSettings["analyzedkey"];
            if (keystr != null)
                analyzedkey = keystr;
            serverlist = memchached.Split(',');
            // initialize the pool for memcache servers
            try
            {
                pool = SockIOPool.GetInstance(poolName);
            }
            catch (Exception)
            {
                
                throw;
            }
            pool.SetServers(serverlist);
            pool.Initialize();
            mc = new MemcachedClient();
            mc.PoolName = poolName;
            mc.EnableCompression = false;
        }

        private MemcachedClientSatat(String[] servers)
        {
            string msgnumstr = ConfigurationSettings.AppSettings["msgnum"];
            msgnum = msgnumstr == null ? 0 : int.Parse(msgnumstr);
            string keystr = ConfigurationSettings.AppSettings["analyzedkey"];
            if (keystr != null)
                analyzedkey = keystr;
            this.serverlist = servers;
            // initialize the pool for memcache servers
            pool = SockIOPool.GetInstance();
            pool.SetServers(serverlist);
            pool.Initialize();
            mc = new MemcachedClient();
            //mc.PoolName = poolName;
            mc.EnableCompression = false;
        }

        /// <summary>
        /// 取得默认缓存客户端实例
        /// </summary>
        /// <returns></returns>
        public static  MemcachedClientSatat getInstance() {
            MemcachedClientSatat mcs = instances.ContainsKey("defualt") ? instances["defualt"] : null;
            if (mcs == null)
            {
                mcs = new MemcachedClientSatat();
                instances["defualt"] = mcs;
            }
            return mcs;
        }

        /// <summary>
        /// 取得制定配置缓存客户端实例
        /// </summary>
        /// <returns></returns>
        public static MemcachedClientSatat getInstance(string servers)
        {

            MemcachedClientSatat mcs = instances.ContainsKey(servers)? instances[servers]  :null;
            if (mcs == null)
            {
                string[] serverList = servers.Split(',');
                mcs = new MemcachedClientSatat(serverList);
                instances[servers] = mcs;
            }
            return mcs;
        }

        /// <summary>
        /// 判断key是否存在
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public bool KeyExists(string key)
        {
            return mc.KeyExists(key);
        }
        /// <summary>
        /// 按照key取值
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public object Get(string key)
        {
            return mc.Get(key);
        }
        /// <summary>
        /// 按照key删除对象
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public bool Delete(string key)
        {
            return mc.Delete(key);
        }
        /// <summary>
        /// 赋值
        /// </summary>
        /// <param name="key"></param>
        /// <param name="ob"></param>
        public void Set(string key, object ob)
        {
            mc.Set(key, ob);
        }
        /// <summary>
        /// 设置值，带过期时间
        /// </summary>
        /// <param name="key"></param>
        /// <param name="ob"></param>
        /// <param name="expireTime"></param>
        public void Set(string key, object ob, DateTime expireTime)
        {
            mc.Set(key, ob,expireTime);
        }
        /// <summary>
        /// 新增项
        /// </summary>
        /// <param name="key"></param>
        /// <param name="ob"></param>
        public void Add(string key, object ob)
        {
            mc.Add(key, ob);
        }

        /// <summary>
        /// 
        /// 增加可以，指定过期时间
        /// </summary>
        /// <param name="key"></param>
        /// <param name="ob"></param>
        /// <param name="expireTime"></param>
        public void Add(string key, object ob,DateTime expireTime)
        {
            mc.Add(key, ob,expireTime);
        }

        /// <summary>
        /// 取得所有keys
        /// </summary>
        /// <param name="memAffix">memkey的前缀</param>
        /// <returns></returns>
        public List<string> GetAllKeys(string memAffix)
        {
            return mc.GetKeys(memAffix);
        }

        /// <summary>
        /// 取得所有keys
        /// </summary>
        /// <returns></returns>
        public List<string> GetAllKeys()
        {
            return GetAllKeys("");
        }


        /// <summary>
        /// 判断是否已经被解析过了
        /// </summary>
        /// <param name="newKey"></param>
        /// <returns></returns>
        public bool isAnalyzed(string newKey){
            IList<string> hasList = (IList<string>)this.Get(analyzedkey);
            if (hasList != null)
            {
                return hasList.Contains(newKey);
            }
            return false;
        }
        /// <summary>
        /// 删除最早的一个，为了保留msgnum个历史数据
        /// </summary>
        public void deleteAnalyzed(string newKey)
        {
            IList<string> hasList = (IList<string>)this.Get(analyzedkey);
            if (hasList == null)
            {
                hasList = new List<string>();
            }
            if (msgnum == 0)
            {
                mc.Delete(newKey);
            }
            else if(hasList.Count > msgnum ) {
                string key = hasList[0];
                hasList.Remove(key);
                mc.Delete(key);
            }
        }

        public void remember(string newKey)
        {
            IList<string> hasList = (IList<string>)this.Get(analyzedkey);
            if (hasList == null)
            {
                hasList = new List<string>();
            }
            if (msgnum == 0)
            {
                if (hasList.Count > 3000)
                {
                    hasList.Clear();
                }
            }
            else if (hasList.Count > msgnum)
            {
                string key = hasList[0];
                hasList.Remove(key);
            }
            hasList.Add(newKey);
            this.Set(analyzedkey, hasList);
        
        }
    }
}
