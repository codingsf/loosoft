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
import cn.loosoft.stuwork.welnew.entity.item.CheckItem;
import cn.loosoft.stuwork.welnew.entity.log.CheckLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.item.CheckItemManager;
import cn.loosoft.stuwork.welnew.service.log.CheckLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.CheckVO;

import com.google.common.collect.Lists;

/**
 * 
 * 新生资格审查Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-1-27
 */
@Namespace("/welnewlocale")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "check.action", type = "redirect"),
        @Result(name = "printView", location = "printView.jsp") })
public class CheckAction extends CrudActionSupport<Object>
{
    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    @Autowired
    private StudentManager           studentManager;                                                   // 学生管理

    private CheckItemManager         checkItemManager;                                                 // 审查项目

    private CheckLogManager          checkLogManager;                                                  // 审查项目记录

    private Student                  student;                                                          // 学生实体

    private String                   value;

    private String                   name;                                                             // 姓名

    public List<LabelValue>          radioList;                                                        // 页面radio集合

    public String                    actionMessage;                                                    // 提示信息

    private List<CheckItem>          noPassCheckItems;

    private final String             column           = request
                                                              .getParameter("filter_EQS_filterColumn"); // radio选中的值

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
        // TODO Auto-generated method stub
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
        getCheckList();
        return SUCCESS;
    }

    public String print()
    {
        student = studentManager.getStudent(column, value);
        this.name = student.getName();
        return "printView";
    }

    /**
     * 
     * 提交审查项目记录
     * 
     * @since 2011-1-27
     * @author shanru.wu
     * @return
     */
    public String submitCheck()
    {
        student = studentManager.getStudent(column, value);
        List<CheckItem> checkItems = checkItemManager.getAll(); // 获取所有的审查项目
        if (null != student)
        {

            if (null != checkItems)
            {
                // 判断是否同时勾选了"是否通过"和"是否有误"
                for (CheckItem checkItem : checkItems)
                {
                    String isError = request.getParameter("isError"
                            + checkItem.getId());
                    String isPass = request.getParameter("isPass"
                            + checkItem.getId());
                    if (null == isError && null == isPass)
                    {
                        actionMessage = "操作失败,必须所有项目都要勾选 ";
                        return SUCCESS;
                    }
                    if (null != isError && null != isPass)
                    {
                        if (isError.equals(isPass))
                        {
                            actionMessage = "操作失败,是否有误和是否通过只能勾选一个";
                            return SUCCESS;
                        }
                    }

                }
                boolean checkPass = true;
                for (CheckItem checkItem : checkItems)
                {
                    String isError = request.getParameter("isError"
                            + checkItem.getId());
                    String isPass = request.getParameter("isPass"
                            + checkItem.getId());
                    String remark = request.getParameter("remark"
                            + checkItem.getId());
                    CheckLog checkLog = checkLogManager.getCheckLog(student
                            .getExamineeNo(), Integer.parseInt(checkItem
                            .getId().toString()));

                    if (StringUtils.isEmpty(isError)
                            && StringUtils.isEmpty(isPass))
                    {
                        continue;
                    }

                    if (null != checkLog)
                    {
                        checkLog.setCheckItemId(Integer.parseInt(checkItem
                                .getId().toString()));
                        checkLog.setExamineeNo(student.getExamineeNo());
                        checkLog.setError(isError != null ? true : false);
                        checkLog.setRemark(remark);
                        checkLog.setPass(isPass != null ? true : false);
                        checkLog.setOperater(SpringSecurityUtils
                                .getCurrentUserName());
                        checkLogManager.save(checkLog);
                    }
                    else
                    {
                        checkLog = new CheckLog();
                        checkLog.setCheckItemId(Integer.parseInt(checkItem
                                .getId().toString()));
                        checkLog.setExamineeNo(student.getExamineeNo());
                        checkLog.setError(isError != null ? true : false);
                        checkLog.setRemark(remark);
                        checkLog.setPass(isPass != null ? true : false);
                        checkLog.setOperater(SpringSecurityUtils
                                .getCurrentUserName());
                        checkLogManager.save(checkLog);

                    }
                    if (null == isPass)
                    {
                        checkPass = false;
                    }
                }
                student.setCheckPass(checkPass);
                studentManager.save(student);
            }

        }
        actionMessage = "保存成功";
        return SUCCESS;
    }

    /**
     * 
     * 获取审查项目记录
     * 
     * @since 2011-1-27
     * @author shanru.wu
     * @return
     */
    public List<CheckVO> getCheckList()
    {
        List<CheckItem> checkItems = checkItemManager.getAll(); // 获取所有的审查项目
        List<CheckVO> checkVOs = Lists.newArrayList();
        if (null != checkItems && checkItems.size() > 0)
        {
            if (null != student)
            {
                for (CheckItem checkItem : checkItems)
                {
                    CheckVO checkVO = null;
                    CheckLog checkLog = checkLogManager.getCheckLog(student
                            .getExamineeNo(), Integer.parseInt(checkItem
                            .getId().toString())); // 根据审查项目编号查询审查项目记录
                    if (null != checkLog)
                    {
                        checkVO = new CheckVO();
                        checkVO.setCheckItemId(Integer.parseInt(checkItem
                                .getId().toString()));
                        checkVO.setProject(checkItem.getProject());
                        checkVO.setError(checkLog.isError());
                        checkVO.setPass(checkLog.isPass());
                        checkVO.setRemark(checkLog.getRemark());
                        checkVOs.add(checkVO);
                    }
                    else
                    {
                        checkVO = new CheckVO();
                        checkVO.setCheckItemId(Integer.parseInt(checkItem
                                .getId().toString()));
                        checkVO.setProject(checkItem.getProject());
                        checkVO.setError(false);
                        checkVO.setPass(false);
                        checkVO.setRemark("");
                        checkVOs.add(checkVO);
                    }
                }
            }

        }
        return checkVOs;
    }

    // ==其他Aciton函数== //

    @Autowired
    public void setCheckItemManager(CheckItemManager checkItemManager)
    {
        this.checkItemManager = checkItemManager;
    }

    @Autowired
    public void setCheckLogManager(CheckLogManager checkLogManager)
    {
        this.checkLogManager = checkLogManager;
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    // ==页面属性访问函数== //

    /**
     * 审查未通过项目
     */
    public List<CheckItem> getNoPassCheckItems()
    {
        List<CheckItem> checkItems = checkItemManager.getAll();
        List<Long> ids = Lists.newArrayList();
        if (null != checkItems)
        {
            for (CheckItem checkItem : checkItems)
            {
                String error = request.getParameter("isError"
                        + checkItem.getId());
                if (StringUtils.isNotEmpty(error))
                {
                    ids.add(Long.parseLong(error));
                }
            }
        }
        List<CheckItem> items = checkItemManager.getCheckItemByIds(ids);
        this.noPassCheckItems = items;
        return noPassCheckItems;
    }

    public String getActionMessage()
    {
        return actionMessage;
    }

    public String getName()
    {
        return name;
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
