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

package cn.loosoft.stuwork.backmanage.dao.school;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;

/**
 * 
 * 班级的泛型DAO.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-21
 */
@Component
public class ClazzDao extends HibernateDao<Clazz, Long>
{
    private static final String DELETE_SCHAREAS             = "delete from Clazz where id in(:ids)";

    private static final String GET_CLAZZSBYSPECIALTY       = "from Clazz where specialty=? and type=? and year=? and season=?";

    private static final String GET_CLAZZSBYSPECIALTYNOTYPE = "from Clazz where specialty=? and year=? and season=?";

    private static final String GETCLAZZBYNAME              = "from Clazz where name=? and type=? and year=? and season=?";

    private static final String GET_CLAZZBYNAME             = "from Clazz where name=? and specialty=? and year=? and season=?";

    /**
     * 批量删除系.
     */
    public void deleteClazzs(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_SCHAREAS, map);
    }

    /**
     * 
     * 根据专业，类别，入学年份和入学季节
     * 
     * @since 2010-9-2
     * @author houbing.qian
     * @param specialtyCode
     * @param type
     * @param year
     * @param season
     * @return
     */
    public List<Clazz> getClazzsBySpecialty(Specialty specialty, String type,
            String year, String season)
    {
        if (StringUtils.isEmpty(type))
        {
            return super.find(GET_CLAZZSBYSPECIALTYNOTYPE, specialty, year,
                    season);
        }
        else
        {
            return super.find(GET_CLAZZSBYSPECIALTY, specialty, type, year,
                    season);
        }
    }

    /**
     * 
     * 根据班级名称，入学年份和季节取得班级代码
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @param name
     * @param year
     * @param season
     * @return
     */
    public Clazz getClazzByName(String name, String type, String year,
            String season)
    {
        return super.findUnique(GETCLAZZBYNAME, name, type, year, season);
    }

    /**
     * 
     * 根据班级名称，专业，入学年份和季节取得班级代码
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @param name
     * @param year
     * @param season
     * @return
     */
    public Clazz getClazzByName(Specialty specialty, String name, String year,
            String season)
    {
        return super.findUnique(GET_CLAZZBYNAME, name, specialty, year, season);
    }

    /**
     * 
     * 统计班级数量
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param code
     *            班级代码
     * @return
     */
    public long count(String code)
    {
        return super.countHqlResult("from Clazz where code=?", code);
    }
}
