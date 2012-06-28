//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.welnew.service.log;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.log.PaymentLogDao;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.vo.TuitionVO;

import com.google.common.collect.Lists;

/**
 * 
 * 缴费记录的管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class PaymentLogManager extends EntityManager<PaymentLog, Long>
{

    private PaymentLogDao paymentLogDao;

    @Autowired
    private StudentDao    studentDao;

    /**
     * 
     * 根据考生号以及缴费项目编号查询
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @param examineeNo
     * @param payItemId
     * @return
     */
    public PaymentLog getPaymentLog(String examineeNo, Long costItemId)
    {
        return paymentLogDao.getPaymentLog(examineeNo, costItemId);
    }

    /**
     * @param paymentLogDao
     *            the paymentLogDao to set
     */
    @Autowired
    public void setPaymentLogDao(PaymentLogDao paymentLogDao)
    {
        this.paymentLogDao = paymentLogDao;
    }

    /**
     * 
     * 根据批次获取实际缴费金额
     * 
     * @since 2011-9-1
     * @author zzHe
     * @param welbatch
     * @return
     */
    public double getRealityCostPrices(String money, boolean need,
            Welbatch welbatch)
    {
        if (PaymentLogDao.PAYEDMONEY.equals(money))
        {
            return paymentLogDao.getRealityPayedMoney(need, welbatch);
        }
        else
        {
            return paymentLogDao.getRealityDebtMoney(need, welbatch);
        }
    }

    public List<TuitionVO> getTuitions(Welbatch welbatch, double mustPrices,
            double selectPrices)
    {
        List<TuitionVO> result = Lists.newArrayList();

        List<Object[]> payedmoney = paymentLogDao.getTuitions(true, welbatch);
        TuitionVO tuitionVO = null;
        if (null != payedmoney && payedmoney.size() > 0)
        {
            for (Object[] money : payedmoney)
            {
                tuitionVO = new TuitionVO();
                tuitionVO.setName(String.valueOf(money[0]));
                tuitionVO.setRealityMustCostPrices(Double.valueOf(String
                        .valueOf(money[1])));
                tuitionVO.setRealityGreenMustCostPrices(Double.valueOf(String
                        .valueOf(money[2])));
                long studentcount = studentDao.countStudent(String
                        .valueOf(money[3]), welbatch, true);
                tuitionVO.setMustCostPrices(studentcount * mustPrices);
                tuitionVO.setSelectCostPrices(studentcount * selectPrices);
                result.add(tuitionVO);
            }

            List<Object[]> debtMoney = paymentLogDao.getTuitions(false,
                    welbatch);
            if (null != debtMoney && debtMoney.size() > 0)
            {
                for (Object[] money : debtMoney)
                {
                    for (TuitionVO tuition : result)
                    {
                        if (tuition.getName().equals(String.valueOf(money[0])))
                        {
                            tuition.setRealitySelectCostPrices(Double
                                    .valueOf(String.valueOf(money[1])));
                            tuition.setRealityGreenSelectCostPrices(Double
                                    .valueOf(String.valueOf(money[2])));
                        }
                    }
                }
            }
        }
        return result;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-29
     * @see cn.loosoft.springside.service.EntityManager#getEntityDao()
     */
    @Override
    protected HibernateDao<PaymentLog, Long> getEntityDao()
    {
        return paymentLogDao;
    }


    /**
     * 删除学生的缴费记录
     * 
     * @since  2011-9-2
     * @author houbing.qian
     * @param examineeNo
     */
    public void deleteByExamNo(String examineeNo){
        paymentLogDao.deleteByExamNo(examineeNo);
    }
}
