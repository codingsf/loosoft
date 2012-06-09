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

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;

/**
 * 
 * 专业对象的泛型DAO.
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-5-19
 */
@Component
public class SpecialtyDao extends HibernateDao<Specialty, Long> {
    private static final String DELETE_SCHAREAS = "delete from Specialty where id in(:ids)";

    /**
     * 批量删除系.
     */
    public void deleteSpecialtys(List<Long> ids) {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_SCHAREAS, map);
    }

    /**
     * 
     * 根据code key取得专业
     * @since  2010-8-21
     * @author houbing.qian
     * @param code
     * @return
     */
    public Specialty getByCode(String code){
        return super.findUniqueBy("code", code);
    }

    /**
     * 
     * 取得系下的专业
     * @since  2010-8-22
     * @author houbing.qian
     * @param instituteCode
     * @return
     */
    public List<Specialty> getSpecialtysByDepartment(String departmentCode){
        return super.findBy("department.code", departmentCode);
    }

    /**
     * 
     * 取得学院下的专业
     * @since  2010-8-22
     * @author houbing.qian
     * @param collegeCode
     * @return
     */
    public List<Specialty> getSpecialtysByCollege(Institute institute){
        return super.findBy("institute", institute);
    }
}
