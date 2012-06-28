//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
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
package cn.loosoft.stuwork.welnew.dao.welnewlocale;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import cn.common.lib.springside.orm.BaseHibernateDao;
import cn.common.lib.springside.orm.ExtPropertyFilter;
import cn.loosoft.stuwork.welnew.entity.welnewlocale.SchoolNotice;

/**
 * 
 * 学院报道DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-01-17
 */
@Component
public class SchoolNoticeDao extends BaseHibernateDao<SchoolNotice, Long>
{

    /**
     * 自定义查询方法 Description of this Method
     * 
     * @since 2011-3-30
     * @author bing.hu
     * @param page
     * @param examineeNo
     * @param name
     * @param batchId
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @return
     */
    // public Page<SchoolNotice> search(Page<SchoolNotice> page,
    // String examineeNo, String name, Long batchId, String collegeCode,
    // String majorCode, String classCode)
    // {
    // String hql = "from SchoolNotice where 1=1";
    // if (null != examineeNo && examineeNo != "")
    // {
    // hql += " and student.examineeNo='" + examineeNo + "'";
    // }
    // if (null != name && name != "")
    // {
    // hql += " and student.name='" + name + "'";
    // }
    // if (null != batchId)
    // {
    // hql += " and student.welbatch.id='" + batchId + "'";
    // }
    // if (null != collegeCode && collegeCode != "")
    // {
    // hql += " and student.collegeCode='" + collegeCode + "'";
    // }
    // if (null != majorCode && majorCode != "")
    // {
    // hql += " and student.majorCode='" + majorCode + "'";
    // }
    // if (null != classCode && classCode != "")
    // {
    // hql += " and student.classCode='" + classCode + "'";
    // }
    //
    // return super.findPage(page, hql);
    // }

    public Page<SchoolNotice> searchPage(List<ExtPropertyFilter> filters,
            Page<SchoolNotice> page)
    {
        return super.extFindPage(page, filters);
    }

    /**
     * 分组查询所有报道的学生 Description of this Method
     * 
     * @since 2011-3-31
     * @author bing.hu
     * @param page
     * @return
     */
    public Page<SchoolNotice> Internotice(Page<SchoolNotice> page)
    {

        return super
                .findPage(
                        page,
                        "collegeName,count(*) from Student as s,SchoolNotice as h where s.examineeNo=h.examineeNo group by s.collegeCode");

    }
}
