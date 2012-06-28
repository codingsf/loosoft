package cn.loosoft.stuwork.workstudysite.dao.job;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudysite.entity.job.StudentJobs;

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

}
