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
package cn.loosoft.stuwork.welnew.service.welnewlocale;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.common.lib.springside.orm.ExtPropertyFilter;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.log.DevolverLogDao;
import cn.loosoft.stuwork.welnew.dao.welnewlocale.SchoolNoticeDao;
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.entity.welnewlocale.SchoolNotice;

/**
 * 
 * 学院报到管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class SchoolNoticeManager extends EntityManager<SchoolNotice, Long>
{

    private SchoolNoticeDao schoolNoticeDao;

    private DevolverLogDao  devolverLogDao;

    /**
     * 
     * 根据考试号查询是否报到
     * 
     * @since 2011-1-17
     * @author Administrator
     * @param examineeNo
     * @return
     */
    public SchoolNotice getSchoolNotice(String examineeNo)
    {
        return schoolNoticeDao.findUniqueBy("student.examineeNo", examineeNo);
    }

    public Page<SchoolNotice> searchPage(Page<SchoolNotice> page,
            List<ExtPropertyFilter> filters)
            {
        return schoolNoticeDao.extFindPage(page, filters);
            }

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
    // return schoolNoticeDao.search(page, examineeNo, name, batchId,
    // collegeCode, majorCode, classCode);
    // }
    @Autowired
    public void setSchoolNoticeDao(SchoolNoticeDao schoolNoticeDao)
    {
        this.schoolNoticeDao = schoolNoticeDao;
    }

    @Autowired
    public void setDevolverLogDao(DevolverLogDao devolverLogDao)
    {
        this.devolverLogDao = devolverLogDao;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-1-17
     * @see cn.loosoft.springside.service.EntityManager#getEntityDao()
     */
    @Override
    protected HibernateDao<SchoolNotice, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return schoolNoticeDao;
    }

    public void saveAndDevolverLog(SchoolNotice schoolNotice,
            List<DevolveItem> devolveItems, Student student, String userName)
    {
        schoolNoticeDao.save(schoolNotice);

        DevolverLog devolverLog = null;
        for (DevolveItem devolveItem : devolveItems)
        {
            devolverLog = new DevolverLog();
            devolverLog.setStudentNo(student.getExamineeNo()); // 学号

            devolverLog.setDevolverId(devolveItem.getId()); // 转移项目编号

            devolverLog.setDevolverTime(new Date()); // 转移时间

            devolverLog.setOperater(userName); // 操作人

            devolverLogDao.save(devolverLog);
        }
    }
}
