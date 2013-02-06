using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;


namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class CategorySqlMapDao : BaseSqlDao<Category>, ICategory
    {

        public IList<Category> GetList(string cid)
        {
            return ExecuteQueryForList<Category>("select_child_category", cid);
        }
    }
}
