﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface ITemplateDao : IBaseDao<Template>
    {
        Template getDefault();
        int setDefault(int id);
    }
}
