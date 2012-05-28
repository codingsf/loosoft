using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    public class ItemConfigService
    {
        private static ItemConfigService _instance = new ItemConfigService();
        private IDaoManager _daoManager = null;
        private IItemConfigDao _itemConfigDao = null;

        private ItemConfigService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _itemConfigDao = _daoManager.GetDao(typeof(IItemConfigDao)) as IItemConfigDao;
        }

        public static ItemConfigService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new ItemConfigService();
            }
            return _instance;
        }

        /// <summary>
        /// 功能：通过相关设置名称判断相关设置记录是否存在
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:12
        /// </summary>
        /// <param name="name">相关设置名称</param>
        /// <returns>true：存在 false：不存在</returns>
        public bool Exists(string name)
        {
            return _itemConfigDao.Exists(name);
        }

        /// <summary>
        /// 功能：添加一条相关设置记录
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:18
        /// </summary>
        /// <param name="itemConfig">相关设置</param>
        /// <returns>flag小于等于0失败，大于0成功</returns>
        public int AddItemConfig(ItemConfig itemConfig)
        {
           int res =  _itemConfigDao.AddItemConfig(itemConfig);
           if (res > 0 && itemConfig.name.Equals(ItemConfig.CO2))
           { 
            //更新用户的静态量
               ItemConfig.reductionRate = itemConfig.value;
           }
           return res;
        }

        /// <summary>
        /// 功能：通过相关设置名称删除一条记录
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:22
        /// </summary>
        /// <param name="name">相关设置名称</param>
        /// <returns>flag小于等于0失败，大于0成功</returns>
        public int DeleteItemConfig(string name)
        {
            return _itemConfigDao.DeleteItemConfig(name);
        }
        /// <summary>
        /// 功能：通过相关设置Id删除一条记录
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:23
        /// </summary>
        /// <param name="name">相关设置名称</param>
        /// <returns>flag小于等于0失败，大于0成功</returns>
        public int DeleteItemConfig(int id)
        {
            return _itemConfigDao.DeleteItemConfig(id);
        }

        /// <summary>
        /// 功能：获得所有相关信息列表
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:24
        /// </summary>
        /// <returns></returns>
        public IList<ItemConfig> GetItemConfigList()
        {
            return _itemConfigDao.GetItemConfigList();
        }
        /// <summary>
        /// 功能：通过相关信息名称，获得所有相关信息列表
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:27
        /// </summary>
        /// <returns></returns>
        public IList<ItemConfig> GetItemConfigList(string name)
        {
            return _itemConfigDao.GetItemConfigList(name);
        }

        /// <summary>
        /// 功能：更新相关信息
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:33
        /// </summary>
        /// <param name="itemConfig"></param>
        /// <returns></returns>
        public int Update(ItemConfig itemConfig)
        {
            int res = _itemConfigDao.Update(itemConfig);
            if (res > 0 && itemConfig.name.Equals(ItemConfig.CO2))
            {
                //更新用户的静态量
                ItemConfig.reductionRate = itemConfig.value;
            }
            return res;
        }

        /// <summary>
        /// 功能：通过相关配置Id获得相关配置信息
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:35
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ItemConfig GetItemConfig(int id)
        {
            return _itemConfigDao.GetItemConfig(id);
        }

        /// <summary>
        /// 根据配置项目名称取得一个配置
        /// </summary>
        /// <returns></returns>
        public ItemConfig GetItemConfigByName(string name) {
            return _itemConfigDao.GetItemConfigByName(name);
        }

        /// <summary>
        /// 取得CO2配置
        /// </summary>
        /// <returns></returns>
        public float getCO2Config() {
            ItemConfig itemConfig = ItemConfigService.GetInstance().GetItemConfigByName(ItemConfig.CO2);
            if (itemConfig == null)
                return ItemConfig.defaultreductionRate;
            else
                return itemConfig.value;
        
        }


        /// <summary>
        /// 取得等效树木配置
        /// </summary>
        /// <returns></returns>
        public float getTreeConfig()
        {
            ItemConfig itemConfig = ItemConfigService.GetInstance().GetItemConfigByName(ItemConfig.Tree);
            if (itemConfig == null)
                return ItemConfig.defaultreductionRate;
            else
                return itemConfig.value;

        }

        public int UpdateValue(ItemConfig config)
        {
            return _itemConfigDao.UpdateValue(config);
        }
    }
}
