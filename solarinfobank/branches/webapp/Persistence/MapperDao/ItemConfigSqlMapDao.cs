using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 功能：相关设置定义接口成员
    /// 作者：鄢睿
    /// 创建时间：2011年2月16日 15:37
    /// </summary>
    public class ItemConfigSqlMapDao : BaseSqlDao<ItemConfig>, IItemConfigDao
    {
        #region IItemConfigDao 成员

        /// <summary>
        /// 功能：通过相关设置名称判断相关设置记录是否存在
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:12
        /// </summary>
        /// <param name="name">相关设置名称</param>
        /// <returns>true：存在 false：不存在</returns>
        public bool Exists(string name)
        {
            int? flag = ExecuteQueryForObject("CHECK_ITEMCONFIG_EXISTS", name) as int?;
            if (flag > 0)
            {
                return true;
            }
            return false;
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
            int flag = 0;
            ExecuteInsert<ItemConfig>("INSERT_ITEMCONFIG", itemConfig, out flag);
            return flag;
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
            int flag = ExecuteDelete("DELETE_ITEMCONFIG_BY_Name", name);
            return flag;
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
            int flag = ExecuteDelete("DELETE_ITEMCONFIG_BY_ID", id);
            return flag;
        }

        /// <summary>
        /// 功能：获得所有相关信息列表
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:24
        /// </summary>
        /// <returns></returns>
        public IList<ItemConfig> GetItemConfigList()
        {
            IList<ItemConfig> itemConfigList = ExecuteQueryForList<ItemConfig>("Get_All_ITEMCONFIG_LIST", null);
            if (itemConfigList.Count > 0)
            {
                return itemConfigList;
            }
            return null;
        }
        /// <summary>
        /// 功能：通过相关信息名称，获得所有相关信息列表
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:27
        /// </summary>
        /// <returns></returns>
        public IList<ItemConfig> GetItemConfigList(string name)
        {
            IList<ItemConfig> itemConfigList = ExecuteQueryForList<ItemConfig>("Get_ITEMCONFIG_BYNAME", name);
            if (itemConfigList.Count > 0)
            {
                return itemConfigList;
            }
            return null;
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
            ItemConfig itemConfig = ExecuteQueryForObject<ItemConfig>("get_itemconfig_by_id", id);
            return itemConfig;
        }

        /// <summary>
        /// 功能：通过相关配置项目获得相关配置信息
        /// 作者：鄢睿
        /// 创建时间：2011年2月16日 16:35
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public ItemConfig GetItemConfigByName(string name)
        {
            return ExecuteQueryForObject<ItemConfig>("itemconfig_get_by_name", name);
        }

        #endregion

        #region IItemConfigDao 成员


        public int UpdateValue(ItemConfig config)
        {
            return ExecuteUpdate("itemconfig_update_value", config);
        }

        #endregion
    }
}
