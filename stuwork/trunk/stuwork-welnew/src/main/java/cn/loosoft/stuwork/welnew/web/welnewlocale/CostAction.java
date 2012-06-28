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

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.PayStudentVO;

import com.google.common.collect.Lists;

/**
 * 
 * 缴费项目设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/welnewlocale")
@Results( {
    @Result(name = CrudActionSupport.RELOAD, location = "cost.action", type = "redirect"),
    @Result(name = "costdetail", location = "cost-detail.jsp") })
    public class CostAction extends CrudActionSupport<Object>
{

    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
    .getRequest();

    @Autowired
    private CostItemManager          costItemManager;                                                  // 缴费明细管理

    @Autowired
    private PaymentLogManager        paymentLogManager;                                                // 缴费记录管理

    @Autowired
    private StudentManager           studentManager;                                                   // 学生管理

    private Student                  student;                                                          // 学生实体

    private String                   value;                                                            // 学生号

    public List<LabelValue>          radioList;                                                        // 页面radio集合

    public String                    actionMessage;                                                    // 提示信息

    public String                    column           = request
    .getParameter("filter_EQS_filterColumn"); // radio选中的值

    /**
     * 查询所有的缴费项目设置
     */
    public List<CostItem> getCostItemList()
    {
        return costItemManager.getAll();
    }

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
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

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
        return SUCCESS;
    }

    /**
     * 
     * 查询学生
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @return
     */
    public String searchStudent()
    {

        if (column != null && value != "")
        {
            student = studentManager.getStudent(column, value);
        }
        getPayStudentList();
        return SUCCESS;
    }

    /**
     * 
     * 查询学生缴费情况
     * 
     * @since 2010-12-31
     * @author jie.yang
     * @return
     */
    public List<PayStudentVO> getPayStudentList()
    {
        List<PayStudentVO> payStuList = Lists.newArrayList();
        List<CostItem> costList = costItemManager.getAll("need",false);

        if (costList != null && costList.size() > 0)
        {
            for (CostItem costItem : costList)
            {
                if (student != null)
                {
                    PaymentLog paymentLog = paymentLogManager.getPaymentLog(
                            student.getExamineeNo(), costItem.getId());
                    if (paymentLog != null)
                    {
                        PayStudentVO payStudentVo = new PayStudentVO();
                        payStudentVo.setDebtMoney(paymentLog.getDebtMoney());
                        payStudentVo.setItemId(costItem.getId().toString());
                        payStudentVo.setType(costItem.getProject());
                        payStudentVo.setMoney(costItem.getPrice());
                        payStudentVo.setPayedMoney(paymentLog.getPayedMoney());
                        payStudentVo.setNeed(costItem.isNeed());
                        if (paymentLog.getDebtMoney() > 0)
                        {
                            payStudentVo.setCost(false);
                        }
                        else
                        {
                            payStudentVo.setCost(true);
                        }

                        payStuList.add(payStudentVo);
                    }
                    else
                    {
                        PayStudentVO paystuVo = new PayStudentVO();
                        paystuVo.setDebtMoney(0.00);
                        paystuVo.setItemId(costItem.getId().toString());
                        paystuVo.setCost(false);
                        paystuVo.setType(costItem.getProject());
                        paystuVo.setMoney(costItem.getPrice());
                        paystuVo.setPayedMoney(0.00);
                        paystuVo.setNeed(costItem.isNeed());
                        payStuList.add(paystuVo);
                    }
                }
            }
        }

        return payStuList;
    }

    /**
     * 
     * 确认缴费
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @return
     */
    public String submitStudent()
    {
        student = studentManager.getStudent(column, value);
        if (student != null)
        {

            String[] itemValue = request.getParameterValues("itemFilter");
            if (itemValue != null)
            {
                //先删除所有缴费记录
                paymentLogManager.deleteByExamNo(student.getExamineeNo());
                for (String element : itemValue)
                {

                    PaymentLog paymentLog = paymentLogManager.getPaymentLog(
                            student.getExamineeNo(), Long.parseLong(element));

                    if (paymentLog == null)
                    {
                        CostItem costItem = costItemManager.get(Long
                                .parseLong(element));
                        paymentLog = new PaymentLog();
                        paymentLog.setStudent(student);
                        paymentLog.setDebtDate(null);
                        paymentLog.setCostItem(costItem);
                        paymentLog.setDebtMoney(0);
                        paymentLog.setFinished(true);
                        paymentLog.setOperater(SpringSecurityUtils
                                .getCurrentUserName());
                        paymentLog.setPayDate(new Date());
                        // paymentLog.setPayItemId(Integer.parseInt(element));
                        paymentLog.setPayedMoney(costItem.getPrice());
                        paymentLogManager.save(paymentLog);
                    }
                    // else
                    // {

                    // paymentAction.setPayedMoney(paymentAction
                    // .getPayedMoney()
                    // + paymentAction.getDebtMoney());
                    // paymentAction.setDebtMoney(0);
                    // paymentLogManager.save(paymentAction);
                    // }

                }
            }
            else
            {
                actionMessage = "您还没有勾选要缴费的项目";
                return SUCCESS;
            }

        }
        getPayStudentList();
        return "costdetail";
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    // ==页面属性访问函数== //

    public String getActionMessage()
    {
        return actionMessage;
    }

    /**
     * 页面radio集合
     */
    public List<LabelValue> getRadioList()
    {
        radioList = new ArrayList<LabelValue>();
        radioList.add(new LabelValue("noticeId", "通知书编号"));
        radioList.add(new LabelValue("examineeNo", "考生号"));
        radioList.add(new LabelValue("studentNo", "学号"));
        return radioList;
    }

    public Student getStudent()
    {

        return student;
    }

}
