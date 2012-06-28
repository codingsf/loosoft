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
package cn.loosoft.stuwork.workstudy.service.job;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudy.dao.job.JobsDao;
import cn.loosoft.stuwork.workstudy.dao.job.StudentjobsDao;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;

/**
 * 
 * 岗位类.
 * 
 * @author bing.hu
 * @since 2011-2-25
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class JobsManager extends EntityManager<Jobs, Long>
{

    JobsDao jobsDao;

    @Override
    protected HibernateDao<Jobs, Long> getEntityDao()
    {
        return jobsDao;
    }

    StudentjobsDao studentjobsDao;

    /**
     * 
     * 批量删除岗位.
     * 
     * @since 2011-2-23
     * @author bing.hu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        jobsDao.deletes(ids);
    }

    /**
     * 查询岗位对应的单位ID Description of this Method
     * 
     * @since 2011-3-3
     * @author bing.hu
     * @param id
     * @return List
     */
    public List<Jobs> findcompany(Long id)
    {
        return jobsDao.findcompany(id);
    }

    public Jobs findJobsById(Long id)
    {
        return jobsDao.findJobsById(id);
    }

    /**
     * 
     * 查询学院勤工助学中心审核通过的岗位信息
     * 
     * @since 2011-3-9
     * @author shanru.wu
     * @return List
     */
    public List<Jobs> findJobs()
    {
        return jobsDao.findJobs();
    }

    /**
     * 
     * 得到有分页条件的集合
     * 
     * @since 2011-4-17
     * @author yong.geng
     * @param pageNo
     * @return
     */
    public List<Jobs> getAllJobs(int pageNo)
    {
        return jobsDao.getAllJobs(pageNo);
    }

    @Override
    public void delete(Long id)
    {
        studentjobsDao.deleteByJobsID(id);
        super.delete(id);
    }

    @Autowired
    public void setJobsDao(JobsDao jobsDao)
    {
        this.jobsDao = jobsDao;
    }

    @Autowired
    public void setStudentjobsDao(StudentjobsDao studentjobsDao)
    {
        this.studentjobsDao = studentjobsDao;
    }

    public List<Jobs> findByCompanyIdAndExcludeJob(Long companyID, long id)
    {
        return jobsDao.findByCompanyIdAndExcludeJob(companyID, id);
    }
}
