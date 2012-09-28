using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface ICompensationDao : IBaseDao<Compensation>
    {
        IList<Compensation> searchCompensation(Hashtable table);

        /// <summary>
        /// 取得某个对象的某个中类型的补偿设置
        /// </summary>
        /// <param name="objectId">补偿对象</param>
        /// <param name="isPlant">是否电站</param>
        /// <param name="type">补偿类型</param>
        /// <param name="year">年 可以为null</param>
        /// <param name="month">月 可以为null</param>
        /// <returns></returns>
        IList<Compensation> getCompensations(int objectId, bool isPlant, int type, string year, string month);
    }


}
