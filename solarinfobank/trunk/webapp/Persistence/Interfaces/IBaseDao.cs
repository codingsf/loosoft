using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Common;
using IBatisNet.Common.Pagination;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IBaseDao<T>
    {
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
        int Insert(T t);
        
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
        int Remove(T t);
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
        int Update(T t);
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
        T Get(T t);

        /// <summary>
        /// 作者：陈波
        /// 功能：数据库访问类的Select方法
        /// 说明：
        ///     使用时Maps中的配置文件配置一条类名称+"_GET_LIST"的 statements
        ///     如：
        ///       <select id="PLANTINFO__GET_LIST"  resultMap="PlantInfoResult" parameterClass="int">
        ///       SELECT *  FROM  PLANT_INFO WHERE ID=#value#
        ///       </select>
        /// 创建时间：2011-02-21
        /// </summary>
        /// <typeparam name="T">需要获得的对象类型</typeparam>
        /// <returns></returns>
        IList<T> Getlist(T t);

        IList<T> Getlist(T t, int skipResults,int maxResults);

        IPaginatedList Getlist(T t, int pageSize);

        IList<T> Getlist(Pager page);

        IList<T> Getlist(Hashtable page);
        /// <summary>
        /// 批量更新，做一个事务处理
        /// </summary>
        /// <param name="tlist"></param>
        void BatchUpdate(IList<T> tlist);
        /// <summary>
        /// 批量插入，做一个事务处理
        /// </summary>
        /// <param name="tlist"></param>
        void BatchInsert(IList<T> tlist);

    }
}
