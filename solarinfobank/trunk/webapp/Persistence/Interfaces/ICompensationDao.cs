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
    }
}
