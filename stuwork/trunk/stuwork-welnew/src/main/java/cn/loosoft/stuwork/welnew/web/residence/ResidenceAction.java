package cn.loosoft.stuwork.welnew.web.residence;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.util.date.DateUtils;
import cn.loosoft.data.webservice.api.school.SchareaWebService;
import cn.loosoft.data.webservice.api.school.dto.SchareaDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.residence.Residence;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.residence.ResidenceManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

/**
 * 
 * 户籍信息管理Action.
 * 
 * @author Weixiaodong
 * @version 1.0
 * @since 2010-8-23
 */
@Namespace("/residence")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "residence.action", type = "redirect") })
public class ResidenceAction extends CrudActionSupport<Residence>
{

    private static final long serialVersionUID = 1L;

    @Autowired
    private ResidenceManager  residenceManager;

    @Autowired
    private SchareaWebService schareaWebService;     //

    @Autowired
    private StudentManager    studentManager;

    @Autowired
    private WelbatchManager   welbatchManager;

    // -- 页面属性 --//
    private Long              id;

    private Residence         entity;

    private List<Residence>   dataList;              // 列表页面显示数据

    private List<SchareaDTO>  schareaDTOList;        // 学区

    private List<Long>        ids;                   // 批量id

    // 上传文件域对象
    private File              upload;

    // 上传文件名
    private String            uploadFileName;

    // 保存文件的目录路径(通过依赖注入)
    private String            savePath;

    private String            total            = "0";

    private String            failnum          = "0";

    private String            failstr          = "";

    // -- ModelDriven 与 Preparable函数 --//
    public Residence getModel()
    {
        return entity;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = residenceManager.get(id);
        }
        else
        {
            entity = new Residence();
        }
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

    // -- CRUD Action 函数 --//
    @Override
    public String list() throws Exception
    {
        dataList = residenceManager.getAll();
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        if (id == null)
        {
            entity.setMigrateDate(DateUtils.getNowTimestamp());
        }
        schareaDTOList = schareaWebService.getSchareas();
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        // 保存用户并放入成功信息.
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        Student student = studentManager.getByIdCardNo(entity.getIdCardNo(),
                welbatch);
        if (student == null)
        {
            addActionError("该新生不存在");
            return INPUT;
        }
        entity.setStudent(student);
        entity.setWelbatch(welbatch);
        entity.setCollegeCode(student.getCollegeCode());
        entity.setCollegeName(student.getCollegeName());
        entity.setDepartCode(student.getDepartCode());
        entity.setDepartName(student.getDepartName());
        entity.setMajorCode(student.getMajorCode());
        entity.setMajorName(student.getMajorName());
        entity.setClassCode(student.getClassCode());
        entity.setClassName(student.getClassName());
        residenceManager.save(entity);
        addActionMessage("保存学员成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        residenceManager.delete(id);
        Struts2Utils.renderText("删除学员成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2010-8-23
     * @author Weixiaodong
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        residenceManager.deleteResidences(ids);
        addActionMessage("批量删除学员成功");
        return RELOAD;
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
    @Action(value = "/importhuji", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/residence/import-huji.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/residence/import-huji.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
                    "AUTOMATIC" }),
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
                    "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
            @InterceptorRef(value = "paramsPrepareParamsStack") })
    public String importhuji() throws Exception
    {
        if (null != upload)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath(savePath)
                    + "\\" + uploadFileName;
            List<String> result = residenceManager.importexcel(upload, dstPath);
            total = result.get(0);
            failnum = result.get(1);
            failstr = result.get(2);
        }
        return SUCCESS;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<Residence> getDataList()
    {
        return this.dataList;
    }

    /**
     * 
     * 编辑页面选择用的校区
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @return
     */
    public List<SchareaDTO> getSchareaList()
    {
        if (schareaDTOList == null)
        {
            return new ArrayList<SchareaDTO>();
        }
        return schareaDTOList;
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
}