package cn.loosoft.stuwork.backmanage.dao.account;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.backmanage.entity.account.User;

/**
 * 用户对象的泛型DAO类.
 * 
 * @author houbing.qian
 */
@Component
public class UserDao extends HibernateDao<User, Long>
{

    private static final String GETSTUDENTUSER_BYLOGINNAME = "from User where loginName=?";

    /**
     * 
     * 根据登录名称取得用户
     * 
     * @since 2010-8-27
     * @author houbing.qian
     * @param loginName
     *            登录名
     * @return
     */
    public User get(String loginName)
    {
        return super.findUniqueBy("loginName", loginName);
    }

    /**
     * 
     * 根据登录名称取得学生用户
     * 
     * @since 2011-4-15
     * @author shanru.wu
     * @param loginName
     *            登录名
     * @return
     */
    public User getStudentUser(String loginName)
    {
        return super.findUnique(GETSTUDENTUSER_BYLOGINNAME, loginName);
    }

}
