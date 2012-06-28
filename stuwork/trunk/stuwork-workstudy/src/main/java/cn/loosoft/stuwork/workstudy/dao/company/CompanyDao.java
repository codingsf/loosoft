package cn.loosoft.stuwork.workstudy.dao.company;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudy.entity.company.Company;

/**
 * 
 * 单位的泛型DAO.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */

@Component
public class CompanyDao extends HibernateDao<Company, Long>
{
    private static final String DELETE_SCHAREAS = "delete from Company where id in(:ids)";

    /**
     * 批量删除职位.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_SCHAREAS, map);

    }

}
