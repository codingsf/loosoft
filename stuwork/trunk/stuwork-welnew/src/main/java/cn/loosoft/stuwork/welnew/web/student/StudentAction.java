package cn.loosoft.stuwork.welnew.web.student;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.DepartmentDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.StudentLength;
import cn.loosoft.stuwork.common.StudentSex;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelModel;
import cn.loosoft.stuwork.welnew.util.ExcelUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 
 * 迎新学员管理Action.
 * 
 * @author shanwu.wu
 * @version 1.0
 * @since 2010-12-12
 */
@Namespace("/student")
@Results( {
    @Result(name = CrudActionSupport.RELOAD, location = "student.action", type = "redirect"),
    @Result(name = StudentAction.DETAIL, location = "student-detail.jsp"),
    @Result(type = "stream", name = "excel", params = {
            "inputName", "excelFileStream", "contentDisposition",
            "attachment;filename=${excelFileName}", "bufferSize", "4096" })
            })
public class StudentAction extends CrudActionSupport<Student>
{

    private static final long         serialVersionUID = 1L;

    public static final String       DETAIL           = "detail";

    private final HttpServletRequest  request          = Struts2Utils
    .getRequest();

    private final HttpServletResponse response         = Struts2Utils
    .getResponse();

    private StudentManager            studentManager;

    private WelbatchManager           batchManager;

    private InstituteWebService       instituteWebService;

    private SpecialtyWebService       specialtyWebService;

    private ClazzWebService           clazzWebService;

    // -- 页面属性 --//
    private Long                      id;

    private Student                   entity;

    // 上传文件域对象
    private File                      upload;

    // 上传文件名
    private String                    uploadFileName;

    // 上传文件类型
    private String                    uploadFileType;

    // 保存文件的目录路径(通过依赖注入)
    private String                    savePath;

    private Page<Student>             page             = new Page<Student>(
            Constant.PAGE_SIZE);                    // 分页列表页面显示数据

    private List<Long>                ids;                                                             // 批量id

    private String                    total            = "0";

    private String                    failnum          = "0";

    private String                    failstr          = "";

    private Long                      batchId;                                                         // 批次ID

    private List<Welbatch>            batches;                                                         // 批次列表

    private List<InstituteDTO>        collegues;                                                       // 学院列表

    private List<DepartmentDTO>       departments;                                                     // 院系列表

    private List<SpecialtyDTO>        majors;                                                          // 专业列表

    private List<ClazzDTO>            clazzes;                                                         // 班级列表

    private List<LabelValue>          studentTypeList;                                                 // 学生类别列表

    private List<LabelValue>          studentLengthList;                                               // 学生学制列表

    private List<LabelValue>          sexes;                                                           // 学生性别

    private final  String              collegeCode      = request
    .getParameter("filter_EQS_collegeCode"); // 院系代码

    private final  String              majorCode        = request
    .getParameter("filter_EQS_majorCode");  // 专业代码

    private String                    type = StudentType.TONGZHAO;                                                            // 学生类别

    private boolean                   finished = false;//是否导入完成
    
    private String exportFilePath="";//临时导出生成的文件名

    // -- ModelDriven 与 Preparable函数 --//
    public Student getModel()
    {
        return entity;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = studentManager.get(id);
        }
        else
        {
            entity = new Student();
        }
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public void setBatchId(Long batchId)
    {
        this.batchId = batchId;
    }

    public void setPage(Page<Student> page)
    {
        this.page = page;
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

    // -- CRUD Action 函数 --//
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("welbatch");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
        .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        page = studentManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    public String query() throws Exception
    {
        return "";
    }

    @Override
    public String save() throws Exception
    {
        Welbatch welbatch = batchManager.get(batchId); // 获取批次
        String sex = ParamUtils.getParameter(request, "sex");
        String collegeName = instituteWebService.getInstituteName(ParamUtils
                .getParameter(request, "collegeCode")); // 根据学院代码获取学院名称
        String majorName = specialtyWebService.getSpecialtyName(ParamUtils
                .getParameter(request, "majorCode")); // 根据专业代码获取专业名称
        String className = clazzWebService.getClazzName(ParamUtils
                .getParameter(request, "classCode")); // 根据班级代码获取班级名称
        entity.setWelbatch(welbatch);
        entity.setSex(sex);
        entity.setCollegeName(collegeName);
        entity.setMajorName(majorName);
        entity.setClassName(className);
        // 保存用户并放入成功信息.
        studentManager.save(entity);
        addActionMessage("保存新生成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        studentManager.delete(id);
        Struts2Utils.renderText("删除新生成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    public String detail()
    {
        this.entity = studentManager.get(id);
        return DETAIL;
    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        studentManager.deleteStudents(ids);
        addActionMessage("批量删除新生成功");
        return RELOAD;
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
     * 导入excel
     * 
     * Description of this Method
     * 
     * @since 2010-8-24
     * @author wxd
     * @return
     */
    @Action(value = "/importexcel", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/student/importexcel.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/student/importexcel.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
            "AUTOMATIC" }),
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
            "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
            @InterceptorRef(value = "paramsPrepareParamsStack") })
            public String importexcel() throws Exception
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
            result = studentManager.importexcel(upload, dstPath, this.type,
                    errorInfo, errorList);
            total = result.get(0);
            failnum = result.get(1);
            failstr = result.get(2);
            finished=true;
        }
        request.getSession().setAttribute("errorInfo", errorInfo);
        request.getSession().setAttribute("errorList", errorList);
        return SUCCESS;
            }
    /**
     * 导出excel
     */
    
    public String export() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("majorCode");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
        .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        page.setPageSize(20000);//用最大量代替不用分页
        page = studentManager.search(page, filters);
        
        //excel头行
        List<String> keyList = Lists.newArrayList();
        keyList.add("学院");
        keyList.add("专业");
        keyList.add("学生类别");
        keyList.add("考生号");
        keyList.add("姓名");
        keyList.add("电话");
        keyList.add("省份");
        keyList.add("寝室");
        keyList.add("是否报到");
        
        
        List<Student> students = page.getResult();
        List<Map<String, String>> lists = Lists.newArrayList();
        
        Map<String, String> map = Maps.newHashMap();
        map.put("学院","学院");
        map.put("专业","专业");
        map.put("学生类别","学生类别");
        map.put("考生号","考生号");
        map.put("姓名","姓名");
        map.put("电话","电话");
        map.put("省份","省份");
        map.put("寝室","寝室");
        map.put("是否报到","是否报到");
        lists.add(map);
        for (Student student : students)
        {
            map = Maps.newHashMap();
            map.put("学院",student.getCollegeName());
            map.put("专业",student.getMajorName());
            map.put("学生类别",student.getTypeDesc());
            map.put("考生号",student.getExamineeNo());
            map.put("姓名",student.getName());
            map.put("电话",student.getTelephone());
            map.put("省份",student.getProvince());
            map.put("寝室",student.getRoombed());
            map.put("是否报到",student.isReged()?"是":"否");
            lists.add(map);
        }

        exportFilePath = RequestUtils.getRealPath(ServletActionContext
                .getServletContext(), "/export")
                + "/"+this.getExcelFileName();
        ExcelUtils.list2excel(lists, keyList, new File(exportFilePath));

        return "excel";
    }
    
    /*
     * 
     * @getDownloadFile 此方法对应的是struts.xml文件中的： <param
     * 
     * name="inputName">downloadFile</param> 返回下载文件的流，可以参看struts2的源码
     */
    public InputStream getExcelFileStream() throws Exception
    {
        return new FileInputStream(exportFilePath); 
    	
    }
    // -- 页面属性访问函数 --//

    public Page<Student> getPage() 
    {
        return page;
    }

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

    public String getUploadFileType()
    {
        return uploadFileType;
    }

    // -- result used in page--//

    public List<LabelValue> getTypeList()
    {
        return StudentType.enumList;
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

    public List<LabelValue> getSexes()
    {

        try
        {
            this.sexes = StudentSex.enumList;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (sexes == null)
        {
            this.sexes = new ArrayList<LabelValue>();
        }
        return sexes;
    }

    public List<DepartmentDTO> getDepartments()
    {
        return departments;
    }

    public List<ClazzDTO> getClazzes()
    {
        Welbatch welbatch = batchManager.getCurrentBatch();
        if (null == welbatch)
        {
            this.clazzes = new ArrayList<ClazzDTO>();
            return this.clazzes;
        }
        this.clazzes = clazzWebService.getClazzsBySpecialty(majorCode, "",
                welbatch.getYear(), welbatch.getSeason());
        if (this.clazzes == null)
        {
            this.clazzes = new ArrayList<ClazzDTO>();
        }
        return this.clazzes;
    }

    public List<LabelValue> getStudentLengthList()
    {
        try
        {
            this.studentLengthList = StudentLength.enumList;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.studentLengthList == null)
        {
            this.studentLengthList = new ArrayList<LabelValue>();
        }

        return this.studentLengthList;
    }

    /**
     * 取得学生类别列表
     * 
     * @author shanwu.wu
     * @since 2010-12-12
     * @version 1.0
     * @return
     */
    public List<LabelValue> getStudentTypeList()
    {
        try
        {
            this.studentTypeList = StudentType.enumList;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.studentTypeList == null)
        {
            this.studentTypeList = new ArrayList<LabelValue>();
        }

        return this.studentTypeList;
    }
    
    /** 提供转换编码后的供下载用的文件名 */

    public String getExcelFileName()
    {

        String downFileName = "新生表.xls";
        try
        {
            return URLEncoder.encode(downFileName,"utf-8");
        }
        catch (UnsupportedEncodingException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "";
        }
    }
    
    public Student getEntity()
    {
        return entity;
    }

    @Autowired
    public void setBatchManager(WelbatchManager batchManager)
    {
        this.batchManager = batchManager;
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
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }
    public boolean getFinished(){
        return finished;
    }
}