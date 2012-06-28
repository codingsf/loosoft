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
package cn.loosoft.stuwork.welnew.web.devolver;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.item.DevolveItemManager;
import cn.loosoft.stuwork.welnew.service.log.DevolverLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.DevolverVO;

import com.google.common.collect.Lists;

/**
 * 
 * 单个转移管理Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-12
 */
@Namespace("/devolver")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "devolver.action", type = "redirect") })
public class DevolverAction extends CrudActionSupport<Object>
{
    /**
     * serialVersionUID long
     */
    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    @Autowired
    private DevolveItemManager       devolveItemManager;                                           // 转移项目管理

    @Autowired
    private DevolverLogManager       devolverLogManager;                                           // 转移记录管理

    @Autowired
    private StudentManager           studentManager;                                               // 学生管理

    private DevolverLog              devolverLog;                                                  // 转移记录实体

    private Student                  student;                                                      // 学生实体

    private String                   studentNo;                                                    // 学生号

    private List<DevolverVO>         devolverVOList;                                               // 转移记录VO

    private final String             filterId         = request
                                                              .getParameter("filter_EQS_filterId"); // radio选中的值

    public List<LabelValue>          radioList;                                                    // 页面radio集合

    /**
     * radio集合
     */
    public List<LabelValue> getRadioList()
    {
        radioList = new ArrayList<LabelValue>();
        radioList.add(new LabelValue("noticeId", "通知书编号"));
        radioList.add(new LabelValue("examineeNo", "考生号"));
        radioList.add(new LabelValue("studentNo", "学号"));
        return radioList;
    }

    /**
     * 转移记录VO
     */
    public List<DevolverVO> getDevolverVOList()
    {
        return devolverVOList;
    }

    /**
     * 查询所有转移项目
     */
    public List<DevolveItem> getDevolveItemList()
    {
        return devolveItemManager.getAll();
    }

    /**
     * 根据学号查询所有转移记录
     */
    public List<DevolverVO> getDevolveVOList()
    {
        List<DevolveItem> itemList = devolveItemManager.getAll();
        DevolverVO devolverVo = null;
        devolverVOList = Lists.newArrayList();

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

                        devolverVo.setDevolverDesc("是");
                        devolverVo.setName(itemList.get(i).getName());
                        devolverVOList.add(devolverVo);

                    }
                    else
                    {
                        devolverVo = new DevolverVO();

                        devolverVo.setDevolverDesc("否");
                        devolverVo.setName(itemList.get(i).getName());
                        devolverVOList.add(devolverVo);
                    }
                }
                else
                {
                    devolverVo = new DevolverVO();

                    devolverVo.setDevolverDesc("否");
                    devolverVo.setName(itemList.get(i).getName());
                    devolverVOList.add(devolverVo);
                }

            }
            return devolverVOList;
        }
        else
        {
            for (int i = 0; i < itemList.size(); i++)
            {// 首先查询所有的发放项目
                devolverVo = new DevolverVO();
                devolverVo.setDevolverDesc("否");
                devolverVo.setName(itemList.get(i).getName());
                devolverVOList.add(devolverVo);
            }
            return devolverVOList;
        }

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    @Deprecated
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
        getDevolveVOList();
        // TODO Auto-generated method stub
        return SUCCESS;
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
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * 
     * 根据通知书编号、学号、考生号查询.
     * 
     * @since 2010-12-27
     * @author jie.yang
     * @param
     */
    public String searchStudent()
    {
        if (filterId != null && filterId != "")
        {
            student = studentManager.getStudent(filterId, studentNo);
        }
        getDevolveVOList();
        return SUCCESS;
    }

    /**
     * 
     * 确认转移
     * 
     * @since 2010-12-27
     * @author jie.yang
     * @param
     */
    public String submitDevolver()
    {

        String[] itemValue = request.getParameterValues("devolveItemId");
        student = studentManager.getStudent(filterId, studentNo);
        if (student != null)
        {
            if (itemValue != null)
            {

                for (String element : itemValue)
                {
                    if (devolverLogManager.getStudentLog(
                            student.getStudentNo(), Integer.parseInt(element)) == null)
                    {
                        devolverLog = new DevolverLog();
                        devolverLog.setDevolverId(Integer.parseInt(element));
                        devolverLog.setStudentNo(student.getStudentNo());
                        devolverLog.setDevolverTime(new Date());
                        devolverLog.setOperater("杨节");
                        devolverLogManager.save(devolverLog);
                    }
                }

            }
        }
        getDevolveVOList();
        return SUCCESS;
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

    // /////////////////////////////////属性

    public Student getStudent()
    {

        return student;
    }

    /**
     * @param studentNo
     *            the studentNo to set
     */
    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    /**
     * @return the studentNo
     */
    public String getStudentNo()
    {
        return studentNo;
    }

}
