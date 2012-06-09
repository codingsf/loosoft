package cn.loosoft.stuwork.backmanage.service.account;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.springside.service.ServiceException;
import cn.loosoft.stuwork.backmanage.dao.account.AuthorityDao;
import cn.loosoft.stuwork.backmanage.dao.account.RoleDao;
import cn.loosoft.stuwork.backmanage.dao.account.StudentUserDao;
import cn.loosoft.stuwork.backmanage.dao.account.UserDao;
import cn.loosoft.stuwork.backmanage.entity.account.Authority;
import cn.loosoft.stuwork.backmanage.entity.account.Role;
import cn.loosoft.stuwork.backmanage.entity.account.User;

/**
 * 安全相关实体的管理类, 包括用户,角色,资源与授权类.
 * 
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class AccountManager
{

    private static Logger logger = LoggerFactory
                                         .getLogger(AccountManager.class);

    private UserDao       userDao;

    private RoleDao       roleDao;

    private AuthorityDao  authorityDao;

    // -- User Manager --//
    @Transactional(readOnly = true)
    public User getUser(Long id)
    {
        return userDao.get(id);
    }

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
    public User getUser(String loginName)
    {
        return userDao.get(loginName);
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
        return userDao.getStudentUser(loginName);
    }

    public void saveUser(User entity)
    {
        userDao.save(entity);
    }

    /**
     * 删除用户,如果尝试删除超级管理员将抛出异常.
     */
    public void deleteUser(Long id)
    {
        if (isSupervisor(id))
        {
            logger.warn("操作员{}尝试删除超级管理员用户", SpringSecurityUtils
                    .getCurrentUserName());
            throw new ServiceException("不能删除超级管理员用户");
        }
        userDao.delete(id);
    }

    /**
     * 判断是否超级管理员.
     */
    private boolean isSupervisor(Long id)
    {
        return id == 1;
    }

    /**
     * 使用属性过滤条件查询用户.
     */
    @Transactional(readOnly = true)
    public Page<User> searchUser(final Page<User> page,
            final List<PropertyFilter> filters)
    {
        return userDao.findPage(page, filters);
    }

    @Transactional(readOnly = true)
    public User findUserByLoginName(String loginName)
    {
        return userDao.findUniqueBy("loginName", loginName);
    }

    @Transactional(readOnly = true)
    public List<User> findUsersByName(String name)
    {
        return userDao.findBy("name", name);
    }

    /**
     * 检查用户名是否唯一.
     * 
     * @return loginName在数据库中唯一或等于oldLoginName时返回true.
     */
    @Transactional(readOnly = true)
    public boolean isLoginNameUnique(String newLoginName, String oldLoginName)
    {
        return userDao
                .isPropertyUnique("loginName", newLoginName, oldLoginName);
    }

    /**
     * 
     * 批量删除角色.
     * 
     * @since 2011-2-24
     * @author shanru.wu
     * @param ids
     */
    public void deleteRoles(List<Long> ids)
    {
        roleDao.deleteRoles(ids);
    }

    // -- Role Manager --//
    @Transactional(readOnly = true)
    public Role getRole(Long id)
    {
        return roleDao.get(id);
    }

    @Transactional(readOnly = true)
    public List<Role> getAllRole()
    {
        return roleDao.getAll("id", true);
    }

    public void saveRole(Role entity)
    {
        roleDao.save(entity);
    }

    public void deleteRole(Long id)
    {
        roleDao.delete(id);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getAllAuthority()
    {
        return authorityDao.getAll();
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getBackAuthority()
    {
        String str = "from Authority where name like '后台%'";
        return authorityDao.find(str);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getArchivesAuthority()
    {
        String str = "from Authority where name like '档案%'";
        return authorityDao.find(str);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getStuinfoAuthority()
    {
        String str = "from Authority where name like '学生信息%'";
        return authorityDao.find(str);
    }

    @Transactional(readOnly = true)
    public List<Authority> getSelfhelpAuthority()
    {
        String str = "from Authority where name like '学生自助%'";
        return authorityDao.find(str);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getStuworkAuthority()
    {
        String str = "from Authority where name like '勤工助学%'";
        return authorityDao.find(str);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getMilitrainAuthority()
    {
        String str = "from Authority where name like '军训%'";
        return authorityDao.find(str);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getWelnewAuthority()
    {
        String str = "from Authority where name like '迎新%'";
        return authorityDao.find(str);
    }

    // -- Authority Manager --//
    @Transactional(readOnly = true)
    public List<Authority> getWelsiteAuthority()
    {
        String str = "from Authority where name like '迎新网站%'";
        return authorityDao.find(str);
    }

    @Autowired
    public void setUserDao(UserDao userDao)
    {
        this.userDao = userDao;
    }

    @Autowired
    public void setStudentUserDao(StudentUserDao studentUserDao)
    {
    }

    @Autowired
    public void setRoleDao(RoleDao roleDao)
    {
        this.roleDao = roleDao;
    }

    @Autowired
    public void setAuthorityDao(AuthorityDao authorityDao)
    {
        this.authorityDao = authorityDao;
    }

    /**
     * 通过email获得用户
     * 
     * @param username
     * @return
     */
    public User findUserByEmail(String email)
    {
        return userDao.findUniqueBy("email", email);
    }
}
