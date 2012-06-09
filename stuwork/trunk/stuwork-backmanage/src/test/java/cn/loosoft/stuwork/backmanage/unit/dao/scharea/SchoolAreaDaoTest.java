package cn.loosoft.stuwork.backmanage.unit.dao.scharea;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.stuwork.backmanage.dao.school.SchareaDao;
import cn.loosoft.stuwork.backmanage.entity.school.Scharea;
import cn.loosoft.stuwork.backmanage.unit.dao.BaseTxTestCase;

/**
 * SchoolAreaDao的测试用例, 测试ORM映射及特殊的DAO操作.
 * 
 * @author houbing.qian
 */
public class SchoolAreaDaoTest extends BaseTxTestCase {
    @Autowired
    private SchareaDao achoolAreaDao;

    /**
     * 测试添加和删除校区.
     */
    @Test
    public void add2deleteSchoolArea() {
        int oldAreaTableCount = countRowsInTable("bm_schoolarea");
        //新增测试校区.
        Scharea schoolArea = new Scharea();
        schoolArea.setCode("1222333");
        schoolArea.setName("本小区");
        schoolArea.setAddress("凤阳路123号！");
        achoolAreaDao.save(schoolArea);
        achoolAreaDao.flush();
        int newAreaTableCount = countRowsInTable("bm_schoolarea");

        assertEquals(1, newAreaTableCount - oldAreaTableCount);

        //删除用户角色, 中间表将减少1条记录,而用户表应该不受影响.
        achoolAreaDao.delete(schoolArea.getId());
        achoolAreaDao.flush();

        newAreaTableCount = countRowsInTable("bm_schoolarea");

        assertEquals(0, newAreaTableCount - oldAreaTableCount);
    }
}
