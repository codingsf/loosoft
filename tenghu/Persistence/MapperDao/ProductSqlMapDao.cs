using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class ProductSqlMapDao : BaseSqlDao<Product>, IProduct
    {

        public IList<Product> GetProductsCategory(int cid)
        {
            return ExecuteQueryForList<Product>("product_get_category", cid);
        }
    }
}
