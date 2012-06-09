package cn.loosoft.stuwork.backmanage.unit.service.account;

import org.easymock.classextension.EasyMock;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import cn.loosoft.springside.service.ServiceException;
import cn.loosoft.stuwork.backmanage.dao.account.UserDao;
import cn.loosoft.stuwork.backmanage.service.account.AccountManager;

/**
 * SecurityEntityManager的测试用例, 测试Service层的业务逻辑.
 * 
 * 调用实际的DAO类进行操作,亦可使用MockDAO对象将本用例改为单元测试.
 * 
 * @author houbing.qian
 */
public class AccountManagerTest extends Assert {
    private AccountManager accountManager;
    private UserDao mockUserDao;

    @Before
    public void setUp() {
        accountManager = new AccountManager();
        mockUserDao = EasyMock.createMock(UserDao.class);
        accountManager.setUserDao(mockUserDao);
    }

    @After
    public void tearDown() {
        EasyMock.verify(mockUserDao);
    }

    @Test
    public void deleteUser() {
        mockUserDao.delete(2L);
        EasyMock.replay(mockUserDao);
        //正常删除用户.
        accountManager.deleteUser(2L);
        //删除超级管理用户抛出异常.
        try {
            accountManager.deleteUser(1L);
            fail("expected ServicExcepton not be thrown");
        } catch (ServiceException e) {
            //expected exception
        }
    }
}
