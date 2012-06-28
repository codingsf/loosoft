package cn.loosoft.stuwork.workstudy.web.batch;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.entity.batch.Workstudybatch;
import cn.loosoft.stuwork.workstudy.service.batch.WorkstudybatchManager;

/**
 * 
 * 勤工助学批次管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-2-28
 */
@Namespace("/batch")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "workstudybatch.action", type = "redirect") })
public class WorkstudybatchAction extends CrudActionSupport<Workstudybatch>
{

    private static final long     serialVersionUID = 1L;

    @Autowired
    private WorkstudybatchManager batchManager;

    // -- 页面属性 --//
    private Long                  id;

    private Workstudybatch        entity;

    private List<Workstudybatch>  dataList;             // 列表页面显示数据

    private List<Long>            ids;                  // 批量id

    // -- ModelDriven 与 Preparable函数 --//
    public Workstudybatch getModel()
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
            entity = new Workstudybatch();
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
        Workstudybatch workstudybatch = batchManager.getCurrentBatch();
        // 保存用户并放入成功信息.
        batchManager.save(entity, workstudybatch);
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
        batchManager.deleteBatchs(ids);
        addActionMessage("批量删除批次成功");
        return RELOAD;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有批次列表.
     */
    public List<Workstudybatch> getDataList()
    {
        return this.dataList;
    }
}
