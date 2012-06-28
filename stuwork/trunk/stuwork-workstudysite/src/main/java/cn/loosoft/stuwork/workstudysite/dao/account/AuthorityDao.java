/**
 * 
 */
package cn.loosoft.stuwork.workstudysite.dao.account;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudysite.entity.account.Authority;

/**
 * 授权对象的泛型DAO.
 * 
 * @author shanru.wu
 */
@Component
public class AuthorityDao extends HibernateDao<Authority, Long>
{

}
