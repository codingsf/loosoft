using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class QASqlMaoDao : BaseSqlDao<QA>, IQADao
    {
        public int UpdateStatus(int id, int status)
        {
            return ExecuteUpdate("qa_update_status", new QA { id = id, status = status });
        }

        public int Recommend(int id, bool isrecommend)
        {
            return ExecuteUpdate("qa_recommend", new QA { id = id, isRecommend = isrecommend });
        }

        public IList<QA> GetRecommendList()
        {
            return ExecuteQueryForList<QA>("qa_get_recommend_list", null);
        }
    }
}
