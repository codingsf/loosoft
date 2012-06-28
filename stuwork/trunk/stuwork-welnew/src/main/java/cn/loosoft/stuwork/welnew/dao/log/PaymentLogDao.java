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
package cn.loosoft.stuwork.welnew.dao.log;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;

import com.google.common.collect.Lists;

/**
 * 
 * 缴费记录DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Component
public class PaymentLogDao extends HibernateDao<PaymentLog, Long>
{
    public static String        PAYEDMONEY              = "payedMoney";                                                                                                                                                                                      // 已缴费金额
    private static final String PAYMENTLOG_DELETEBYEXAMNO = "delete from PaymentLog where examineeNo=?";

    public static String        DEBTMONEY               = "debtMoney";                                                                                                                                                                                       // 缓缴金额

    private static final String PAYMENTLOG_QUERY        = "from PaymentLog where examineeNo=? and costItem.id=?";

    // 根据批次和项目编号查询当前批次下的项目实发人数
    private static final String COUNTALREADYGIVE        = "from PaymentLog where student.welbatch=? and costItem.id=?";

    // 根据批次和学院及项目编号查询当前批次下的项目实发人数
    private static final String COUNTCOLLEGEALREADYGIVE = "from PaymentLog where student.collegeName=? and student.welbatch=? and costItem.id=?";

    // 
    private static final String SELECT_PAYEDMONEY       = "select sum(a.payedMoney) from PaymentLog as a where a.costItem.need = ? and a.student.welbatch =?";

    // 
    private static final String SELECT_DEBTMONEY        = "select sum(a.debtMoney) from PaymentLog as a where a.costItem.need = ? and a.student.welbatch =?";

    private static final String SELECT_TUITIONS         = "select a.student.collegeName, sum(a.payedMoney), sum(a.debtMoney), a.student.collegeCode from PaymentLog as a where a.costItem.need = ? and a.student.welbatch =? group by a.student.collegeName";

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
        return super.findUnique(PAYMENTLOG_QUERY, examineeNo, costItemId);
    }

    /**
     * 删除学生的缴费记录
     * 
     * @since  2011-9-2
     * @author houbing.qian
     * @param examineeNo
     */
    public void deleteByExamNo(String examineeNo){
        super.batchExecute(PAYMENTLOG_DELETEBYEXAMNO, examineeNo);
    }


    /**
     * 
     * 根据批次和项目编号查询当前批次下的项目应发人数
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     * @param costItemId
     * @return
     */
    public long countMustGive(Welbatch welbatch, String collegeName,
            Long costItemId)
    {
        if (StringUtils.isBlank(collegeName))
        {
            return super.countHqlResult(COUNTALREADYGIVE, welbatch, costItemId);
        }
        else
        {
            return super.countHqlResult(COUNTCOLLEGEALREADYGIVE, collegeName,
                    welbatch, costItemId);
        }
    }

    public double getRealityPayedMoney(boolean need, Welbatch welbatch)
    {
        if (welbatch != null)
        {
            Query query = super.createQuery(SELECT_PAYEDMONEY, need, welbatch);
            if (query.uniqueResult() == null)
            {
                return 0;
            }
            return ((Double) query.uniqueResult()).doubleValue();
        }
        else
        {
            return 0;
        }
    }

    public double getRealityDebtMoney(boolean need, Welbatch welbatch)
    {
        if (welbatch != null)
        {
            Query query = super.createQuery(SELECT_DEBTMONEY, need, welbatch);
            if (query.uniqueResult() == null)
            {
                return 0;
            }
            return ((Double) query.uniqueResult()).doubleValue();
        }
        else
        {
            return 0;
        }
    }

    public List<Object[]> getTuitions(boolean need, Welbatch welbatch)
    {
        if (welbatch != null)
        {
            return super.createQuery(SELECT_TUITIONS, need, welbatch).list();
        }
        else
        {
            return Lists.newArrayList();
        }
    }
}
