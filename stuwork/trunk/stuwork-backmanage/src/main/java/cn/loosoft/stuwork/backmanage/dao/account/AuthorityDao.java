/**
 * 
 */
package cn.loosoft.stuwork.backmanage.dao.account;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.backmanage.entity.account.Authority;

/**
 * 授权对象的泛型DAO.
 * 
 * @author houbing.qian
 */
@Component
public class AuthorityDao extends HibernateDao<Authority, Long>
{

}
