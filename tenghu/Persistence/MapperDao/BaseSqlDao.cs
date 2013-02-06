using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using IBatisNet.Common.Pagination;
using System.Reflection;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{
    public class BaseSqlDao<T> : BaseSqlMapDao
    {
         
        public BaseSqlDao()
        {
        }


        public virtual int Update(T t)
        {
            int flag = 0;//标识保存方法是否成功
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            object id = t.GetType().GetProperties()[0].GetValue(t, null);
            flag = ExecuteUpdate<T>(className + "_update", t);
            return flag;
        }
 
        public virtual int Insert(T t)
        {
            int flag = 0;//标识保存方法是否成功
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            ExecuteInsert<T>(className + "_insert", t, out flag);
            return flag;
        }
  
        public virtual void BatchInsert(IList<T> tlist)
        {
            string className = null;
            IList<KeyValuePair<string, T>> kvList = new List<KeyValuePair<string, T>>();
            foreach (T t in tlist) {
                className = t.GetType().Name.ToLower();//传入对象的类型名称
                kvList.Add(new KeyValuePair<string, T>(className + "_insert", t));
            }
            ExecuteBatchInsert<T>(kvList);
        }

        /// <summary>
        /// 批量更新对象
        /// </summary>
        /// <param name="tlist"></param>
        public virtual void BatchUpdate(IList<T> tlist)
        {
            string className = null;
            IList<KeyValuePair<string, T>> kvList = new List<KeyValuePair<string, T>>();
            foreach (T t in tlist)
            {
                className = t.GetType().Name.ToLower();//传入对象的类型名称
                kvList.Add(new KeyValuePair<string, T>(className + "_update", t));
            }
            ExecuteBatchUpdate<T>(kvList);
        }


        public virtual int Remove(T t)
        {
            int flag = 0;//标识删除方法是否成功
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            flag = ExecuteDelete<T>(className + "_delete", t);
            return flag;
        }


        public virtual T Get(T t)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            object id = t.GetType().GetProperties()[0].GetValue(t, null);
            t = ExecuteQueryForObject<T>(className + "_get", id);
            return t;
        }

        public virtual IList<T> Getlist(T t)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            return ExecuteQueryForList<T>(className + "_get_list", t);
        }
        public virtual IList<T> Getlist(T t, int skipResults, int maxResults)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            return ExecuteQueryForList<T>(className + "_get_list", t, skipResults, maxResults);
        }


        public virtual IList<T> Getlist(Hashtable t)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            return ExecuteQueryForList<T>("loading_hashtable_page_list", t);
        }


        public virtual IPaginatedList Getlist(T t, int pageSize)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            return ExecuteQueryForPaginatedList(className + "_get_list", t, pageSize);
        }

        public virtual IList<T> GetPageList(Pager page, string head)
        {
            page.RecordCount = (int)ExecuteQueryForObject(string.Format("{0}_page_count", head), page);
            return ExecuteQueryForList<T>(string.Format("{0}_page_list", head), page);
        }
    }
}
