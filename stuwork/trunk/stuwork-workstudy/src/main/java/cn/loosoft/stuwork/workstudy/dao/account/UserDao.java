package cn.loosoft.stuwork.workstudy.dao.account;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudy.entity.account.User;

/**
 * 用户对象的泛型DAO类.
 * 
 * @author shanru.wu
 */
@Component
public class UserDao extends HibernateDao<User, Long>
{

    /**
     * 
     * 根据登录名称取得用户
     * 
     * @since 2011-3-9
     * @author shanru.wu
     * @param loginName
     *            登录名
     * @return
     */
    public User get(String loginName)
    {
        return super.findUniqueBy("loginName", loginName);
    }
    
    /**
     * 查询此用户对应的单位ID
     * Description of this Method
     * @since  2011-3-16
     * @author bing.hu
     * @param companyId
     * @return
     */
    public List<User> findCompanyId(Long companyId)
    {
        return super.find("from User where company=" + companyId);

    }
}
