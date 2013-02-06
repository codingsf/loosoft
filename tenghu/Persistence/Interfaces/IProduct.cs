using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface IProduct : IBaseDao<Product>
    {
        IList<Product> GetProductsCategory(int cid);
    }
}
