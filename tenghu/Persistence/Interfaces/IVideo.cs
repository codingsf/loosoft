using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface IVideo : IBaseDao<Video>
    {
        IList<Video> GetVideoCategory(int cid);
    }
}
