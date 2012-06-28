package cn.loosoft.stuwork.welnew.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.item.CostItemDao;
import cn.loosoft.stuwork.welnew.dao.item.ExtendItemDao;
import cn.loosoft.stuwork.welnew.dao.log.ExtendLogDao;
import cn.loosoft.stuwork.welnew.dao.log.PaymentLogDao;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.item.ExtendItem;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.vo.AllSchoolGiveVO;
import cn.loosoft.stuwork.welnew.vo.SchoolGiveVO;

import com.google.common.collect.Lists;

/**
 * 
 * 发放项目设置的管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class ExtendItemManager extends EntityManager<ExtendItem, Long>
{

    private ExtendItemDao extendItemDao;

    private CostItemDao   costItemDao;

    private PaymentLogDao paymentLogDao;

    private ExtendLogDao  extendLogDao;

    private StudentDao    studentDao;

    /**
     * 根据ID删除发放项目设置
     * 
     * @param extend
     */
    public void deleteExtendItem(List<Long> ids)
    {
        extendItemDao.deletes(ids);
    }

    /**
     * 
     * 统计全校发放记录数
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     * @return
     */
    public List<AllSchoolGiveVO> getAllSchoolGive(Welbatch welbatch)
    {
        List<AllSchoolGiveVO> allSchoolGiveVOs = Lists.newArrayList();
        List<CostItem> items = costItemDao.getExtendItems();

        if (!items.isEmpty())
        {
            for (CostItem costItem : items)
            {
                AllSchoolGiveVO giveVO = new AllSchoolGiveVO();
                giveVO.setName(costItem.getProject());
                giveVO.setMustGiveCount(paymentLogDao.countMustGive(welbatch,
                        null, costItem.getId()));
                giveVO.setAlreadyGiveCount(extendLogDao.countAlreadyGive(
                        welbatch, null, costItem.getId()));
                allSchoolGiveVOs.add(giveVO);
            }
        }

        return allSchoolGiveVOs;
    }

    /**
     * 
     * 统计各学院发放记录数
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     * @return
     */
    public List<SchoolGiveVO> getSchoolGive(Welbatch welbatch)
    {
        List<SchoolGiveVO> schoolGiveVOs = Lists.newArrayList();
        List<CostItem> items = costItemDao.getExtendItems();
        List<Student> students = studentDao
        .getGroupStudentsByMajor(welbatch);

        if (!students.isEmpty())
        {
            for (Student student : students)
            {
                SchoolGiveVO giveVO = new SchoolGiveVO();
                giveVO.setCollegeName(student.getCollegeName());
                List<AllSchoolGiveVO> giveVOs = Lists.newArrayList();

                if (!items.isEmpty())
                {
                    for (CostItem item : items)
                    {
                        AllSchoolGiveVO schoolGiveVO = new AllSchoolGiveVO();
                        schoolGiveVO.setAlreadyGiveCount(extendLogDao
                                .countAlreadyGive(welbatch, student
                                        .getCollegeName(), item.getId()));
                        schoolGiveVO.setMustGiveCount(paymentLogDao
                                .countMustGive(welbatch, student
                                        .getCollegeName(), item.getId()));
                        schoolGiveVO.setName(item.getProject());
                        giveVOs.add(schoolGiveVO);
                    }
                }
                giveVO.setAllSchoolGiveVOs(giveVOs);
                schoolGiveVOs.add(giveVO);
            }
        }
        return schoolGiveVOs;
    }

    @Autowired
    public void setExtendItemDao(ExtendItemDao extendItemDao)
    {
        this.extendItemDao = extendItemDao;
    }

    @Autowired
    public void setCostItemDao(CostItemDao costItemDao)
    {
        this.costItemDao = costItemDao;
    }

    @Autowired
    public void setPaymentLogDao(PaymentLogDao paymentLogDao)
    {
        this.paymentLogDao = paymentLogDao;
    }

    @Autowired
    public void setExtendLogDao(ExtendLogDao extendLogDao)
    {
        this.extendLogDao = extendLogDao;
    }

    @Autowired
    public void setStudentDao(StudentDao studentDao)
    {
        this.studentDao = studentDao;
    }

    @Override
    protected HibernateDao<ExtendItem, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return extendItemDao;
    }

}
