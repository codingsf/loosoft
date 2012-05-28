using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class CacheManager
    {
        private static CacheManager cacheManager= null;
        MemcachedClientSatat mc = MemcachedClientSatat.getInstance();
        private CacheManager()
        {
        }

        public static CacheManager getInstance() {
            if (cacheManager == null)
                cacheManager =  new CacheManager();
            return cacheManager;
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
        public T Get<T>(string key)
        {
            return (T)mc.Get(key);
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
        public void Set<T>(string key, T ob)
        {
            mc.Set(key, ob);
        }

        /// <summary>
        /// 设置值，带过期时间
        /// </summary>
        /// <param name="key"></param>
        /// <param name="ob"></param>
        /// <param name="expireTime"></param>
        public void Set<T>(string key, T ob, DateTime expireTime)
        {
            mc.Set(key, ob, expireTime);
        }

        /// <summary>
        /// 新增项
        /// </summary>
        /// <param name="key"></param>
        /// <param name="ob"></param>
        public void Add<T>(string key, T ob)
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
        public void Add<T>(string key, T ob, DateTime expireTime)
        {
            mc.Add(key, ob, expireTime);
        }
        /// <summary>
        /// 批量删除缓存
        /// </summary>
        /// <param name="keys"></param>
        public void deletes(IList<string> keys) { 
            foreach(string key in keys){
                mc.Delete(key);
            }
        }
    }
}
