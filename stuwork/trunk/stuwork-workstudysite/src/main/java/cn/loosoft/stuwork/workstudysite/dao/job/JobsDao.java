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
package cn.loosoft.stuwork.workstudysite.dao.job;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudysite.Constant;
import cn.loosoft.stuwork.workstudysite.entity.job.Jobs;

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

    // 查询学生要申请的岗位，条件：通过审核的，在招聘中的，并且没有申请的
    private static final String QUERY_JOBS      = "from Jobs where auditStatus='"
                                                        + Constant.SHTG
                                                        + "' and postStatus='"
                                                        + Constant.ZPZ
                                                        + "' and id not in (select jobsID from StudentJobs where examineeNo = ?)";

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

    // 查询学生要申请的岗位，条件：通过审核的，在招聘中的，并且没有申请的
    public Page<Jobs> findJobsByExamNO(Page<Jobs> page, String examNO)
    {

        return super.findPage(page, QUERY_JOBS, examNO);
    }
}
