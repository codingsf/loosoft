using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    /// <summary>
    /// 功能：实现电站信息接口
    /// 作者：张月
    /// 时间：2011年2月16日 16:16:12
    /// </summary>
    public class PlantSqlMapDao : BaseSqlDao<Plant>, IPlantDao
    {
        /// <summary>
        /// 获取所有的电站
        /// </summary>
        /// <returns></returns>
        public IList<Plant> GetPlantInfoList()
        {
            return ExecuteQueryForList<Plant>("plant_get_all", null);
        }

        /// <summary>
        /// 获取制定数量的电站
        /// </summary>
        /// <returns></returns>
        public IList<Plant> GetPlantInfoList(int top, string order)
        {
            Hashtable whereHas = new Hashtable();
            whereHas.Add("top", top);
            whereHas.Add("order", order);
            return ExecuteQueryForList<Plant>("plant_list_top", whereHas);
        }
        /// <summary>
        /// 功能：获取电站的个数
        /// </summary>
        /// <returns></returns>
        public int GetPlantNum()
        {
            return (int)ExecuteQueryForObject("plant_get_all_num", null);
        }
        /// <summary>
        /// 功能：修改电站图片
        /// </summary>
        /// <param name="plant">电站实体</param>
        /// <returns></returns>
        public int ModifyPlantPic(Plant plant)
        {
            return ExecuteUpdate<Plant>("plant_update_pic", plant);
        }

        public IList<Plant> GetPlantsByPage(Pager page)
        {
            page.RecordCount = (int)ExecuteQueryForObject("loading_plant_page_count", page);
            return ExecuteQueryForList<Plant>("loading_plant_page_list", page);
        }



        #region IPlantDao 成员


        public IList<Plant> QueryPagePlants(Hashtable table)
        {
            Pager page = (table["page"] as Pager);
            page.RecordCount = (int)ExecuteQueryForObject("admin_plant_query_list_count", table);
            return ExecuteQueryForList<Plant>("admin_plant_query_list", table);
        }

        #endregion


        public IList<Plant> Getplantlikepname(string name)
        {
            return ExecuteQueryForList<Plant>("plant_get_list_like_pname", name);
        }

        public int UpdataWarningLastSendTime(int pid, DateTime updateTime)
        {
            Hashtable table = new Hashtable();
            table.Add("pid", pid);
            table.Add("updatetime", updateTime);
            return ExecuteUpdate("update_plant_warning_lasttime", table);

        }

        #region IPlantDao 成员

        /// <summary>
        /// 待补充,根据用户id取得电站，那些电站？
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public IList<Plant> VirtualplantGetUid(string uid)
        {
            return ExecuteQueryForList<Plant>("virtualplant_get_uid", uid);
        }

        /// <summary>
        /// 批量清楚原有父电站为空
        /// </summary>
        /// <param name="parentId"></param>
        /// <returns></returns>
        public int UpdateParentId(int parentId)
        {
            return ExecuteUpdate("plant_update_parentid", parentId);
        }

        #endregion
    }
}
