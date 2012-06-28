package cn.loosoft.stuwork.welnew.web.room;

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
import org.springside.modules.orm.hibernate.HibernateUtils;
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
import cn.loosoft.stuwork.common.StudentSex;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.room.Bed;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.room.BedManager;

/**
 * 
 * 床位管理Action.
 * 
 * @author houbing.qian
 * @author shanru.wu
 * @version 1.0
 * @since 2010-8-24
 */
@Namespace("/room")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "bed.action", type = "redirect") })
public class BedAction extends CrudActionSupport<Bed>
{
    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    private BedManager               bedManager;

    private WelbatchManager          batchManager;

    private InstituteWebService      instituteWebService;

    private SpecialtyWebService      specialtyWebService;

    private ClazzWebService          clazzWebService;

    // -- 页面属性 --//
    private Long                     id;

    private Bed                      entity;

    private Page<Bed>                page             = new Page<Bed>(
                                                              Constant.PAGE_SIZE); // 分页列表页面显示数据

    private List<Long>               ids;                                         // 批量id

    // 上传文件域对象
    private File                     upload;

    // 上传文件名
    private String                   uploadFileName;

    // 保存文件的目录路径(通过依赖注入)
    private String                   savePath;

    private String                   total            = "0";

    private String                   failnum          = "0";

    private String                   failstr          = "";

    private List<Welbatch>           batches;                                     // 批次列表

    private List<InstituteDTO>       collegues;                                   // 学员列表

    private List<SpecialtyDTO>       majors;                                      // 专业列表

    private List<ClazzDTO>           clazzes;                                     // 班级列表

    private List<LabelValue>         sexes;

    // -- ModelDriven 与 Preparable函数 --//
    public Bed getModel()
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
            entity = bedManager.get(id);
        }
        else
        {
            entity = new Bed();
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
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("welbatch");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        page = bedManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        Welbatch currentBatch = batchManager.getCurrentBatch();
        String collegeName = instituteWebService.getInstituteName(ParamUtils
                .getParameter(request, "collegeCode"));
        String majorName = specialtyWebService.getSpecialtyName(ParamUtils
                .getParameter(request, "majorCode"));
        String className = clazzWebService.getClazzName(ParamUtils
                .getParameter(request, "classCode"));

        entity.setCollegeName(collegeName);
        entity.setMajorName(majorName);
        entity.setClassName(className);
        entity.setWelbatch(currentBatch);
        // 保存用户并放入成功信息.
        bedManager.save(entity);
        addActionMessage("保存床位成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        bedManager.delete(id);
        Struts2Utils.renderText("删除床位成功");
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
        if (ids == null || ids.isEmpty())
        {
            return RELOAD;
        }
        bedManager.deleteBeds(ids);
        addActionMessage("批量删除床位成功");
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
    @Action(value = "/importchuangwei", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/room/import-chuangwei.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/room/import-chuangwei.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
                    "AUTOMATIC" }),
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
                    "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
            @InterceptorRef(value = "paramsPrepareParamsStack") })
    public String importchuangwei() throws Exception
    {
        if (null != upload)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath(savePath)
                    + "\\" + uploadFileName;
            List<String> result = bedManager.importexcel(upload, dstPath);
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
    public String getTotal()
    {
        return total;
    }

    public Page<Bed> getPage()
    {
        return page;
    }

    public String getFailnum()
    {
        return failnum;
    }

    public String getFailstr()
    {
        return failstr;
    }

    public List<Welbatch> getBatches()
    {
        this.batches = this.batchManager.getAll();
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
        String collegeCode = request.getParameter("filter_EQS_collegeCode"); // 院系代码
        this.majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }

        return this.majors;
    }

    public List<LabelValue> getSexes()
    {
        this.sexes = StudentSex.enumList;
        if (this.sexes == null)
        {
            this.sexes = new ArrayList<LabelValue>();
        }
        return sexes;
    }

    public List<ClazzDTO> getClazzes()
    {
        String majorCode = request.getParameter("filter_EQS_majorCode"); // 专业代码
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

    @Autowired
    public void setBedManager(BedManager bedManager)
    {
        this.bedManager = bedManager;
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
}