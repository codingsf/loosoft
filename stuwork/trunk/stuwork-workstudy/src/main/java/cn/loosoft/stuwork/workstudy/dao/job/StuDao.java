package cn.loosoft.stuwork.workstudy.dao.job;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.util.JdbcUtil;

/**
 * 
 * 学生-岗位泛型DAO.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-2-24
 */
@Component
public class StuDao extends HibernateDao<StudentJobs, Long>
{
    private static final String SEARCH_STUJOB_BYJOBID          = "from StudentJobs where jobsID = ? and centerStatus = 'shtg'";

    private static final String SEARCH_STUJOB_BYJOBIDANDSTUDENTNO = "from StudentJobs where jobsID = ? and studentNo = ?";

    private static final String QUERYJOBSBY_EXAMINEENO         = "from StudentJobs where examineeNo = ?";

    private static final String QUERYJOBSBY_ID                 = "from StudentJobs where id = ?";

    // 等后台权限做好了，用这个带id的
    // private static final String SEARCH_STUJOB_BYCOMPANYID = "from StudentJobs
    // where companyId = ? and chose = 'apply'";

    private static final String SEARCH_STUJOB_BYCOMPANYID      = "from StudentJobs where chose = 'apply'";

    /**
     * 
     * 得到学生-岗位表里面，所有选择这个岗位的所有记录条数。给commonpage使用
     * 
     * @since 2011-4-14
     * @author Administrator
     * @param postId
     * @return
     */
    public int findCountByPostId(long postId)
    {
        List<StudentJobs> list = super.find(SEARCH_STUJOB_BYJOBID, postId);
        return list.size();
    }

    /**
     * 
     * 得到学生-岗位表里面，所有选择这个岗位的记录
     * 
     * @since 2011-2-28
     * @author yong.geng
     * @param postId
     * @return
     */
    public List<StudentJobs> findByPostId(int postId, int pageNo)
    {

        String sql = "select * from stujob_student_jobs where jobsID = "
                + postId + " and centerStatus = 'shtg' limit "
                + ((pageNo * 20) - 20) + "," + 20;

        List<StudentJobs> list = new ArrayList<StudentJobs>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            conn = JdbcUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                StudentJobs sj = new StudentJobs();
                sj.setStudentNo(rs.getString("studentNo"));
                list.add(sj);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            JdbcUtil.release(rs, stmt, conn);
        }
        return list;
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
        return super.findUnique(QUERYJOBSBY_ID, id);
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
    public List<StudentJobs> findByPostIdAndStudentNO(long postId, String studentNo)
    {
        List<StudentJobs> stuJobs = super.find(SEARCH_STUJOB_BYJOBIDANDSTUDENTNO,
                postId, studentNo);
        return stuJobs;
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
        String hql = "from StuJobs where groupstate='" + Constant.SHZ + "'";
        return super.find(hql);
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
        return super.find(QUERYJOBSBY_EXAMINEENO, examineeNo);
    }

    /**
     * 
     * 根据单位id，得到StudentJobs列表，状态必须是确定用工的。chose=apply
     * 
     * @since 2011-3-4
     * @author yong.geng
     * @param compId
     * @return
     */
    public List<StudentJobs> findByCompId(int compId)
    {
        // 等后台权限做好了，用这个带id的
        // List<StudentJobs> list = super.find(SEARCH_STUJOB_BYCOMPANYID,
        // compId);
        List<StudentJobs> list = super.find(SEARCH_STUJOB_BYCOMPANYID);
        return list;
    }
}
