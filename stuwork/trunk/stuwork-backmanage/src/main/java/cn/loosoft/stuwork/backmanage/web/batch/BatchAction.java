package cn.loosoft.stuwork.backmanage.web.batch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.util.date.DateUtils;
import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.batch.Batch;
import cn.loosoft.stuwork.backmanage.service.batch.BatchManager;

/**
 * 
 * 批次管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-7
 */
@Namespace("/batch")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "batch.action", type = "redirect") })
public class BatchAction extends CrudActionSupport<Batch>
{

    private static final long serialVersionUID = 1L;

    @Autowired
    private BatchManager      batchManager;

    // -- 页面属性 --//
    private Long              id;

    private Batch             entity;

    private List<Batch>       dataList;             // 列表页面显示数据

    private List<Long>        ids;                  // 批量id

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
    public Batch getModel()
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
            entity = batchManager.get(id);
        }
        else
        {
            entity = new Batch();
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
        boolean isAsc = false;
        dataList = batchManager.getAll("year", isAsc);
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
            batchManager.disabledCurrent();
        }

        if (null != id)
        {
            entity = batchManager.get(id);
        }
        else
        {
            entity = new Batch();
        }

        entity.setYear(year);
        entity.setSeason(season);
        entity.setStartdate(DateUtils.getDate(startdate, "yyyy-MM-dd"));
        entity.setEnddate(DateUtils.getDate(enddate, "yyyy-MM-dd"));
        entity.setCurrent(current);
        batchManager.save(entity);
        addActionMessage("保存批次成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        batchManager.delete(id);
        Struts2Utils.renderText("删除批次成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    public String deletes() throws Exception
    {
        if (null != this.ids && this.ids.size() > 0)
        {
            batchManager.deleteBatchs(ids);
            addActionMessage("批量删除批次成功");
        }
        else
        {
            addActionMessage("没有可删除记录，请勾选");
        }
        return RELOAD;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有批次列表.
     */
    public List<Batch> getDataList()
    {
        return this.dataList;
    }

    public Long getId()
    {
        return id;
    }
}
