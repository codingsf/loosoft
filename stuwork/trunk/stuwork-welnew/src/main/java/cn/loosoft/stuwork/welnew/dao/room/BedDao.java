//-------------------------------------------------------------------------
// Copyright (c) 2009-2012 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------

package cn.loosoft.stuwork.welnew.dao.room;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.room.Bed;

/**
 * 
 * 分配给院系的床位信息的泛型DAO.
 * 
 * @author houbing.qian
 * @author shanru.wu
 * @version 1.0
 * @since 2010-8-24
 */
@Component
public class BedDao extends HibernateDao<Bed, Long>
{
    private static final String DELETE_STUDENT = "delete from Bed where id in(:ids)";

    /**
     * 批量删除床位.
     */
    public void deleteBeds(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STUDENT, map);
    }

    /**
     * 
     * 取得床位列表
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @param isAssigned
     * @return
     */
    public List<Bed> getBeds(String collegeCode, String majorCode,
            String classCode, int isAssigned)
            {
        String hql = "";
        StringBuilder propertySB = new StringBuilder("");
        Map<String, Object> valueMap = new HashMap<String, Object>();
        if (!StringUtils.isEmpty(collegeCode))
        {
            propertySB.append(" and collegeCode=:collegeCode ");
            valueMap.put("collegeCode", collegeCode);
        }
        if (!StringUtils.isEmpty(majorCode))
        {
            propertySB.append(" and majorCode=:majorCode ");
            valueMap.put("majorCode", majorCode);
        }
        if (!StringUtils.isEmpty(classCode))
        {
            propertySB.append(" and classCode=:classCode ");
            valueMap.put("classCode", classCode);
        }
        if (isAssigned != -1)
        {
            propertySB.append(" and isAssigned=:assigned");
            valueMap.put("assigned", isAssigned);
        }

        hql = "from Bed "
            + (propertySB.length() > 0 ? (" where 1=1 " + propertySB
                    .substring(1)) : "")
                    + " order by collegeCode , majorCode,classCode,room,bedNo asc";
        return super.find(hql, valueMap);
            }

    /**
     * 
     * 取得班级的未分配床位<br>
     * 按照院系，专业，班级和床位的升序排列的
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @return
     */
    public Bed getUnassignedBed(String collegeCode, String majorCode,
            String classCode)
    {
        // Boolean isAssigned = Boolean.FALSE;
        int isAssigned = 0;
        List<Bed> beds = this.getBeds(collegeCode, majorCode, classCode,
                isAssigned);
        if (!beds.isEmpty())
        {
            return beds.get(0);
        }
        return null;
    }

    /**
     * 
     * 判断是否存在
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param building
     * @param room
     * @param bedNo
     * @return
     */
    public boolean exist(String building, String room, String bedNo)
    {
        long res = super.countHqlResult(
                "from Bed where building=? and room=? and bedNo=?", building,
                room, bedNo);
        return res > 0 ? true : false;
    }

    /**
     * 
     * 计算床位总数
     * 
     * @since 2010-12-2
     * @author shanru.wu
     * @return
     */
    public long countBed(String collegeCode, String majorCode, String classCode)
    {
        if (StringUtils.isNotEmpty(classCode))
        {
            return super
            .countHqlResult(
                    "from Bed where collegeCode=? and majorCode=? and classCode=?",
                    collegeCode, majorCode, classCode);
        }
        else
        {
            return super.countHqlResult(
                    "from Bed where collegeCode=? and majorCode=?",
                    collegeCode, majorCode);
        }
    }

    /**
     * 
     *计算未分配的床位总数
     * 
     * @since 2010-12-2
     * @author shanru.wu
     * @return
     */
    public long unassignBed(String collegeCode, String majorCode,
            String classCode, int isAssigned)
    {
        if (StringUtils.isNotEmpty(classCode))
        {
            return super
            .countHqlResult(
                    "from Bed where collegeCode=? and majorCode=? and classCode=? and isAssigned=?",
                    collegeCode, majorCode, classCode, isAssigned);
        }
        else
        {
            return super
            .countHqlResult(
                    "from Bed where collegeCode=? and majorCode=? and isAssigned=?",
                    collegeCode, majorCode, isAssigned);
        }
    }
}
