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
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.service.school.InstituteManager;
import cn.loosoft.stuwork.backmanage.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelModel;

/**
 * 
 * 学院管理Action.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-19
 */
@Namespace("/school")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "institute.action", type = "redirect") })
public class InstituteAction extends CrudActionSupport<Institute>
{

    private static final long serialVersionUID = 1L;

    @Autowired
    private InstituteManager  instituteManager;

    // -- 页面属性 --//
    private Long              id;

    private Institute         entity;

    private List<Institute>   dataList;                                  // 学区列表

    private Page<Institute>   page             = new Page<Institute>(20);

    private List<Long>        ids;                                       // 批量id

    // -- ModelDriven 与 Preparable函数 --//
    public Institute getModel()
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
            entity = instituteManager.get(id);
        }
        else
        {
            entity = new Institute();
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
        page = instituteManager.search(page, filters);
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
        // 保存用户并放入成功信息.
        instituteManager.save(entity);
        addActionMessage("保存学院成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        instituteManager.delete(id);
        Struts2Utils.renderText("删除学院成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
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
        List<Institute> institutes = instituteManager.getAll();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学院代码;学院地址;院长;院办公地址";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != institutes && institutes.size() > 0)
        {
            for (Institute institute : institutes)
            {
                ArrayList rowData = new ArrayList();
                rowData.add(institute.getCode());
                rowData.add(institute.getName());
                rowData.add(institute.getLeader());
                rowData.add(institute.getAddress());
                data.add(rowData);
            }
        }
        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("学院信息");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("学院信息.xls", excel, Struts2Utils.getResponse());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

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
        instituteManager.deleteInstitutes(ids);
        addActionMessage("批量删除学院成功");
        return RELOAD;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<Institute> getDataList()
    {
        return this.dataList;
    }

    public Page<Institute> getPage()
    {
        return page;
    }

}