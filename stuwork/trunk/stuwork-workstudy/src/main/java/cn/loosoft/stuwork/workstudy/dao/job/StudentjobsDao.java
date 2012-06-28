package cn.loosoft.stuwork.workstudy.dao.job;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.util.JdbcUtil;

/**
 * 
 * 审核DAO.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */
@Component
public class StudentjobsDao extends HibernateDao<StudentJobs, Long>
{
    private static final String DELETE_SCHAREAS = "delete from Jobs where id in(:ids)";

    /**
     * 批量删除职位.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_SCHAREAS, map);

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
        String hql = "select * from stujob_student_jobs where studentNo='"
                + studentNo + "'";
        if (startTime != null && stopTime != null)
        {
            hql += " and applyDate between '" + startTime + "'  and '"
                    + stopTime + "' limit " + ((pageNo * 20) - 20) + "," + 20;
        }
        else
        {
            hql += " limit " + ((pageNo * 20) - 20) + "," + 20;
        }
        List<StudentJobs> stuJobsList = new ArrayList<StudentJobs>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            conn = JdbcUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(hql);
            while (rs.next())
            {
                StudentJobs studentJobs = new StudentJobs();
                studentJobs.setStudentName(rs.getString("studentName"));
                studentJobs.setStudentNo(rs.getString("studentNo"));
                studentJobs.setJobsName(rs.getString("jobsName"));
                studentJobs.setApplyReason(rs.getString("applyReason"));
                studentJobs.setApplyDate(rs.getDate("applyDate"));
                stuJobsList.add(studentJobs);
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

        return stuJobsList;
    }

    /**
     * 查询学生申请岗位的总数 Description of this Method
     * 
     * @since 2011-4-20
     * @author bing.hu
     * @param examineeNo
     * @return
     */
    public List<StudentJobs> getAllStudentJobsCount(String studentNo,
            String startTime, String stopTime)
    {
        String hql = "from StudentJobs where studentNo='" + studentNo + "'";
        if (startTime != null && stopTime != null)
        {
            hql += "and applyDate between '" + startTime + "'  and '"
                    + stopTime + "'";
        }
        return super.find(hql);
    }

    public void deleteByJobsID(Long id)
    {
        String hql = "delete from StudentJobs where jobsID = ?";
        super.batchExecute(hql, id);
    }
}
