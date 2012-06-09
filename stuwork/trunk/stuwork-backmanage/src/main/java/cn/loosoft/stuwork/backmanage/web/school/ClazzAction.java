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

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.backmanage.service.school.ClazzManager;
import cn.loosoft.stuwork.backmanage.service.school.SpecialtyManager;
import cn.loosoft.stuwork.backmanage.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelModel;
import cn.loosoft.stuwork.common.StudentType;

/**
 * 
 * 班级管理Action.
 * 
 * @author houbing.qian
 * @author shanru.wu
 * @version 1.0
 * @version 1.1
 * @since 2010-8-21
 * @since 2011-3-17
 */
@Namespace("/school")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "clazz.action", type = "redirect") })
public class ClazzAction extends CrudActionSupport<Clazz>
{

    private static final long serialVersionUID = 1L;

    @Autowired
    private SpecialtyManager  specialtyManager;

    @Autowired
    private ClazzManager      clazzManager;

    // -- 页面属性 --//
    private Long              id;

    private Clazz             entity;

    private List<Clazz>       dataList;                              // 列表页显示数据

    private List<Long>        ids;                                   // 批量

    private String            specialtyCode;                         // 页面提交和显示的专业code

    // key

    private List<Specialty>   specialtyList;                         //

    private Page<Clazz>       page             = new Page<Clazz>(20);

    private List<LabelValue>  typeList;

    private List<LabelValue>  clazzTypes;

    // -- ModelDriven 与 Preparable函数 --//
    public Clazz getModel()
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
            entity = clazzManager.get(id);
        }
        else
        {
            entity = new Clazz();
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
        page = clazzManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        // 给系的学院赋页面id域的值
        specialtyCode = entity.getSpecialty() != null ? entity.getSpecialty()
                .getCode() : "";
        // 填充学院数据
        specialtyList = specialtyManager.getAll();
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        // set institute
        entity.setSpecialty(specialtyManager.getByCode(specialtyCode));
        // 保存用户并放入成功信息.
        clazzManager.save(entity);
        addActionMessage("保存系成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        clazzManager.delete(id);
        Struts2Utils.renderText("删除班级成功");
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
        clazzManager.deleteClazzs(ids);
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
        // if (!page.isOrderBySetted())
        // {
        // page.setOrder(Page.DESC);
        // page.setOrderBy("code");
        // }
        // List<PropertyFilter> filters = HibernateUtils
        // .buildPropertyFilters(request);
        // page = clazzManager.search(page, filters);

        List<Clazz> clazzs = clazzManager.getAll();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "班级代码;班级名称;所属入学年份;所属入学季节;辅导员;辅导员电话;预设教室;所在专业;培养方式;班主任;班主任电话";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != clazzs && clazzs.size() > 0)
        {
            for (Clazz clazz : clazzs)
            {

                ArrayList rowData = new ArrayList();
                rowData.add(clazz.getCode());
                rowData.add(clazz.getName());
                rowData.add(clazz.getYear());
                rowData.add(clazz.getSeason());
                rowData.add(clazz.getLeader());
                rowData.add(clazz.getLeaderTelnum());
                rowData.add(clazz.getRoom());

                rowData.add(clazz.getSpecialty().getName());
                rowData.add(StudentType.getDesc(clazz.getType()));
                rowData.add(clazz.getTeacher());
                rowData.add(clazz.getTeacherTelnum());
                data.add(rowData);

            }
        }

        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("班级信息");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("班级信息.xls", excel, Struts2Utils.getResponse());

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
    public List<Clazz> getDataList()
    {
        return this.dataList;
    }

    public List<LabelValue> getTypeList()
    {
        this.typeList = StudentType.enumList;
        return typeList;
    }

    public Page<Clazz> getPage()
    {
        return page;
    }

    /**
     * list页面显示所有班级类型列表.
     */
    public List<LabelValue> getClazzTypes()
    {
        this.clazzTypes = StudentType.enumList;
        return clazzTypes;
    }

    public String getSpecialtyCode()
    {
        return specialtyCode;
    }

    /**
     * list页面显示所有系列表.
     */
    public List<Specialty> getSpecialtyList()
    {
        return specialtyList;
    }

    public void setSpecialtyCode(String specialtyCode)
    {
        this.specialtyCode = specialtyCode;
    }

}