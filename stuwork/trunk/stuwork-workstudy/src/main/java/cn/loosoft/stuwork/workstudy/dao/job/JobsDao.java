//-------------------------------------------------------------------------
//Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
//This software is the confidential and proprietary information of
//Digital
//
//Original author: Administrator
//
//-------------------------------------------------------------------------
//LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
//THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
//TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
//LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
//MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
//THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
//CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
//PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
//NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
//SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
//SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
//PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
//SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
//HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
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

import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.util.JdbcUtil;

/**
 * 
 * 岗位的泛型DAO.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-25
 */
@Component
public class JobsDao extends HibernateDao<Jobs, Long>
{
    private static final String DELETE_SCHAREAS = "delete from Jobs where id in(:ids)";

    private static final String QUERY_JOBS      = "from Jobs where auditstatus='"
                                                        + Constant.SHTG + "'";

    private static final String QUERY_JOBSBYID  = "from Jobs where id=?";

    /**
     * 批量删除职位.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_SCHAREAS, map);

    }

    /**
     * 根据主键ID获取岗位
     */
    public Jobs findJobsById(Long id)
    {
        return super.findUnique(QUERY_JOBSBYID, id);
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
        return super.find("from Jobs where company=" + id);
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
        return super.find(QUERY_JOBS);
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
        String sql = "select * from stujob_jobs where postStatus = 'zpz' and auditStatus = 'shtg'limit "
                + ((pageNo * 20) - 20) + "," + 20;

        List<Jobs> list = new ArrayList<Jobs>();
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
                Jobs job = new Jobs();
                job.setId(rs.getLong("id"));
                job.setPostName(rs.getString("postName"));
                job.setSexLimit(rs.getString("sexLimit"));
                job.setAddress(rs.getString("address"));
                job.setContent(rs.getString("content"));
                job.setRequireMents(rs.getString("requireMents"));
                job.setPubdate(rs.getDate("pubdate"));
                job.setStopdate(rs.getDate("stopdate"));
                job.setReqCount(rs.getInt("reqCount"));
                job.setExisitCount(rs.getInt("exisitCount"));

                list.add(job);
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

    public List<Jobs> findByCompanyIdAndExcludeJob(Long companyID, long id)
    {
        return super.find("from Jobs where company=" + companyID + "and id <> "
                + id);
    }
}
