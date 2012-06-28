package cn.loosoft.stuwork.workstudy.service.job;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudy.dao.job.StudentjobsDao;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;

/**
 * 
 * 审核类.
 * 
 * @author bing.hu
 * @since 2011-2-28
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StudentjobsManager extends EntityManager<StudentJobs, Long>
{

    private StudentjobsDao studentjobsDao;

    @Override
    protected HibernateDao<StudentJobs, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return studentjobsDao;
    }

    /**
     * 
     * 批量删除审批.
     * 
     * @since 2011-2-28
     * @author bing.hu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        studentjobsDao.deletes(ids);
    }

    /**
     * 根据时间段来查询学生申请岗位信息 Description of this Method
     * 
     * @since 2011-4-20
     * @author bing.hu
     * @param startTime
     * @param stopTime
     * @return
     */
    public List<StudentJobs> getStudentJobsByApply(String studentNo,
            String startTime, String stopTime, int pageNo)
    {
        return studentjobsDao.getStudentJobsByApply(studentNo, startTime,
                stopTime, pageNo);
    }

    public List<StudentJobs> getAllStudentJobsCount(String studentNo,
            String startTime, String stopTime)
    {
        return studentjobsDao.getAllStudentJobsCount(studentNo, startTime,
                stopTime);
    }

    @Autowired
    public void setStudentjobsdao(StudentjobsDao studentjobsdao)
    {
        this.studentjobsDao = studentjobsdao;
    }

}
