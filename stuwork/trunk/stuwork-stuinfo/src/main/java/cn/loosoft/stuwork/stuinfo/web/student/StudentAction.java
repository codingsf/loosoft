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

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.Degree;
import cn.loosoft.stuwork.common.Education;
import cn.loosoft.stuwork.common.Grade;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.PoliticsFace;
import cn.loosoft.stuwork.common.StudentLength;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.stuinfo.entity.batch.Batch;
import cn.loosoft.stuwork.stuinfo.entity.student.BankChange;
import cn.loosoft.stuwork.stuinfo.entity.student.SchoolRollChange;
import cn.loosoft.stuwork.stuinfo.entity.student.Student;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;
import cn.loosoft.stuwork.stuinfo.service.student.BankChangeManager;
import cn.loosoft.stuwork.stuinfo.service.student.SchoolRollChangeManager;
import cn.loosoft.stuwork.stuinfo.service.student.StudentManager;
import cn.loosoft.stuwork.stuinfo.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.stuinfo.util.ExcelDownLoad;
import cn.loosoft.stuwork.stuinfo.util.ExcelModel;
import cn.loosoft.stuwork.stuinfo.vo.ImportStudentNOVO;

import com.google.common.collect.Lists;

/**
 * 
 * 学生管理Action.
 * 
 * @author jie.yang
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-13
 */
@Namespace("/student")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "student.action", type = "redirect"),
        @Result(name = "studentdetail", location = "student-detail.jsp"),
        @Result(name = "import", location = "importstudent.jsp"),
        @Result(name = "testStuNo", location = "importstudentNo.jsp", type = "dispatcher"), })
public class StudentAction extends CrudActionSupport<Student>
{

    private static final long         serialVersionUID = 1L;

    // private final HttpServletRequest request = Struts2Utils
    // .getRequest();

    private final HttpServletResponse response         = Struts2Utils
                                                               .getResponse();

    private String                    pageCode         = "";                   // 分页显示数

    private BatchManager              batchManager;

    private StudentManager            studentManager;

    private InstituteWebService       instituteWebService;

    private SpecialtyWebService       specialtyWebService;

    private ClazzWebService           clazzWebService;

    @Autowired
    private BankChangeManager         bankChangeManager;

    @Autowired
    private SchoolRollChangeManager   schoolRollChangeManager;

    private List<LabelValue>          selectPageList;

    // ==页面属性== //

    private String                    studentNo;

    private String                    name;

    private String                    IDcard;

    private String                    examineeNo;

    private String                    collegeCode;

    private String                    classCode;

    private String                    majorCode;

    private String                    sex;

    private String                    comname;

    private String                    isInSchool;                              // 是否在校

    private Page<Student>             page             = new Page<Student>(20);

    // 批量删除ID

    private Long                      id;

    // ==页面访问函数== //

    private Student                   student;

    private List<Long>                ids;

    private List<InstituteDTO>        collegues;                               // 院系

    private List<SpecialtyDTO>        majors;                                  // 专业列表

    private List<ClazzDTO>            clazzs;                                  // 班级

    // 班级

    private List<Batch>               batches;

    // 批次列表

    // 上传文件域对象
    private File                      upload;

    // 上传文件名
    private String                    uploadFileName;

    // 保存文件的目录路径(通过依赖注入)
    private String                    savePath;

    private String                    total            = "0";

    private String                    failnum          = "0";

    private String                    failstr          = "";

    // ==ModelDriven 与 Preparable函数 == //
    @Override
    protected void prepareModel() throws Exception
    {

        if (id != null)
        {
            student = studentManager.get(id);
        }
        else
        {
            Batch batch = batchManager.getCurrentBatch();
            student = new Student();
            if(batch!=null){
	            student.setYear(batch.getYear());
	            student.setSeason(batch.getSeason());
            }
        }
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Student getModel()
    {
        // TODO Auto-generated method stub
        return student;
    }

    // ==CRUD Action 函数== //
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    public String count()
    {
        return "count";
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
        // HttpServletRequest req = ServletActionContext.getRequest();
        // List<PropertyFilter> filters =
        // HibernateUtils.buildPropertyFilters(req);
        // filters.add(new PropertyFilter("EQB_deleted", "false"));
        // ParamPropertyUtils.replacePropertyRule(filters);
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

    /**
     * 
     * 导出失败学生信息
     * 
     * @since 2011-2-25
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printErrorInfo() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<Student> errorInfo = (List<Student>) request.getSession()
                .getAttribute("errorInfo");

        List<String> errorList = (List<String>) request.getSession()
                .getAttribute("errorList");

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "姓名;考生号;学院;专业;班级;导入失败原因";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != errorInfo && errorInfo.size() > 0)
        {
            for (int i = 0; i < errorInfo.size(); i++)
            {
                Student student = errorInfo.get(i);

                if (null != student)
                {
                    ArrayList rowData = new ArrayList();
                    rowData.add(student.getName());
                    rowData.add(student.getExamineeNo());
                    rowData.add(student.getCollegeName());
                    rowData.add(student.getMajorName());
                    rowData.add(student.getClassName());
                    rowData.add(errorList.get(i));
                    data.add(rowData);
                }

            }
            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("导入失败学生信息");
            // 设置报表内容
            excel.setData(data);
            // ExcelOperator excelOperator = new ExcelOperator();
            // excelOperator.WriteExcel(excel);
            // 写入到Excel格式输出流供下载
            try
            {

                // 调用自编的下载类，实现Excel文件的下载
                ExcelDownLoad downLoad = new BaseExcelDownLoad();

                // 不生成文件，直接生成文件输出流供下载
                downLoad.downLoad("导入失败学生信息.xls", excel, response);

            }
            catch (Exception e)
            {

                e.printStackTrace();

            }
        }

        // request.getSession().removeAttribute("errorInfo");
        // request.getSession().removeAttribute("errorList");

        return null;
    }

    /**
     * 
     * 导出失败学生信息
     * 
     * @since 2011-2-25
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printStuNoErrorInfo() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<ImportStudentNOVO> stuNoErrorInfo = (List<ImportStudentNOVO>) request
                .getSession().getAttribute("stuNoErrorInfo");

        List<String> stuNoErrorList = (List<String>) request.getSession()
                .getAttribute("stuNoErrorList");

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "姓名;身份证号;考生号;学号;导入失败原因";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != stuNoErrorInfo && stuNoErrorInfo.size() > 0)
        {
            for (int i = 0; i < stuNoErrorInfo.size(); i++)
            {
                ImportStudentNOVO stuNOVO = stuNoErrorInfo.get(i);

                if (null != stuNOVO)
                {
                    ArrayList rowData = new ArrayList();
                    rowData.add(stuNOVO.getName());
                    rowData.add(stuNOVO.getIdCard());
                    rowData.add(stuNOVO.getExameeNo());
                    rowData.add(stuNOVO.getStudentNo());
                    rowData.add(stuNoErrorList.get(i));
                    data.add(rowData);
                }

            }
            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("导入失败学号信息");
            // 设置报表内容
            excel.setData(data);
            // ExcelOperator excelOperator = new ExcelOperator();
            // excelOperator.WriteExcel(excel);
            // 写入到Excel格式输出流供下载
            try
            {

                // 调用自编的下载类，实现Excel文件的下载
                ExcelDownLoad downLoad = new BaseExcelDownLoad();

                // 不生成文件，直接生成文件输出流供下载
                downLoad.downLoad("导入失败学号信息.xls", excel, response);

            }
            catch (Exception e)
            {

                e.printStackTrace();

            }
        }

        // request.getSession().removeAttribute("errorInfo");
        // request.getSession().removeAttribute("errorList");

        return null;
    }

    /**
     * 
     * 导出excel
     * 
     * @since 2011-3-17
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {
        List<Student> students = studentManager.findStudents(studentNo, name,
                IDcard, examineeNo, sex, collegeCode, majorCode, classCode,
                comname, isInSchool);

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "年级;学号;姓名;性别;考生号;姓名拼音;出生日期;曾用名;身份证号;入学前户口;学院代码;学院名称;专业代码;专业名称;班级代码;班级名称;寝室信息;民族;籍贯;政治面貌;学制;培养方式;学历;学位;入学时间;毕业时间;研究方向导师;联系电话;一卡通号;教育方向;生源地;父亲姓名;母亲姓名;家庭地址;家庭邮编;家庭电话;血型;健康状况;婚姻状况;心理状况;国别;宗教信仰;银行名称;银行账户;个人主页;邮箱;特长;备注;是否属于港澳台;届数;毕业中学;是否毕业;是否在校;是否注册;辅导员;辅导员电话;班主任;班主任电话;所属批次";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != students && students.size() > 0)
        {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            for (Student student : students)
            {

                ArrayList rowData = new ArrayList();
                rowData.add(student.getGrade());
                rowData.add(StringUtils.isBlank(student.getStudentNo()) ? ""
                        : student.getStudentNo());
                rowData.add(student.getName());
                rowData.add(StringUtils.isEmpty(student.getSexDesc())?"":student.getSexDesc());
                rowData.add(StringUtils.isEmpty(student.getExamineeNo())?"":student.getExamineeNo());
                rowData.add(StringUtils.isBlank(student.getPinyin()) ? ""
                        : student.getPinyin());
                rowData.add(student.getBirthday() != null ? sdf.format(student
                        .getBirthday()) : null);
                rowData.add(StringUtils.isBlank(student.getFormer()) ? ""
                        : student.getFormer());
                rowData.add(student.getIDcard());
                rowData.add(StringUtils.isEmpty(student.getAccount())?"":student.getAccount());
                rowData.add(student.getCollegeCode());
                rowData.add(student.getCollegeName());
                rowData.add(student.getMajorCode());
                rowData.add(student.getMajorName());
                rowData.add(student.getClassCode());
                rowData.add(student.getClassName());
                rowData.add(StringUtils.isBlank(student.getRoombed()) ? ""
                        : student.getRoombed());
                rowData.add(StringUtils.isEmpty(student.getNationDesc())?"":student.getNationDesc());
                rowData.add(StringUtils.isBlank(student.getBirthPlace()) ? ""
                        : student.getBirthPlace());
                rowData.add(PoliticsFace.getDesc(student.getPoliticsFace()));
                rowData.add(student.getLength());
                rowData.add(StudentType.getDesc(student.getCultureWay()));
                rowData.add(Education.getDesc(student.getEducation()));
                rowData.add(Degree.getDesc(student.getDegree()));
                rowData.add(student.getInDate() != null ? sdf.format(student
                        .getInDate()) : null);
                rowData.add(student.getFinishDate() != null ? sdf
                        .format(student.getFinishDate()) : null);
                rowData.add(StringUtils.isEmpty(student.getHierophant())?"":student.getHierophant());
                rowData.add(StringUtils.isEmpty(student.getPhone())?"":student.getPhone());
                rowData.add(StringUtils.isEmpty(student.getCardNum())?"":student.getCardNum());
                rowData.add(StringUtils.isEmpty(student.getEdudirection())?"":student.getEdudirection());
                rowData.add(StringUtils.isEmpty(student.getTestaddr())?"":student.getTestaddr());
                rowData.add(StringUtils.isEmpty(student.getFatherName())?"":student.getFatherName());
                rowData.add(StringUtils.isEmpty(student.getMotherName())?"":student.getMotherName());
                rowData.add(StringUtils.isEmpty(student.getAddress())?"":student.getAddress());
                rowData.add(StringUtils.isEmpty(student.getFamilyCode())?"":student.getFamilyCode());
                rowData.add(StringUtils.isEmpty(student.getHomePhone())?"":student.getHomePhone());
                rowData.add(StringUtils.isEmpty(student.getBlood())?"":student.getBlood());
                rowData.add(StringUtils.isEmpty(student.getHealthInfo())?"":student.getHealthInfo());
                rowData.add(StringUtils.isEmpty(student.getMarryInfo())?"":student.getMarryInfo());
                rowData.add(StringUtils.isEmpty(student.getPsyInfo())?"":student.getPsyInfo());
                rowData.add(StringUtils.isEmpty(student.getCountry())?"":student.getCountry());
                rowData.add(StringUtils.isEmpty(student.getReligion())?"":student.getReligion());
                rowData.add(StringUtils.isEmpty(student.getBankName())?"":student.getBankName());
                rowData.add(StringUtils.isBlank(student.getAccount()) ? ""
                        : student.getAccount());
                rowData.add(StringUtils.isEmpty(student.getOnlineWeb())?"":student.getOnlineWeb());
                rowData.add(StringUtils.isEmpty(student.getEmail())?"":student.getEmail());
                rowData.add(StringUtils.isEmpty(student.getSpecialty())?"":student.getSpecialty());
                rowData.add(StringUtils.isEmpty(student.getRemarks())?"":student.getRemarks());
                rowData.add(student.isAutonomy() ? "是" : "否");
                rowData.add(StringUtils.isEmpty(student.getPeriod())?"":student.getPeriod());
                rowData.add(StringUtils.isEmpty(student.getGraduateSchool())?"":student.getGraduateSchool());
                rowData.add(student.isGraduated() ? "是" : "否");
                rowData.add(student.isInSchool() ? "是" : "否");
                rowData.add(student.isReged() ? "是" : "否");
                rowData.add(StringUtils.isEmpty(student.getCounselor())?"":student.getCounselor());
                rowData.add(StringUtils.isEmpty(student.getCounselorPhone())?"":student.getCounselorPhone());
                rowData.add(StringUtils.isEmpty(student.getHeadTeacher())?"":student.getHeadTeacher());
                rowData.add(StringUtils.isEmpty(student.getHeadTeacherPhone())?"":student.getHeadTeacherPhone());
                rowData.add(StringUtils.isEmpty(student.getComname())?"":student.getComname());
                data.add(rowData);
            }
        }

        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("学生信息");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {
            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();
            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("学生信息.xls", excel, Struts2Utils.getResponse());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 
     * 测试档案数据是否能够全部导入
     * 
     * @since 2011-1-17
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String test() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<String> result = Lists.newArrayList();
        List<Student> errorInfo = Lists.newArrayList(); // 导入失败学生信息
        List<String> errorList = Lists.newArrayList(); // 导入的错误原因

        if (upload != null)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath("template")
                    + "\\" + uploadFileName;
            result = studentManager.importstudent(upload, dstPath, errorInfo,
                    errorList, true);

        }

        total = result.get(0);
        failnum = result.get(1);
        failstr = result.get(2);

        if ((null != errorInfo && errorInfo.size() > 0)
                || (null != errorList && errorList.size() > 0))
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据错误，数据将不能全部导入');</script>");
        }
        else
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据正确，数据将全部导入');</script>");
        }

        request.getSession().setAttribute("errorInfo", errorInfo);
        request.getSession().setAttribute("errorList", errorList);

        return "import";
    }

    /**
     * 
     * 测试这学号是否能够全部导入
     * 
     * @since 2011-1-17
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String testStuNo() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<String> result = Lists.newArrayList();
        List<ImportStudentNOVO> stuNoErrorInfo = Lists.newArrayList(); // 导入失败学生信息
        List<String> stuNoErrorList = Lists.newArrayList(); // 导入的错误原因

        if (upload != null)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath("template")
                    + "\\" + uploadFileName;
            result = studentManager.importstudentNo(upload, dstPath,
                    stuNoErrorInfo, stuNoErrorList, true);
        }

        total = result.get(0);
        failnum = result.get(1);
        failstr = result.get(2);

        if ((null != stuNoErrorInfo && stuNoErrorInfo.size() > 0)
                || (null != stuNoErrorList && stuNoErrorList.size() > 0))
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据错误，数据将不能全部导入');</script>");
        }
        else
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据正确，数据将全部导入');</script>");
        }

        request.getSession().setAttribute("stuNoErrorInfo", stuNoErrorInfo);
        request.getSession().setAttribute("stuNoErrorList", stuNoErrorList);

        return "testStuNo";
    }

    @Override
    public String save() throws Exception
    {
        if (StringUtils.isEmpty(student.getYear()))
        {
            addActionMessage("保存失败,批次管理中至少设置一个为当前批次");
            return RELOAD;
        }

        // 获得银行账号及银行名称
        String bankName = student.getBankName();
        String bankAcount = student.getBankAccount();

        if (id == null)
        {
            if (StringUtils.isBlank(student.getPassword()))
            {
                student.setPassword(Student.DEFAULTPWD);
            }
        }
        // 保存用户并放入成功信息.
        studentManager.save(student);

        if (id != null)
        {
            // 保存银行账号异动记录
            if (student != null)
            {
                User user = (User) SpringSecurityUtils.getCurrentUser();

                HttpServletRequest request = Struts2Utils.getRequest();
                String oldBankName = request.getParameter("oldBankName");
                String oldBankAccount = request.getParameter("oldBankAccount");
                if (!(StringUtils.isBlank(oldBankName)
                        && StringUtils.isBlank(oldBankAccount)
                        && StringUtils.isBlank(bankName) && StringUtils
                        .isBlank(bankAcount)))
                {
                    if (!bankName.equals(oldBankName)
                            || !bankAcount.equals(oldBankAccount))
                    {
                        BankChange bankChange = new BankChange();
                        bankChange.setBankName(oldBankName);
                        bankChange.setBankAcount(oldBankAccount);
                        bankChange.setNewBankName(bankName);
                        bankChange.setNewBankAcount(bankAcount);
                        bankChange.setOperateUsername(user.getUsername());
                        bankChange.setOperateDateTime(new Date());
                        bankChange.setStudentNo(student.getStudentNo());
                        bankChange.setName(student.getName());
                        bankChange.setBatch(student.getYear() + "-"
                                + student.getSeason());
                        bankChangeManager.save(bankChange);

                    }
                }

                String oldCollegeCode = ParamUtils.getParameter(request,
                        "oldCollegeCode");
                String oldmajCode = ParamUtils.getParameter(request,
                        "oldMajCode");
                String oldClaCode = ParamUtils.getParameter(request,
                        "oldClaCode");

                if (!oldCollegeCode.equals(collegeCode)
                        || !oldmajCode.equals(majorCode)
                        || !oldClaCode.equals(classCode))
                {
                    SchoolRollChange change = new SchoolRollChange();
                    change.setBatchname(student.getYear() + "-"
                            + student.getSeason());
                    change.setStudentNo(student.getStudentNo());
                    change.setChangeDateTime(new Date());

                    String oldCollgeName = ParamUtils.getParameter(request,
                            "oldCollgeName");
                    String oldMajName = ParamUtils.getParameter(request,
                            "oldMajName");
                    String oldClaName = ParamUtils.getParameter(request,
                            "oldClaName");
                    change.setClassName(oldClaName);
                    change.setCollegeName(oldCollgeName);
                    change.setMajorName(oldMajName);

                    change.setName(student.getName());

                    change.setNewclassName(student.getClassName());
                    change.setNewcollegeName(student.getCollegeName());
                    change.setNewmajorName(student.getMajorName());

                    change.setUsername(SpringSecurityUtils.getCurrentUser()
                            .getUsername());

                    change.setCollegeCode(oldCollegeCode);
                    change.setMajorCode(oldmajCode);
                    change.setClassCode(oldClaCode);

                    change.setNewcollegeCode(student.getCollegeCode());
                    change.setNewmajorCode(student.getMajorCode());
                    change.setNewclassCode(student.getClassCode());
                    change.setOperateUsername(user.getUsername());
                    schoolRollChangeManager.save(change);
                }
            }
        }

        addActionMessage("保存成功");
        return RELOAD;
    }

    public String deletes()
    {
        studentManager.deletes(ids);
        return RELOAD;
    }

    @Override
    public String delete()
    {
        //student = studentManager.get(id);
        //student.setDeleted(true);
        //studentManager.save(student);
        studentManager.delete(id);
        
        return RELOAD;
    }

    /**
     * 
     * 批量导入新生信息
     * 
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
                    "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

            }),
     * @since 2010-12-12
     * @author shanru.wu
     * @return
     */
    @Action(value = "/importstudent", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/student/importstudent.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/student/importstudent.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
                    "AUTOMATIC" }), @InterceptorRef(value = "paramsPrepareParamsStack") })
    public String importstudent() throws Exception
    {
        List<String> result = Lists.newArrayList();
        List<Student> errorInfo = Lists.newArrayList(); // 导入失败学生信息
        List<String> errorList = Lists.newArrayList(); // 导入的错误原因
        if (null != upload)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath(savePath)
                    + "\\" + uploadFileName;
            result = studentManager.importstudent(upload, dstPath, errorInfo,
                    errorList, false);
            total = result.get(0);
            failnum = result.get(1);
            failstr = result.get(2);
        }
        HttpServletRequest request = Struts2Utils.getRequest();
        request.getSession().setAttribute("errorInfo", errorInfo);
        request.getSession().setAttribute("errorList", errorList);
        return SUCCESS;
    }

    /**
     * 
     * 批量导入新生学号
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @return
     */
    @Action(value = "/importstudentNo", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/student/importstudentNo.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/student/importstudentNo.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
                    "AUTOMATIC" }),
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
                    "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
            @InterceptorRef(value = "paramsPrepareParamsStack") })
    public String importstudentNo() throws Exception
    {
        // if (null != upload)
        // {
        // // 根据服务器的文件保存地址和原文件名创建目录文件全路径
        // String dstPath = ServletActionContext.getServletContext()
        // .getRealPath(savePath)
        // + "\\" + uploadFileName;
        // List<String> result = studentManager.importstudentNo(upload,
        // dstPath);
        // total = result.get(0);
        // failnum = result.get(1);
        // failstr = result.get(2);
        // }

        List<String> result = Lists.newArrayList();
        List<ImportStudentNOVO> stuNoErrorInfo = Lists.newArrayList(); // 导入失败学生信息
        List<String> stuNoErrorList = Lists.newArrayList(); // 导入的错误原因
        if (null != upload)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath(savePath)
                    + "\\" + uploadFileName;
            result = studentManager.importstudentNo(upload, dstPath,
                    stuNoErrorInfo, stuNoErrorList, false);
            total = result.get(0);
            failnum = result.get(1);
            failstr = result.get(2);
        }
        HttpServletRequest request = Struts2Utils.getRequest();
        request.getSession().setAttribute("stuNoErrorInfo", stuNoErrorInfo);
        request.getSession().setAttribute("stuNoErrorList", stuNoErrorList);
        return SUCCESS;
    }

    public List<ClazzDTO> getClazzs()
    {
        // BatchDTO bmbatchDTO = batchWebService.getCurrentBatch();
        Batch batch = batchManager.getCurrentBatch();
        if (batch != null)
        {
            this.clazzs = clazzWebService.getClazzsBySpecialty(
                    student != null ? student.getMajorCode() : majorCode, "",
                    batch.getYear(), batch.getSeason());
            if (this.clazzs == null)
            {
                this.clazzs = new ArrayList<ClazzDTO>();
            }
        }
        else
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

    public List<LabelValue> getZzmm()
    {
        return PoliticsFace.enumList;
    }

    public List<LabelValue> getSexList()
    {
        List<LabelValue> sexList = new ArrayList<LabelValue>();
        sexList.add(new LabelValue("m", "男"));
        sexList.add(new LabelValue("f", "女"));
        return sexList;
    }

    // 年级
    public List<LabelValue> getGradeList()
    {
        return Grade.enumList;
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

    // == 其他 Action 函数 == //
    public void setPicfile(File picfile)
    {
    }

    public void setPicfileFileName(String picfileFileName)
    {
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setBatchManager(BatchManager batchManager)
    {
        this.batchManager = batchManager;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public void setUpload(File upload)
    {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName)
    {
        this.uploadFileName = uploadFileName;
    }

    public void setSavePath(String savePath)
    {
        this.savePath = savePath;
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

    public String getIsInSchool()
    {
        return isInSchool;
    }

    public void setIsInSchool(String isInSchool)
    {
        this.isInSchool = isInSchool;
    }

    public String getComname()
    {
        return comname;
    }

    public void setComname(String comname)
    {
        this.comname = comname;
    }

}
