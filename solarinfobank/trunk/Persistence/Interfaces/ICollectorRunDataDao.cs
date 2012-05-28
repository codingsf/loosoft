using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 作者：陈波
    /// 功能：电站运行时数据接口定义
    /// 创建时间：2011-02-25
    /// </summary>
    public interface ICollectorRunDataDao : IBaseDao<CollectorRunData>
    {
        float GetAllDayEnergy(string yyyyMMdd);
        /// <summary>
        /// 取得所有电站的实时功率
        /// </summary>
        /// <param name="yyyyMMdd"></param>
        /// <returns></returns>
        float GetAllPower(string yyyyMMdd);
    }


}
