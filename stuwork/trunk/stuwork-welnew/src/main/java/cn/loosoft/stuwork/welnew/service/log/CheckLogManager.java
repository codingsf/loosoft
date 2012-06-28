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
package cn.loosoft.stuwork.welnew.service.log;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.log.CheckLogDao;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.CheckLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.vo.CheckCountVO;

import com.google.common.collect.Lists;

/**
 * 
 * 审查记录的管理类.
 * 
 * @author shanru.wu
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class CheckLogManager extends EntityManager<CheckLog, Long>
{
    CheckLogDao        checkLogDao;

    @Autowired
    private StudentDao studentDao;

    /**
     * 
     * 根据考生号以及审查项目编号查询
     * 
     * @since 2011-1-21
     * @author shanru.wu
     * @param studentNo
     * @param checkItemId
     * @return
     */
    public CheckLog getCheckLog(String examineeNo, int checkItemId)
    {
        return checkLogDao.getCheckLog(examineeNo, checkItemId);
    }

    /**
     * 
     * 查询审查未通过的审查项目ID
     * 
     * @since 2011-1-21
     * @author shanru.wu
     * @param studentNo
     * @param checkItemId
     * @return
     */
    public List<Long> getNoPassCheckItemIds()
    {
        return checkLogDao.getNoPassCheckItemIds();
    }

    public long countNoCheckStudent(String collegeCode, Welbatch welbatch)
    {
        return checkLogDao.countNoCheckStudent(collegeCode, welbatch);
    }

    public List<CheckCountVO> getCheckCounts(Welbatch welbatch)
    {

        List<CheckCountVO> checkCountVOs = Lists.newArrayList();
        if (welbatch != null)
        {
            List<Student> students = studentDao
            .getGroupStudentsByMajor(welbatch);

            if (!students.isEmpty())
            {
                CheckCountVO checkCountVO = null;
                for (Student student : students)
                {
                    checkCountVO = new CheckCountVO();
                    checkCountVO.setName(student.getCollegeName());

                    checkCountVO.setAllCount(studentDao.countStudent(student
                            .getCollegeCode(), welbatch, true));

                    checkCountVO.setPassCount(studentDao.countChechPassStudent(
                            student.getCollegeCode(), welbatch));

                    checkCountVO.setNoCheckCount(countNoCheckStudent(student
                            .getCollegeCode(), welbatch));

                    checkCountVO.setUnpassCount(checkCountVO.getAllCount()
                            - checkCountVO.getPassCount()
                            - checkCountVO.getNoCheckCount());
                    try
                    {
                        checkCountVO.setPassRate(new DecimalFormat("0.00 ")
                        .format((float) checkCountVO.getPassCount()
                                * 100 / checkCountVO.getAllCount()));
                    }
                    catch (Exception e)
                    {
                        checkCountVO.setPassRate("0.00");
                    }

                    checkCountVOs.add(checkCountVO);
                }
            }
        }
        return checkCountVOs;
    }

    @Autowired
    public void setCheckLogDao(CheckLogDao checkLogDao)
    {
        this.checkLogDao = checkLogDao;
    }

    @Override
    protected HibernateDao<CheckLog, Long> getEntityDao()
    {
        return checkLogDao;
    }

}