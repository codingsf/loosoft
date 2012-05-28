using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 相关设置接口
    /// 鄢睿
    /// 2011年2月16日 15:30
    /// </summary>
    public interface IItemConfigDao : IBaseDao<ItemConfig>
    {
        bool Exists(string name);
        int AddItemConfig(ItemConfig itemConfig);
        int DeleteItemConfig(string name);
        int DeleteItemConfig(int id);
        ItemConfig GetItemConfig(int id);
        IList<ItemConfig> GetItemConfigList();
        IList<ItemConfig> GetItemConfigList(string name);
        ItemConfig GetItemConfigByName(string name);
        int UpdateValue(ItemConfig config);
    }
}
