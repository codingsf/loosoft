﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IEnergywarnDao : IBaseDao<Energywarn>
    {
        /// <summary>
        /// 分页查找发电量告警
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        IList<Energywarn> GetEnergywarnPage(Hashtable table);
    }
}
