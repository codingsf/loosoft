using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using IBatisNet.DataMapper.Configuration.Cache;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary> 
    /// 使用MemCached做分布式缓存 
    /// </summary> 
    public class MemCachedController : ICacheController
    {
        MemcachedClientSatat _mc = null;
        private int _cacheSize = 0;
        private IList _keyList = null;

        /// <summary> 
        /// 
        /// </summary> 
        public MemCachedController()
        {
            _mc =  MemcachedClientSatat.getInstance();
            _cacheSize = 100;
            _keyList = ArrayList.Synchronized(new ArrayList());
        }

        #region ICacheController Members
        /// <summary> 
        /// 
        /// </summary> 
        /// <param name="key"></param> 
        /// <returns></returns> 
        public object this[object key]
        {
            get
            {
                _keyList.Remove(key);
                _keyList.Add(key);
                return _mc.Get(key.ToString());
            }
            set
            {
                _keyList.Add(key);
                if (_keyList.Count > _cacheSize)
                {
                    object oldestKey = _keyList[0];
                    _keyList.Remove(0);
                    _mc.Delete(oldestKey.ToString());
                }
            }
        }

        /// <summary> 
        /// 
        /// </summary> 
        /// <param name="key"></param> 
        /// <returns></returns> 
        public object Remove(object key)
        {
            //object o = _mc.Get(key.ToString()); 
            _keyList.Remove(key);
            _mc.Delete(key.ToString());
            return null;
        }

        /// <summary> 
        /// 
        /// </summary> 
        public void Flush()
        {
            //_mc.FlushAll(); 
            foreach (object arr in _keyList)
            {
                _mc.Delete(arr.ToString());
            }
            _keyList.Clear();
        }

        /// <summary> 
        /// 
        /// </summary> 
        /// <param name="properties"></param> 
        public void Configure(System.Collections.IDictionary properties)
        {
            string size = (string)properties["CacheSize"];
            if (size != null)
            {
                _cacheSize = Convert.ToInt32(size);
            }
        }

        #endregion
    }


}
