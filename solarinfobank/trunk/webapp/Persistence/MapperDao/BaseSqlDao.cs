using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using IBatisNet.Common.Pagination;
using System.Reflection;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class BaseSqlDao<T> : BaseSqlMapDao
    {

        public BaseSqlDao()
        {
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：数据库访问的Update方法
        /// 说明：
        ///     使用时Maps中的配置文件配置两条类名称+“_DELETE”的 statements
        ///     如：
        ///       <update id="PLANTINFO_UPDATE" paramentClass="PlantInfo">
        ///            UPDATE  PLANT_INFO SET id=#Id#,plantCode=#PlantCode#,name=#Name#,postcode=#Postcode#,location=#Location#,country=#Country#,city=#City#,timezone=#Timezone#,revenue=#Revenue#,street=#Street#,installdate=#Installdate#,operater=#Operater#,email=#Email#,phone=#Phone#,direction=#Direction#,angle=#Angle#,manufacturer=#Manufacturer#,module_type=#ModuleType#,pic=#Pic# WHERE id=#Id#
        ///       </update>
        /// 创建时间：2011-02-21
        /// </summary>
        /// <typeparam name="T">需要保存的对象类型</typeparam>
        /// <param name="t">需要保存的对象</param>
        /// <returns>返回：大于0保存成功，小于或等于0表示失败</returns>
        public virtual int Update(T t)
        {
            int flag = 0;//标识保存方法是否成功
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            object id = t.GetType().GetProperties()[0].GetValue(t, null);
            flag = ExecuteUpdate<T>(className + "_update", t);
            return flag;
        }
        /// <summary>
        /// 作者：鄢睿
        /// 功能：数据库访问的Insert方法
        /// 说明：
        ///     使用时Maps中的配置文件配置两条类名称+“_DELETE”的 statements
        ///     如：
        ///       <insert id="PLANTINFO_INSERT" parameterClass="PlantInfo">
        ///            INSERT INTO  PLANT_INFO VALUES( #Id#,#PlantCode#,#Name#,#Postcode#,#Location#,#Country#,#City#,#Timezone#,#Revenue#,#Street#,#Installdate#,#Operater#,#Email#,#Phone#,#Direction#,#Angle#,#Manufacturer#,#ModuleType#,#Pic#)
        ///             <selectKey resultClass="int" property="Id" type="post">
        ///             SELECT LAST_INSERT_ID() AS Id
        ///             </selectKey>
        ///       </insert> 
        ///      注意：在执行insert操作的时候Id列在数据库中必须是自增长的标识列
        /// 创建时间：2011-02-21
        /// </summary>
        /// <typeparam name="T">需要保存的对象类型</typeparam>
        /// <param name="t">需要保存的对象</param>
        /// <returns>返回：大于0保存成功，小于或等于0表示失败</returns>
        public virtual int Insert(T t)
        {
            int flag = 0;//标识保存方法是否成功
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            ExecuteInsert<T>(className + "_insert", t, out flag);
            return flag;
        }
        /// <summary>
        /// 批量插入对象
        /// </summary>
        /// <param name="tlist"></param>
        public virtual void BatchInsert(IList<T> tlist)
        {
            string className = null;
            IList<KeyValuePair<string, T>> kvList = new List<KeyValuePair<string, T>>();
            foreach (T t in tlist)
            {
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

        /// <summary>
        /// 作者：鄢睿
        /// 功能：数据库访问的Delete方法
        /// 说明：
        ///     使用时Maps中的配置文件配置一条statements类名称+“_DELETE”的 statements
        ///     如：
        ///       <delete id="PLANTINFO_DELETE"  resultMap="PlantInfoResult" parameterClass="int">
        ///       DELETE *  FROM  PLANT_INFO WHERE ID=#value#
        ///       </delete>
        /// 创建时间：2011-02-21
        /// </summary>
        /// <typeparam name="T">需要删除的对象类型</typeparam>
        /// <param name="t">需要删除的对象</param>
        /// <returns>返回：大于0删除成功，小于0删除失败</returns>
        public virtual int Remove(T t)
        {
            int flag = 0;//标识删除方法是否成功
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            flag = ExecuteDelete<T>(className + "_delete", t);
            return flag;
        }

        /// <summary>
        /// 作者：鄢睿
        /// 功能：数据库访问类的Select方法
        /// 说明：
        ///     使用时Maps中的配置文件配置一条类名称+“_GET”的 statements
        ///     如：
        ///       <select id="PLANTINFO_GET"  resultMap="PlantInfoResult" parameterClass="int">
        ///       SELECT *  FROM  PLANT_INFO WHERE ID=#value#
        ///       </select>
        /// 创建时间：2011-02-21
        /// </summary>
        /// <typeparam name="T">需要获得的对象类型</typeparam>
        /// <param name="id">通过id获得对象</param>
        /// <returns></returns>
        public virtual T Get(T t)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            //int id = int.Parse(t.GetType().GetProperty("id").GetValue(t, null).ToString());
            object id = t.GetType().GetProperties()[0].GetValue(t, null);
            try
            {
                t = ExecuteQueryForObject<T>(className + "_get", id);
            }
            catch
            {
                t = default(T);
            }
            return t;
        }


        /// <summary>
        /// 作者：鄢睿
        /// 功能：数据库访问类的Select方法
        /// 说明：
        ///     使用时Maps中的配置文件配置一条类名称+“_GET”的 statements
        ///     如：
        ///       <select id="PLANTINFO_GET"  resultMap="PlantInfoResult" parameterClass="int">
        ///       SELECT *  FROM  PLANT_INFO WHERE ID=#value#
        ///       </select>
        /// 创建时间：2011-02-21
        /// </summary>
        /// <typeparam name="T">需要获得的对象类型</typeparam>
        /// <param name="id">通过id获得对象</param>
        /// <returns></returns>
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
        public virtual IList<T> Getlist(Pager t)
        {
            string className = t.GetType().Name.ToLower();//传入对象的类型名称
            return ExecuteQueryForList<T>("loading_pager_page_list", t);
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

    }
}
