package cn.loosoft.stuwork.welnew.web.batch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.util.date.DateUtils;
import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;

/**
 * 
 * 迎新批次管理Action.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-19
 */
@Namespace("/batch")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "welbatch.action", type = "redirect") })
public class WelbatchAction extends CrudActionSupport<Welbatch>
{
    private static final long serialVersionUID = 1L;

    private WelbatchManager   welbatchManager;

    // -- 页面属性 --//
    private Long              id;

    private Welbatch          entity;

    private List<Welbatch>    dataList;                                 // 列表页面显示数据

    private Page<Welbatch>    page             = new Page<Welbatch>(10);

    private List<Long>        ids;                                      // 批量id

    private String            season;

    public String getSeason()
    {
        return season;
    }

    public void setSeason(String season)
    {
        this.season = season;
    }

    // -- ModelDriven 与 Preparable函数 --//
    public Welbatch getModel()
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
            entity = welbatchManager.get(id);
        }
        else
        {
            entity = new Welbatch();
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
        // boolean isAsc = false;
        // dataList = welbatchManager.getAll("year", isAsc);

        if (!page.isOrderBySetted())
        {
            page.setOrderBy("year");
            page.setOrder(Page.ASC);
        }

        page = welbatchManager.search(page);
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
        return RELOAD;
    }

    public String sav() throws Exception
    {

        HttpServletRequest request = Struts2Utils.getRequest();
        String year = ParamUtils.getParameter(request, "year");
        String startdate = ParamUtils.getParameter(request, "startdate");
        String enddate = ParamUtils.getParameter(request, "enddate");
        boolean current = Boolean.parseBoolean(ParamUtils.getParameter(request,
                "current"));
        if (current)
        {
            welbatchManager.disabledCurrent();
        }

        if (null != id)
        {
            entity = welbatchManager.get(id);
        }
        else
        {
            entity = new Welbatch();
        }

        entity.setYear(year);
        entity.setSeason(season);
        entity.setStartdate(DateUtils.getDate(startdate, "yyyy-MM-dd"));
        entity.setEnddate(DateUtils.getDate(enddate, "yyyy-MM-dd"));
        entity.setCurrent(current);
        welbatchManager.save(entity);
        addActionMessage("保存批次成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        welbatchManager.delete(id);
        Struts2Utils.renderText("删除批次成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    public String deletes() throws Exception
    {
        welbatchManager.deleteBatchs(ids);
        addActionMessage("批量删除批次成功");
        return RELOAD;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有批次列表.
     */
    public List<Welbatch> getDataList()
    {
        return this.dataList;
    }

    public Long getId()
    {
        return id;
    }

    public Page<Welbatch> getPage()
    {
        return page;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

}