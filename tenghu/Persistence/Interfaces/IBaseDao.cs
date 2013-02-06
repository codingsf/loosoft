using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using IBatisNet.Common.Pagination;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces
{
    public interface IBaseDao<T>
    {

        int Insert(T t);

        int Remove(T t);
 
        int Update(T t);
      
        T Get(T t);

        IList<T> Getlist(T t);

        IList<T> GetPageList(Pager page, string head);

        IList<T> Getlist(T t, int skipResults,int maxResults);

        IPaginatedList Getlist(T t, int pageSize);

        IList<T> Getlist(Hashtable page);
   
        void BatchUpdate(IList<T> tlist);
    
        void BatchInsert(IList<T> tlist);

    }
}
