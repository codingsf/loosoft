﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface ICategory : IBaseDao<Category>
    {
        IList<Category> GetList(string cid);
    }
}
