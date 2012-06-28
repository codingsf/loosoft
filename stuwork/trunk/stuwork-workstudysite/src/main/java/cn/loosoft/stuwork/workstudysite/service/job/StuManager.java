package cn.loosoft.stuwork.workstudysite.service.job;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.workstudysite.dao.job.StuDao;
import cn.loosoft.stuwork.workstudysite.entity.job.StudentJobs;

/**
 * 
 * 学生-岗位管理类.
 * 
 * @author yong.geng
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StuManager extends EntityManager<StudentJobs, Long>
{

    private StuDao stuDao;

    @Override
    protected HibernateDao<StudentJobs, Long> getEntityDao()
    {
        return stuDao;
    }

    /**
     * 
     * 得到学生-岗位表里面，所以选择这个岗位的记录
     * 
     * @since 2011-2-28
     * @author yong.geng
     * @param postId
     * @return
     */
    public List<StudentJobs> findByPostId(int postId)
    {
        return stuDao.findByPostId(postId);
    }

    /**
     * 
     * 根据考生号查询某个学生申请的岗位信息
     * 
     * @since 2011-3-13
     * @author shanru.wu
     * @param examineeNo
     * @return
     */
    public List<StudentJobs> findStuJobs(String examineeNo)
    {
        return stuDao.findStuJobs(examineeNo);
    }

    /**
     * 
     * 根据ID查询学生岗位信息
     * 
     * @since 2011-3-13
     * @author shanru.wu
     * @param id
     * @return
     */
    public StudentJobs getStudentJobs(Long id)
    {
        return stuDao.getStudentJobs(id);
    }

    /**
     * 
     * 得到学生-岗位表里面，这个学生，这个岗位的记录
     * 
     * @since 2011-2-28
     * @author yong.geng
     * @param postId
     *            ：岗位id
     * @param ExamNo
     *            ：学生考试号
     * @return StuJobs
     */
    public StudentJobs findByPostIdAndExamNO(int postId, String ExamNo)
    {
        return stuDao.findByPostIdAndExamNO(postId, ExamNo);
    }

    /**
     * 
     * 查询审核状态为 "审核中" 的学生申请岗位信息
     * 
     * 
     * @since 2011-2-28
     * @author shanru.wu
     * @param page
     * @return
     */
    public List<StudentJobs> find()
    {
        return stuDao.find();
    }

    /**
     * 
     * 根据单位id，得到StudentJobs列表
     * 
     * @since 2011-3-4
     * @author yong.geng
     * @param compId
     * @return
     */
    public List<StudentJobs> findByCompId(int compId)
    {
        return stuDao.findByCompId(compId);
    }

    @Autowired
    public void setStuDao(StuDao stuDao)
    {
        this.stuDao = stuDao;
    }

}
