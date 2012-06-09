package cn.loosoft.stuwork.backmanage.unit.dao.account;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.test.utils.DataUtils;

import cn.loosoft.stuwork.backmanage.dao.account.RoleDao;
import cn.loosoft.stuwork.backmanage.dao.account.UserDao;
import cn.loosoft.stuwork.backmanage.entity.account.Role;
import cn.loosoft.stuwork.backmanage.entity.account.User;
import cn.loosoft.stuwork.backmanage.unit.dao.BaseTxTestCase;

/**
 * RoleDao的测试用例, 测试ORM映射及特殊的DAO操作.
 * 
 * @author houbing.qian
 */
public class RoleDaoTest extends BaseTxTestCase {
    @Autowired
    private RoleDao roleDao;

    @Autowired
    private UserDao userDao;

    /**
     * 测试删除角色时删除用户-角色的中间表.
     */
    @Test
    public void deleteRole() {
        //新增测试角色并与admin用户绑定.
        Role role = new Role();
        role.setName(DataUtils.randomName("Role"));
        roleDao.save(role);

        User user = userDao.get(1L);
        user.getRoleList().add(role);
        userDao.save(user);
        userDao.flush();

        int oldJoinTableCount = countRowsInTable("acct_user_role");
        int oldUserTableCount = countRowsInTable("acct_user");

        //删除用户角色, 中间表将减少1条记录,而用户表应该不受影响.
        roleDao.delete(role.getId());
        roleDao.flush();

        int newJoinTableCount = countRowsInTable("acct_user_role");
        int newUserTableCount = countRowsInTable("acct_user");
        assertEquals(1, oldJoinTableCount - newJoinTableCount);
        assertEquals(0, oldUserTableCount - newUserTableCount);
    }
}
