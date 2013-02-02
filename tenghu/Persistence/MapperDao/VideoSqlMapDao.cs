using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao;
using Cn.Loosoft.Zhisou.Tenghu.Domain;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class VideoSqlMapDao : BaseSqlDao<Video>, IVideo
    {
        public IList<Video> GetVideoCategory(int cid)
        {
            return ExecuteQueryForList<Video>("video_get_list_category", cid);
        }
    }
}
