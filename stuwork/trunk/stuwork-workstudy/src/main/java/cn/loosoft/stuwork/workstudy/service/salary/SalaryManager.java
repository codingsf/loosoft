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
package cn.loosoft.stuwork.workstudy.service.salary;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudy.dao.salary.SalaryDao;
import cn.loosoft.stuwork.workstudy.entity.salary.Salary;

/**
 * 
 * 工资管理类.
 * 
 * @author yong.geng
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class SalaryManager extends EntityManager<Salary, Long>
{
    private SalaryDao salaryDao;

    @Override
    protected HibernateDao<Salary, Long> getEntityDao()
    {
        return salaryDao;
    }

    @Autowired
    public void setSalaryDao(SalaryDao salaryDao)
    {
        this.salaryDao = salaryDao;
    }

    /**
     * 通过考生号查询学生工资信息 Description of this Method
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param examineeNo
     * @return
     */
    public List<Salary> getByStudentNo(String examineeNo)
    {
        return salaryDao.getByStudentNo(examineeNo);
    }

    /**
     * 根据学生考生号查询学生工资信息，并给予分页 Description of this Method
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param studentNo
     * @param pageNo
     * @return
     */
    public List<Salary> getSalaryByStudentNo(String studentNo, int pageNo)
    {
        return salaryDao.getSalaryByStudentNo(studentNo, pageNo);
    }

    public Salary getSalaryById(Long id)
    {
        return salaryDao.getSalaryById(id);
    }

}
