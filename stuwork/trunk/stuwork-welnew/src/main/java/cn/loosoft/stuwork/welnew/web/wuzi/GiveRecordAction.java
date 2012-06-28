package cn.loosoft.stuwork.welnew.web.wuzi;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

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
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

import com.opensymphony.xwork2.Action;

/**
 * 
 * 发放记录管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-10
 */
@Namespace("/wuzi")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "giveRecord.action", type = "redirect") })
public class GiveRecordAction
{

    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    @Autowired
    private StudentManager           studentManager;

    @Autowired
    private WelbatchManager          batchManager;

    @Autowired
    private InstituteWebService      instituteWebService;

    @Autowired
    private SpecialtyWebService      specialtyWebService;

    @Autowired
    private ClazzWebService          clazzWebService;

    // -- 页面属性 --//
    private Page<Student>            page             = new Page<Student>(
                                                              Constant.PAGE_SIZE);                    // 分页列表页面显示数据

    private List<Welbatch>           batches;                                                         // 批次列表

    private List<InstituteDTO>       collegues;                                                       // 学院列表

    private List<SpecialtyDTO>       majors;                                                          // 专业列表

    private List<ClazzDTO>           clazzes;                                                         // 班级列表

    private List<LabelValue>         sexes;                                                           // 学生性别

    private final String             collegeCode      = request
                                                              .getParameter("filter_EQS_collegeCode"); // 院系代码

    private final String             majorCode        = request
                                                              .getParameter("filter_EQS_majorCode");  // 专业代码

    public String execute()
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
        return Action.SUCCESS;
    }

    // -- 页面属性访问函数 --//
    /**
     * 列表页面显示学生发放明细
     */
    public Page<Student> getPage()
    {
        return page;
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

}