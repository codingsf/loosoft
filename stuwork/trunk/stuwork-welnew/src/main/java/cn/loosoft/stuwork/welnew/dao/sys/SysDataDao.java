package cn.loosoft.stuwork.welnew.dao.sys;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.sys.SysData;

/**
 * 
 * 基础数据DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Component
public class SysDataDao extends HibernateDao<SysData, Long>
{
    private static final String DELETE_STUDENT = "delete from SysData where id in(:ids)";

    /**
     * 批量删除基础数据.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STUDENT, map);
    }

    /**
     * 根据类型查询.
     */
    public Page<SysData> search(Page<SysData> page, String type)
    {
        StringBuffer hql = new StringBuffer("from SysData where 1=1");
        Map<String, Object> values = new HashMap<String, Object>();
        hql.append(" and type=:type");
        values.put("type", type);
        hql.append(" order by ").append(page.getOrderBy()).append(" ").append(
                page.getOrder());
        return super.findPage(page, hql.toString(), values);
    }

}
