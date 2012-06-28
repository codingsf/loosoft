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
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.item.DevolveItemManager;
import cn.loosoft.stuwork.welnew.service.log.DevolverLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

import com.google.common.collect.Lists;

/**
 * 
 * 分班转移管理Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-12
 */
@Namespace("/devolver")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "classdevolver.action", type = "redirect") })
public class ClassdevolverAction extends CrudActionSupport<Object>
{

    /**
     * serialVersionUID long
     */
    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    @Autowired
    private DevolveItemManager       devolveItemManager;                                               // 转移项目管理

    @Autowired
    private StudentManager           studentManager;                                                   // 学生管理

    @Autowired
    private DevolverLogManager       devolverLogManager;                                               // 转移记录管理

    @Autowired
    private WelbatchManager          batchManager;

    @Autowired
    private InstituteWebService      instituteWebService;                                              // 学院webservice

    @Autowired
    private SpecialtyWebService      specialtyWebService;                                              // 专业webservice

    @Autowired
    private ClazzWebService          clazzWebService;                                                  // 班级webservice

    private List<Welbatch>           batches;

    private List<InstituteDTO>       collegues;                                                        // 学院列表

    private List<SpecialtyDTO>       majors;                                                           // 专业列表

    private List<ClazzDTO>           clazzes;                                                          // 班级列表

    private List<Student>            studentList;                                                      // 学生列表

    private List<Student>            stuList;

    private final String             collegeCode      = request
                                                              .getParameter("filter_EQS_collegeCode"); // 院系代码

    private final String             majorCode        = request
                                                              .getParameter("filter_EQS_majorCode");   // 专业代码

    private final String             classCode        = request
                                                              .getParameter("filter_EQS_classCode");   // 班级代码

    private final String             devolverType     = request
                                                              .getParameter("filter_EQS_devolverType"); // 转移类型

    public List<DevolveItem> getDevolveItemList()
    {
        return devolveItemManager.getAll();
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

    public String submitStudent()
    {

        if (devolverType == "" || devolverType == null)
        {
            stuList = studentManager.getStudentList(collegeCode, majorCode,
                    classCode);
        }
        else
        {

            if (classCode != null && classCode != "")
            {
                studentList = studentManager.getStudentList(collegeCode,
                        majorCode, classCode);
                stuList = Lists.newArrayList();
                for (int i = 0; i < studentList.size(); i++)
                {
                    Student student = studentList.get(i);
                    DevolverLog stuDevolver = devolverLogManager.getStudentLog(
                            student.getStudentNo(), Integer
                                    .parseInt(devolverType));

                    if (stuDevolver == null)
                    {
                        stuList.add(student);
                    }

                }

            }
        }
        return SUCCESS;
    }

    public String devolverStudent()
    {
        String[] stuNoList = request.getParameterValues("stunoFilter");
        if (devolverType != null && devolverType != "")
        {
            if (stuNoList != null)
            {
                for (String stuNo : stuNoList)
                {
                    DevolverLog devolverLog = new DevolverLog();
                    devolverLog.setStudentNo(stuNo);
                    devolverLog.setDevolverId(Integer.parseInt(devolverType));

                    devolverLog.setDevolverTime(new Date());
                    devolverLog.setOperater(SpringSecurityUtils
                            .getCurrentUserName());
                    devolverLogManager.save(devolverLog);
                }

            }
        }
        submitStudent();
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

    public List<Welbatch> getBatches()
    {
        try
        {
            this.batches = this.batchManager.getAll();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.batches == null)
        {
            this.batches = new ArrayList<Welbatch>();
        }

        return batches;
    }

    public List<InstituteDTO> getCollegues()
    {
        try
        {
            this.collegues = this.instituteWebService.getInstitutes();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.collegues == null)
        {
            this.collegues = new ArrayList<InstituteDTO>();
        }
        return this.collegues;
    }

    public List<SpecialtyDTO> getMajors()
    {
        this.majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }

        return this.majors;
    }

    public List<ClazzDTO> getClazzes()
    {
        Welbatch welbatch = batchManager.getCurrentBatch();
        this.clazzes = clazzWebService.getClazzsBySpecialty(majorCode, "",
                welbatch.getYear(), welbatch.getSeason());
        if (this.clazzes == null)
        {
            this.clazzes = new ArrayList<ClazzDTO>();
        }
        return this.clazzes;
    }

    /**
     * @return the studentList
     */
    public List<Student> getStudentList()
    {
        return studentList;
    }

    /**
     * @return the stuList
     */
    public List<Student> getStuList()
    {
        return stuList;
    }
}
