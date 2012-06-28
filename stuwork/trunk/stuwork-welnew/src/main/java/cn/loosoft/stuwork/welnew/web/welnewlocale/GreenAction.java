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
package cn.loosoft.stuwork.welnew.web.welnewlocale;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;
import cn.loosoft.stuwork.welnew.entity.item.TurnOverItem;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.item.DevolveItemManager;
import cn.loosoft.stuwork.welnew.service.item.TurnOverItemManager;
import cn.loosoft.stuwork.welnew.service.log.DevolverLogManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.DevolverVO;
import cn.loosoft.stuwork.welnew.vo.PayStudentVO;

import com.google.common.collect.Lists;

/**
 * 
 * 绿色通道Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/welnewlocale")
@Results( {
    @Result(name = CrudActionSupport.RELOAD, location = "green.action", type = "redirect"),
    @Result(name = "greendetail", location = "green-detail.jsp") })
    public class GreenAction extends CrudActionSupport<Object>
{

    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
    .getRequest();

    @Autowired
    private StudentManager           studentManager;                                                   // 学生管理

    @Autowired
    private PaymentLogManager        paymentLogManager;                                                // 缴费记录管理

    @Autowired
    private CostItemManager          costItemManager;                                                  // 缴费明细设置

    @Autowired
    private TurnOverItemManager      turnOverItemManager;                                              // 上缴物品

    @Autowired
    private DevolveItemManager       devolverItemManager;                                              // 转移项目管理

    @Autowired
    private DevolverLogManager       devolverLogManager;                                               // 转移项目记录

    private Student                  student;                                                          // 学生实体

    private String                   value;                                                            // 学生号

    public String                    column           = request
    .getParameter("filter_EQS_filterColumn");

    public List<LabelValue>          radioList;

    public String                    extendString     = "";

    public String                    turnOverString   = "";

    public String                    devolverString   = "";

    private String                   actionMessage    = "";

    private String                   remark           = "";

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public Object getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    // ==CRUD Action 函数== //
    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub

        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * 转移记录VO
     */
    public List<DevolverVO> getDevolverVOList()
    {
        List<DevolveItem> itemList = devolverItemManager.getAll();
        DevolverVO devolverVo = null;
        List<DevolverVO> devoVOList = new ArrayList<DevolverVO>();

        if (itemList.size() > 0)
        {
            for (int i = 0; i < itemList.size(); i++)// 首先查询所有的发放项目
            {

                if (student != null)
                {
                    DevolverLog stuLog = devolverLogManager.getStudentLog(
                            student.getStudentNo(), Integer.parseInt(itemList
                                    .get(i).getId().toString()));

                    if (stuLog != null)
                    {

                        devolverVo = new DevolverVO();
                        devolverVo.setDevolver(true);
                        devolverVo.setName(itemList.get(i).getName());
                        devoVOList.add(devolverVo);

                    }
                    else
                    {
                        devolverVo = new DevolverVO();
                        devolverVo.setDevolver(false);
                        devolverVo.setName(itemList.get(i).getName());
                        devoVOList.add(devolverVo);
                    }
                }
                else
                {
                    devolverVo = new DevolverVO();
                    devolverVo.setDevolver(false);
                    devolverVo.setName(itemList.get(i).getName());
                    devoVOList.add(devolverVo);
                }
            }
        }
        else
        {
            for (int i = 0; i < itemList.size(); i++)
            {// 首先查询所有的发放项目
                devolverVo = new DevolverVO();
                devolverVo.setDevolver(false);
                devolverVo.setName(itemList.get(i).getName());
                devoVOList.add(devolverVo);
            }
        }
        return devoVOList;

    }

    public List<PayStudentVO> getPayStudentVoList()
    {
        List<PayStudentVO> psvoList = Lists.newArrayList();
        List<CostItem> costItemList = costItemManager.getAll("need",false);

        if (costItemList != null && costItemList.size() > 0)
        {
            for (int i = 0; i < costItemList.size(); i++)
            {

                if (student != null)
                {
                    PaymentLog paymentLog = paymentLogManager.getPaymentLog(
                            student.getExamineeNo(), costItemList.get(i)
                            .getId());
                    PayStudentVO paystuVo = new PayStudentVO();
                    paystuVo.setType(costItemList.get(i).getProject());
                    paystuVo.setItemId(costItemList.get(i).getId().toString());
                    paystuVo.setMoney(costItemList.get(i).getPrice());
                    paystuVo.setNeed(costItemList.get(i).isNeed());
                    if (paymentLog != null)
                    {
                        if (paymentLog.getPayedMoney() > 0)
                        {// 已缴金额
                            paystuVo.setPayedMoney(paymentLog.getPayedMoney());
                        }
                        else
                        {
                            paystuVo.setPayedMoney(0.00);
                        }

                        if (paymentLog.getDebtMoney() > 0)
                        {// 已缴金额
                            paystuVo.setDebtMoney(paymentLog.getDebtMoney());
                        }
                        else
                        {
                            paystuVo.setDebtMoney(0.00);
                        }
                        paystuVo.setDebtDate(paymentLog.getDebtDate());
                        if (StringUtils.isNotEmpty(paymentLog.getRemark()))
                        {
                            remark = paymentLog.getRemark();
                        }
                    }
                    else
                    {
                        paystuVo.setPayedMoney(0.00);
                        paystuVo.setDebtMoney(0.00);
                    }
                    psvoList.add(paystuVo);
                }
            }
        }
        return psvoList;
    }

    /**
     * 确认缓缴
     * 
     * @since 2010-12-31
     * @author jie.yang
     * @return
     */
    public String submitDebt()
    {
        student = studentManager.getStudent(column, value);
        if (student != null)
        {
            String remark = request.getParameter("remark");
            List<PayStudentVO> payStuVoList = getPayStudentVoList();
            if (null != payStuVoList && payStuVoList.size() > 0)
            {
                //先删除所有缴费记录
                paymentLogManager.deleteByExamNo(student.getExamineeNo());
                for (int i = 0; i < payStuVoList.size(); i++)
                {
                    PayStudentVO payStudentVO = payStuVoList.get(i);
                    if (payStudentVO.getMoney() == payStudentVO.getPayedMoney())
                    {
                        continue;
                    }
                    String payedMoney = request.getParameter("payedMoneyFilter"
                            + i);
                    String debtDate = request
                    .getParameter("debtDateFilter" + i);
                    if (payedMoney != "" && debtDate != "")
                    {
                        payStuVoList.get(i).setDebtMoney(payStuVoList.get(i)
                                .getMoney()-Double.parseDouble(payedMoney));
                        PaymentLog paymentlog = paymentLogManager
                        .getPaymentLog(student.getExamineeNo(), Long
                                .parseLong(payStuVoList.get(i)
                                        .getItemId()));
                        if (paymentlog != null)
                        {// 有缓缴金额过一次 第二次还想缓缴
                            // 如果想缓缴的金额超过了实际金额
                            if (payStuVoList.get(i).getMoney() < paymentlog
                                    .getDebtMoney()
                                    + Double.valueOf(payedMoney))
                            {
                                actionMessage = "缓缴金额不能超过费用标准";
                                break;// 终止循环
                            }
                            paymentlog.setPayedMoney(Double
                                    .parseDouble(payedMoney));
                            paymentlog.setDebtDate(java.sql.Date
                                    .valueOf(debtDate));
                            paymentlog.setDebtMoney(payStuVoList.get(i)
                                    .getMoney()
                                    - paymentlog.getDebtMoney());
                            paymentlog.setRemark(remark);
                            paymentLogManager.save(paymentlog);
                        }
                        else
                        {
                            // 如果想缓缴的金额超过了实际金额
                            if (payStuVoList.get(i).getMoney() < Double
                                    .valueOf(payedMoney))
                            {
                                actionMessage = "缴费金额不能超过费用标准";
                                break;// 终止循环
                            }
                            PaymentLog paylog = new PaymentLog();
                            paylog.setStudent(student);
                            paylog.setCostItem(costItemManager
                                    .get(Long.parseLong(payStuVoList.get(i)
                                            .getItemId())));
                            paylog.setPayedMoney(Double.parseDouble(payedMoney));
                            paylog.setDebtDate(java.sql.Date.valueOf(debtDate));
                            paylog.setPayDate(new Date());
                            paylog.setOperater(SpringSecurityUtils
                                    .getCurrentUserName());
                            // paylog.setPayItemId(Integer.parseInt(payStuVoList
                            // .get(i).getItemId()));
                            // paylog.setExamineeNo(student.getExamineeNo());
                            paylog.setDebtMoney(payStuVoList.get(i).getMoney()
                                    - Double.parseDouble(payedMoney));
                            if (paylog.getPayedMoney() == payStuVoList.get(i)
                                    .getMoney())
                            {
                                paylog.setFinished(true);
                            }
                            else
                            {
                                paylog.setFinished(false);
                            }
                            paylog.setRemark(remark);
                            paymentLogManager.save(paylog);
                        }
                    }
                    else
                    {
                        if ((payStudentVO.isNeed() && "".equals(debtDate))
                                || !"0.0".equals(payedMoney))
                        {
                            actionMessage = "缓缴时间不能为空";
                            break;
                        }
                    }
                }
            }
        }

        if (actionMessage != "")
        {
            return SUCCESS;
        }
        else
        {
            return "greendetail";
        }
    }

    public String searchStudent()
    {
        if (column != null && column != "")
        {
            student = studentManager.getStudent(column, value);
        }
        return SUCCESS;
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    // ==页面属性访问函数== //

    public Student getStudent()
    {

        return student;
    }

    /**
     * @return the actionMessage
     */
    public String getActionMessage()
    {
        return actionMessage;
    }

    /**
     * 发放物品
     */
    public String getExtendString()
    {
        List<CostItem> extendList = costItemManager.getExtendItems();
        for (int i = 0; i < extendList.size(); i++)
        {
            extendString += extendList.get(i).getProject() + ",";
        }
        extendString = extendString.substring(0, extendString.length() - 1);
        return extendString;
    }

    /**
     * 转移物品
     */
    public String getDevolverString()
    {
        List<DevolveItem> extendList = devolverItemManager.getAll();
        for (int i = 0; i < extendList.size(); i++)
        {
            devolverString += extendList.get(i).getName() + ",";
        }
        devolverString = devolverString.substring(0,
                devolverString.length() - 1);
        return devolverString;
    }

    /**
     * 上缴物品
     */
    public String getTurnOverString()
    {
        List<TurnOverItem> turnoverList = turnOverItemManager.getAll();
        for (int i = 0; i < turnoverList.size(); i++)
        {
            turnOverString += turnoverList.get(i).getName() + ",";
        }
        turnOverString = turnOverString.substring(0,
                turnOverString.length() - 1);
        return turnOverString;
    }

    /**
     * @return the radioList
     */
    public List<LabelValue> getRadioList()
    {
        radioList = new ArrayList<LabelValue>();
        radioList.add(new LabelValue("noticeId", "通知书编号"));
        radioList.add(new LabelValue("examineeNo", "考生号"));
        radioList.add(new LabelValue("studentNo", "学号"));
        return radioList;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }
}
