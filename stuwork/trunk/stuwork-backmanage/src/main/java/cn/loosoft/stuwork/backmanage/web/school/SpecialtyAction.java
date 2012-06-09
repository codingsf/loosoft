package cn.loosoft.stuwork.backmanage.web.school;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.school.Department;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.backmanage.service.school.DepartmentManager;
import cn.loosoft.stuwork.backmanage.service.school.InstituteManager;
import cn.loosoft.stuwork.backmanage.service.school.SpecialtyManager;
import cn.loosoft.stuwork.backmanage.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelModel;

/**
 * 
 * 专业管理Action.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-19
 */
@Namespace("/school")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "specialty.action", type = "redirect") })
public class SpecialtyAction extends CrudActionSupport<Specialty>
{

    private static final long serialVersionUID = 1L;

    @Autowired
    private SpecialtyManager  specialtyManager;

    @Autowired
    private DepartmentManager departmentManager;

    @Autowired
    private InstituteManager  instituteManager;

    // -- 页面属性 --//
    private Long              id;

    private Specialty         entity;

    private List<Specialty>   dataList;                                  // 列表页显示数据

    private List<Long>        ids;                                       // 批量

    private Long              departmentId;                              // 页面提交和显示的系id

    private List<Department>  departmentList;                            //

    private Long              instituteId;                               // 页面提交和显示的学院id

    private List<Institute>   instituteList;                             //

    private Page<Specialty>   page             = new Page<Specialty>(20);

    // -- ModelDriven 与 Preparable函数 --//
    public Specialty getModel()
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
            entity = specialtyManager.get(id);
        }
        else
        {
            entity = new Specialty();
        }
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    // -- CRUD Action 函数 --//
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("code");
        }
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(Struts2Utils.getRequest());
        page = specialtyManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        // 给系的学院赋页面id域的值
        departmentId = entity.getDepartment() != null ? entity.getDepartment()
                .getId() : 0;
        instituteId = entity.getInstitute() != null ? entity.getInstitute()
                .getId() : 0;
        // 填充学院数据
        instituteList = instituteManager.getAll();
        // 填充系数据
        departmentList = departmentManager.getAll();

        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        // set institute
        if (departmentId != null)
        {
            entity.setDepartment(departmentManager.get(departmentId));
        }
        else
        {
            entity.setDepartment(null);
        }
        entity.setInstitute(instituteManager.get(instituteId));

        // 保存用户并放入成功信息.
        specialtyManager.save(entity);
        addActionMessage("保存专业成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        specialtyManager.delete(id);
        Struts2Utils.renderText("删除专业成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2010-8-20
     * @author houbing.qian
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        specialtyManager.deleteSpecialtys(ids);
        addActionMessage("批量删除学院成功");
        return RELOAD;
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

        List<Specialty> specialties = specialtyManager.getAll();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "专业代码;专业名称;是否本届招生专业;所在学院";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != specialties && specialties.size() > 0)
        {
            for (Specialty specialty : specialties)
            {

                ArrayList rowData = new ArrayList();
                rowData.add(specialty.getCode());
                rowData.add(specialty.getName());
                rowData.add(specialty.isCurrent() ? "是" : "否");
                rowData.add(specialty.getInstitute().getName());
                data.add(rowData);

            }
        }

        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("专业信息");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("专业信息.xls", excel, Struts2Utils.getResponse());

        }
        catch (Exception e)
        {

            e.printStackTrace();

        }

        return null;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<Specialty> getDataList()
    {
        return this.dataList;
    }

    public Long getDepartmentId()
    {
        return departmentId;
    }

    /**
     * list页面显示所有系列表.
     */
    public List<Department> getDepartmentList()
    {
        return departmentList;
    }

    public void setDepartmentId(Long departmentId)
    {
        this.departmentId = departmentId;
    }

    /**
     * list页面显示所有学院列表.
     */
    public List<Institute> getInstituteList()
    {
        return instituteList;
    }

    public Page<Specialty> getPage()
    {
        return page;
    }

    public Long getInstituteId()
    {
        return this.instituteId;
    }

    public void setInstituteId(Long instituteId)
    {
        this.instituteId = instituteId;
    }

}