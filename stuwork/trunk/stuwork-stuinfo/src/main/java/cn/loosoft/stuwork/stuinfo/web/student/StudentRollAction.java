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
package cn.loosoft.stuwork.stuinfo.web.student;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.batch.BatchWebService;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.Degree;
import cn.loosoft.stuwork.common.Education;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.StudentLength;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.stuinfo.entity.batch.Batch;
import cn.loosoft.stuwork.stuinfo.entity.student.SchoolRollChange;
import cn.loosoft.stuwork.stuinfo.entity.student.Student;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;
import cn.loosoft.stuwork.stuinfo.service.student.SchoolRollChangeManager;
import cn.loosoft.stuwork.stuinfo.service.student.StudentManager;

/**
 * 
 * 学生学籍信息管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-1-6
 */
@Namespace("/student")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "student-roll.action", type = "redirect"),
        @Result(name = "studentdetail", location = "student-roll-detail.jsp") })
public class StudentRollAction extends CrudActionSupport<Student>
{

    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    private Page<Student>            page             = new Page<Student>(20);

    private StudentManager           studentManager;                          // 学生信息管理

    @Autowired
    private SchoolRollChangeManager  schoolRollChangeManager;

    private Student                  student;                                 // 学生实体

    private Long                     id;                                      // 编号

    BatchWebService                  batchWebService;

    @Autowired
    private InstituteWebService      instituteWebService;                     // 院系

    @Autowired
    private BatchManager             batchManager;

    @Autowired
    private SpecialtyWebService      specialtyWebService;                     // 专业

    @Autowired
    private ClazzWebService          clazzWebService;                         // 班级

    private List<Batch>              batches;                                 // 批次列表

    private List<InstituteDTO>       collegues;                               // 院系

    private List<SpecialtyDTO>       majors;                                  // 专业列表

    private List<ClazzDTO>           clazzs;                                  // 班级

    private List<LabelValue>         selectPageList;

    private String                   pageCode         = "";                   // 分页显示数

    private String                   studentNo;

    private String                   name;

    private String                   IDcard;

    private String                   examineeNo;

    private String                   collegeCode;

    private String                   classCode;

    private String                   majorCode;

    private String                   sex;

    private String                   comname;

    private String                   isInSchool;                              // 是否在校

    private final String             total            = "0";

    private final String             failnum          = "0";

    private final String             failstr          = "";

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {

        if (null != pageCode && StringUtils.isNotEmpty(pageCode))
        {
            page.setPageSize(Integer.parseInt(pageCode));
        }
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("welbatch");
            page.setOrder(Page.DESC);
        }
        // HttpServletRequest request = ServletActionContext.getRequest();
        // List<PropertyFilter> filters = HibernateUtils
        // .buildPropertyFilters(request);
        // filters.add(new PropertyFilter("EQB_deleted", "false"));
        // ParamPropertyUtils.replacePropertyRule(filters);
        //
        // page = studentManager.search(page, filters);
        // if (page.getResult().size() == 0)
        // {
        // addActionMessage("抱歉,没有找到您想要的数据");
        // }
        page = studentManager.search(page, studentNo, name, IDcard, examineeNo,
                sex, collegeCode, majorCode, classCode, comname, isInSchool);
        return SUCCESS;
    }

    public String detail()
    {
        student = studentManager.get(id);
        return "studentdetail";
    }

    @Override
    protected void prepareModel() throws Exception
    {

        if (id != null)
        {
            student = studentManager.get(id);
        }
        else
        {
            student = new Student();
        }
    }

    @Override
    public String save() throws Exception
    {
        String collegeCode = ParamUtils.getParameter(request, "collegeCode");
        String majorCode = ParamUtils.getParameter(request, "majorCode");
        String classCode = ParamUtils.getParameter(request, "classCode");

        String collegeName = instituteWebService.getInstituteName(collegeCode); // 根据学院代码获取学院名称
        String majorName = specialtyWebService.getSpecialtyName(majorCode); // 根据专业代码获取专业名称
        String className = clazzWebService.getClazzName(classCode); // 根据班级代码获取班级名称

        student.setCollegeName(collegeName);
        student.setMajorName(majorName);
        student.setClassName(className);

        // 保存用户并放入成功信息.
        studentManager.save(student);

        // 保存学籍异动记录
        if (student != null)
        {
            String oldCollegeCode = ParamUtils.getParameter(request,
                    "oldCollegeCode");
            String oldmajCode = ParamUtils.getParameter(request, "oldMajCode");
            String oldClaCode = ParamUtils.getParameter(request, "oldClaCode");

            String oldCollgeName = ParamUtils.getParameter(request,
                    "oldCollgeName");
            String oldMajName = ParamUtils.getParameter(request, "oldMajName");
            String oldClaName = ParamUtils.getParameter(request, "oldClaName");

            if (!oldCollegeCode.equals(collegeCode)
                    || !oldmajCode.equals(majorCode)
                    || !oldClaCode.equals(classCode))
            {
                SchoolRollChange change = new SchoolRollChange();
                change.setBatchname(student.getYear() + "-"
                        + student.getSeason());
                change.setStudentNo(student.getStudentNo());
                change.setChangeDateTime(new Date());

                change.setClassName(oldClaName);
                change.setCollegeName(oldCollgeName);
                change.setMajorName(oldMajName);

                change.setName(student.getName());

                change.setNewclassName(className);
                change.setNewcollegeName(collegeName);
                change.setNewmajorName(majorName);

                change.setUsername(SpringSecurityUtils.getCurrentUser()
                        .getUsername());

                change.setCollegeCode(oldCollegeCode);
                change.setMajorCode(oldmajCode);
                change.setClassCode(oldClaCode);

                change.setNewcollegeCode(collegeCode);
                change.setNewmajorCode(majorCode);
                change.setNewclassCode(classCode);
                schoolRollChangeManager.save(change);
            }
        }
        // TODO Auto-generated method stub
        return RELOAD;
    }

    public Student getModel()
    {
        // TODO Auto-generated method stub
        return student;
    }

    // --其他 Action 函数 --//

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    // -- 页面属性访问函数 --//
    public String getTotal()
    {
        return total;
    }

    public String getFailnum()
    {
        return failnum;
    }

    public String getFailstr()
    {
        return failstr;
    }

    public Page<Student> getPage()
    {
        return page;
    }

    /**
     * @return the student
     */
    public Student getStudent()
    {
        return student;
    }

    public List<LabelValue> getHyzk()
    {
        return Marriage.enumList;
    }

    public List<LabelValue> getPyfs()
    {
        return StudentType.enumList;
    }

    public List<LabelValue> getMz()
    {
        return Nation.enumList;
    }

    public List<LabelValue> getSexList()
    {
        List<LabelValue> sexList = new ArrayList<LabelValue>();
        sexList.add(new LabelValue("m", "男"));
        sexList.add(new LabelValue("f", "女"));
        return sexList;
    }

    public List<LabelValue> getXz()
    {
        return StudentLength.enumList;
    }

    public List<LabelValue> getXl()
    {
        return Education.enumList;
    }

    public List<LabelValue> getXw()
    {
        return Degree.enumList;
    }

    public String getPageCode()
    {
        return pageCode;
    }

    public List<LabelValue> getSelectPageList()
    {
        selectPageList = new ArrayList<LabelValue>();
        selectPageList.add(new LabelValue("10", "10"));
        selectPageList.add(new LabelValue("15", "15"));
        selectPageList.add(new LabelValue("20", "20"));
        return selectPageList;
    }

    public List<ClazzDTO> getClazzs()
    {
        // BatchDTO batchDTO = batchWebService.getCurrentBatch();
        Batch batch = batchManager.getCurrentBatch();
        if (batch != null)
        {
            this.clazzs = clazzWebService.getClazzsBySpecialty(
                    student != null ? student.getMajorCode() : majorCode, "",
                    batch.getYear(), batch.getSeason());

        }
        if (this.clazzs == null)
        {
            this.clazzs = new ArrayList<ClazzDTO>();
        }
        return this.clazzs;
    }

    public List<SpecialtyDTO> getMajors()
    {
        this.majors = specialtyWebService
                .getSpecialtysByCollege(student != null ? student
                        .getCollegeCode() : collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }
        return this.majors;
    }

    public List<InstituteDTO> getCollegues()
    {
        this.collegues = instituteWebService.getInstitutes();
        if (this.collegues == null)
        {
            this.collegues = new ArrayList<InstituteDTO>();
        }
        return this.collegues;
    }

    public List<Batch> getBatches()
    {

        try
        {
            this.batches = batchManager.getAll();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.batches == null)
        {
            this.batches = new ArrayList<Batch>();
        }

        return batches;
    }

    public void setPageCode(String pageCode)
    {
        this.pageCode = pageCode;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    public String getComname()
    {
        return comname;
    }

    public void setComname(String comname)
    {
        this.comname = comname;
    }

    public String getIsInSchool()
    {
        return isInSchool;
    }

    public void setIsInSchool(String isInSchool)
    {
        this.isInSchool = isInSchool;
    }

}
