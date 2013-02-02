using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using IBatisNet.Common.Exceptions;
using IBatisNet.Common.Pagination;
using IBatisNet.DataAccess;
using IBatisNet.DataAccess.DaoSessionHandlers;
using IBatisNet.DataAccess.Interfaces;
using IBatisNet.DataMapper;
using IBatisNet.DataMapper.MappedStatements;
using IBatisNet.DataMapper.Scope;
using System.Reflection;

namespace Cn.Loosoft.Zhisou.Tenghu.Persistence.MapperDao
{

    public class BaseSqlMapDao : IDao
    {
        protected ISqlMapper GetLocalSqlMap()
        {
            IDaoManager daoManager = DaoManager.GetInstance(this);
            SqlMapDaoSession sqlMapDaoSession = daoManager.LocalDaoSession as SqlMapDaoSession;
            return sqlMapDaoSession.SqlMap;
        }

        /// <summary>
        /// 执行添加
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="statementName">操作名称</param>
        /// <param name="parameterObject">执行添加的对象</param>
        protected void ExecuteInsert<T>(string statementName, T parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                sqlMap.Insert(statementName, parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for insert.  Cause: " + e.Message, e);
            }
        }

        /// <summary>
        /// 执行添加
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="parameterObject">执行添加的对象</param>
        protected void ExecuteInsert<T>(T parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                sqlMap.Insert(string.Format("{0}_insert", typeof(T).Name.ToLower()), parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + typeof(T).Name.ToLower() + "' for insert.  Cause: " + e.Message, e);
            }
        }

        /// <summary>
        /// 执行添加
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="statementName">操作名称</param>
        /// <param name="parameterObject">执行添加的对象</param>
        /// <param name="identity">返回数据库主键标示</param>
        protected void ExecuteInsert<T>(string statementName, T parameterObject, out int identity)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                object value = sqlMap.Insert(statementName, parameterObject);
                identity = value != null ? (int)value : -1;
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for insert.  Cause: " + e.Message, e);
            }
        }

        /// <summary>
        /// 批量执行插入
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="statementObjectKvList"></param>
        protected void ExecuteBatchInsert<T>(IList<KeyValuePair<string,T>> statementObjectKvList)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                foreach(KeyValuePair<string,T> kv in statementObjectKvList){
                    sqlMap.Insert(kv.Key, kv.Value);
                }
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing for insert.  Cause: " + e.Message, e);
            }
        }

        /// <summary>
        /// 批量执行更新
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="statementObjectKvList"></param>
        protected void ExecuteBatchUpdate<T>(IList<KeyValuePair<string, T>> statementObjectKvList)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                foreach (KeyValuePair<string, T> kv in statementObjectKvList)
                {
                    sqlMap.Update(kv.Key, kv.Value);
                }
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing for insert.  Cause: " + e.Message, e);
            }
        }

        /// <summary>
        /// 获取列表
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="statementName">操作名称</param>
        /// <param name="parameterObject">参数对象</param>
        /// <returns>对象列表</returns>
        protected IList<T> ExecuteQueryForList<T>(string statementName, object parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                return sqlMap.QueryForList<T>(statementName, parameterObject);
                
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for list.  Cause: " + e.Message, e);
            }
        }
        /// <summary>
        /// 获取列表
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="statementName">操作名称</param>
        /// <param name="parameterObject">参数对象</param>
        /// <param name="skipResults">开始游标</param>
        /// <param name="maxResults">结束游标</param>
        /// <returns></returns>
        protected IList<T> ExecuteQueryForList<T>(string statementName, object parameterObject, int skipResults, int maxResults)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                return sqlMap.QueryForList<T>(statementName, parameterObject, skipResults, maxResults);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for list.  Cause: " + e.Message, e);
            }
        }
        /// <summary>
        /// 分页查询
        /// </summary>
        /// <param name="statementName">对应sqlmap 中的ID</param>
        /// <param name="parameterObject">参数对象</param>
        /// <param name="pageSize">每页大小</param>
        /// <returns>分页数据</returns>
        protected IPaginatedList ExecuteQueryForPaginatedList(string statementName, object parameterObject, int pageSize)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                return sqlMap.QueryForPaginatedList(statementName, parameterObject, pageSize);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for paginated list.  Cause: " + e.Message, e);
            }
        }

        protected IList ExecuteQueryForList(string statementName, object parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                return sqlMap.QueryForList(statementName, parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for list.  Cause: " + e.Message, e);
            }
        }

        protected IList ExecuteQueryForList(string statementName, object parameterObject, int skipResults, int maxResults)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();
            try
            {
                return sqlMap.QueryForList(statementName, parameterObject, skipResults, maxResults);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for list.  Cause: " + e.Message, e);
            }
        }

        protected T ExecuteQueryForObject<T>(string statementName, object parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.QueryForObject<T>(statementName, parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for object.  Cause: " + e.Message, e);
            }
        }

        protected object ExecuteQueryForObject(string statementName, object parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.QueryForObject(statementName, parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for object.  Cause: " + e.Message, e);
            }
        }

        protected int ExecuteUpdate<T>(T parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.Update(string.Format("{0}_update", typeof(T).Name.ToLower()), parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + typeof(T).Name.ToLower() + "' for update.  Cause: " + e.Message, e);
            }
        }

        protected int ExecuteUpdate(string statementName)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.Update(statementName, null);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for update.  Cause: " + e.Message, e);
            }
        }


        protected int ExecuteUpdate<T>(string statementName, T parameterObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.Update(statementName, parameterObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for update.  Cause: " + e.Message, e);
            }
        }

        protected int ExecuteDelete<T>(T paramObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.Delete(string.Format("{0}_delete", typeof(T).Name.ToLower()), paramObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + typeof(T).Name.ToLower() + "' for insert.  Cause: " + e.Message, e);
            }
        }

        protected int ExecuteDelete(string statementName, object paramObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.Delete(statementName, paramObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for insert.  Cause: " + e.Message, e);
            }
        }

        protected int ExecuteDelete<T>(string statementName, T paramObject)
        {
            ISqlMapper sqlMap = GetLocalSqlMap();

            try
            {
                return sqlMap.Delete(statementName, paramObject);
            }
            catch (Exception e)
            {
                throw new IBatisNetException("Error executing query '" + statementName + "' for insert.  Cause: " + e.Message, e);
            }
        }
    }
}