using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class TemplateSqlMapDao : BaseSqlDao<Template>, ITemplateDao
    {
        public Template getDefault()
        {
            return ExecuteQueryForObject<Template>("get_default_template", null);
        }
    }
}
