package cn.loosoft.stuwork.welnew.web.clazz;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.clazz.MajorClazzInfo;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.clazz.MajorClazzInfoManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 分班管理Action.
 * 
 * @author houbing.qian
 * @author shanru.wu
 * @version 1.0
 * @since 2010-8-24
 */
@Namespace("/clazz")
@Results( {
    @Result(name = "reload", location = "major-clazz.action", type = "redirect"),
    @Result(name = "adjust", location = "adjust-clazz.jsp") })
    public class ClazzAssignAction extends ActionSupport
    {
    private static final long     serialVersionUID = 1L;

    private MajorClazzInfoManager majorClazzInfoManager;                       // 专业分班信息

    private SpecialtyWebService   specialtyWebService;                         // 专业信息

    private ClazzWebService       clazzWebService;                             // 班级信息

    private InstituteWebService   instituteWebService;                         // 院系信息

    private StudentManager        studentManager;                              // 学生信息

    private WelbatchManager       welbatchManger;                              // 批次信息

    // -- 页面属性 --//
    private long                  majorClazzInfoId;                            // 专业代码

    private int                   personNum;                                   // 班级预设人数，默认50人

    private List<Welbatch>        welbatchList;                                // 批次列表

    private List<InstituteDTO>    colleges;                                    // 院系列表

    private List<SpecialtyDTO>    majors;                                      // 专业列表

    private List<ClazzDTO>        clazzs;                                      // 班级列表

    private List<LabelValue>      studentTypeList;                             // 学生类别列表

    private Page<Student>         pageByMajor      = new Page<Student>(
            Constant.PAGE_SIZE); // 分页列表页面显示专业下的学生数据

    private Page<Student>         pageByClazz      = new Page<Student>(
            Constant.PAGE_SIZE); // 分页列表页面显示班级下的所有学生数据

    private String                majorCode;                                   // 专业代码

    private String                collegeCode;                                 // 院系代码

    private String                type;                                        // 学生类别

    private String                clazzCode;                                   // 班级代码

    // 上传文件域对象
    private File                  upload;

    // 上传文件名
    private String                uploadFileName;

    // 保存文件的目录路径(通过依赖注入)
    private String                savePath;

    private String                total            = "0";

    private String                failnum          = "0";

    private String                failstr          = "";

    private String                logFilename          = "";

    private Welbatch              curWelbatch;         //当前批次
    private boolean finished=false;
    // -- CRUD Action 函数 --//

    // -- other Action 函数 --//
    /**
     * 单个专业分班
     */
    public String autoAssign()
    {
        //
        if (majorClazzInfoId == 0)
        {
            return "assign";
        }
        MajorClazzInfo majorClazzInfo = majorClazzInfoManager
        .get(majorClazzInfoId);

        if (majorClazzInfo == null)
        {
            return "assign";
        }

        majorClazzInfoManager.majorAssign(majorClazzInfo, personNum);

        return "reload";
    }

    public String adjust()
    {
        if (!pageByMajor.isOrderBySetted())
        {
            pageByMajor.setOrderBy("welbatch");
            pageByMajor.setOrder(Page.DESC);
        }

        if (pageByClazz.isOrderBySetted())
        {
            pageByClazz.setOrderBy("welbatch");
            pageByClazz.setOrder(Page.DESC);
        }

        // 获取所有的专业
        PropertyFilter propertyFilter = new PropertyFilter("EQS_majorCode",
                majorCode);
        List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
        filters.add(propertyFilter);
        ParamPropertyUtils.replacePropertyRule(filters);
        pageByMajor = studentManager.search(pageByMajor, filters);

        // 获取专业、类型下的所有班级
        PropertyFilter propertyFilter1 = new PropertyFilter("EQS_classCode",
                clazzCode);
        PropertyFilter propertyFilter2 = new PropertyFilter("EQS_majorCode",
                majorCode);
        PropertyFilter propertyFilter3 = new PropertyFilter("EQS_type", type);
        List<PropertyFilter> filterList = new ArrayList<PropertyFilter>();
        filterList.add(propertyFilter1);
        filterList.add(propertyFilter2);
        filterList.add(propertyFilter3);
        ParamPropertyUtils.replacePropertyRule(filterList);
        pageByClazz = studentManager.search(pageByClazz, filterList);
        return "adjust";
    }

    /**
     * 手工分班
     * 
     * @author shanru.wu
     * @since 2010-12-9
     */
    public String handClazz()
    {

        HttpServletRequest request = ServletActionContext.getRequest();

        String idString = request.getParameter("ids");
        String id2String = request.getParameter("ids2");

        String flag = ParamUtils.getParameter(request, "flag");

        String classCode = ParamUtils.getParameter(request, "classCode");
        this.clazzCode = classCode;

        String className = clazzWebService.getClazzName(classCode);

        if (flag.equals("update"))
        {
            if (null != idString)
            {
                String[] ids = idString.split(",");

                for (String id : ids)
                {
                    Student student = studentManager.get(Long.parseLong(id));
                    student.setClassName(className);
                    student.setClassCode(classCode);
                    studentManager.save(student);
                }
            }

            Struts2Utils.renderText("学生成功添加到此班级");
        }
        else
            if (flag.equals("delete"))
            {
                if (null != id2String)
                {
                    String[] ids = id2String.split(",");
                    for (String id : ids)
                    {
                        Student student = studentManager
                        .get(Long.parseLong(id));
                        student.setClassName("");
                        student.setClassCode("");
                        studentManager.save(student);
                    }
                }
                Struts2Utils.renderText("学生成功从此班级移除");
            }
        // return this.adjust();
        return null;
    }

    public String adjustPage()
    {
        pageByMajor.setTotalCount(0);
        pageByMajor.setTotalCount(0);
        curWelbatch = welbatchManger.getCurrentBatch();
        return "adjust";
    }

    /**
     * excel导入
     * 
     * Description of this Method
     * 
     * @since 2010-8-25
     * @author wxd
     * @return
     * @throws Exception
     */
    @Action(value = "/importclass", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/clazz/import-class.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/clazz/import-class.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
            "AUTOMATIC" }),
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
            "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
            @InterceptorRef(value = "paramsPrepareParamsStack") })
            public String importclass() throws Exception
            {
        if (null != upload)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
            .getRealPath(savePath);
            boolean isAuto = ParamUtils.getBooleanParameter(ServletActionContext
                    .getRequest(), "isAuto",false);
            List<String> result = majorClazzInfoManager.importexcel(upload,dstPath,uploadFileName,isAuto);
            total = result.get(0);
            failnum = result.get(1);
            failstr = result.get(2);
            logFilename = result.get(3);
            finished=true;
        }

        return SUCCESS;
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

    public List<SpecialtyDTO> getMajors()
    {
        this.majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }
        return this.majors;
    }

    public List<Welbatch> getWelbatchList()
    {
        welbatchList = welbatchManger.getAll(); // 取得所有的批次
        if (welbatchList == null)
        {
            this.welbatchList = new ArrayList<Welbatch>();
        }
        return welbatchList;
    }

    public List<ClazzDTO> getClazzs()
    {
        Welbatch welbatch = welbatchManger.getCurrentBatch();
        this.clazzs = clazzWebService.getClazzsBySpecialty(majorCode, type,
                welbatch.getYear(), welbatch.getSeason());
        if (this.clazzs == null)
        {
            this.clazzs = new ArrayList<ClazzDTO>();
        }
        return this.clazzs;
    }

    public List<InstituteDTO> getColleges()
    {
        colleges = instituteWebService.getInstitutes(); // 取得所有的院系
        if (colleges == null)
        {
            this.colleges = new ArrayList<InstituteDTO>();
        }
        return colleges;
    }

    public List<LabelValue> getStudentTypeList()
    {
        this.studentTypeList = StudentType.enumList;
        if (this.studentTypeList == null)
        {
            this.studentTypeList = new ArrayList<LabelValue>();
        }
        return studentTypeList;
    }

    public Page<Student> getPageByClazz()
    {
        return pageByClazz;
    }

    public Page<Student> getPageByMajor()
    {
        return pageByMajor;
    }

    public String getFailstr()
    {
        return failstr;
    }

    @Autowired
    public void setMajorClazzInfoManager(
            MajorClazzInfoManager majorClazzInfoManager)
    {
        this.majorClazzInfoManager = majorClazzInfoManager;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
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
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setWelbatchManger(WelbatchManager welbatchManger)
    {
        this.welbatchManger = welbatchManger;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorClazzInfoId(long majorClazzInfoId)
    {
        this.majorClazzInfoId = majorClazzInfoId;
    }

    public void setPersonNum(int personNum)
    {
        this.personNum = personNum;
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

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getClazzCode()
    {
        return clazzCode;
    }

    public void setClazzCode(String clazzCode)
    {
        this.clazzCode = clazzCode;
    }
    public Welbatch getCurWelbatch()
    {
        return curWelbatch;
    }

    public boolean getFinished(){
        return finished;
    }

    public String getLogFilename(){
        return logFilename;
    }
    }