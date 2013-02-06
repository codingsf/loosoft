using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface ICategory : IBaseDao<Category>
    {
        IList<Category> GetList(string cid);
    }
}
