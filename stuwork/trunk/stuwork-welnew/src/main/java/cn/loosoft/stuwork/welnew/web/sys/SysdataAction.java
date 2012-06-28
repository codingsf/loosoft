package cn.loosoft.stuwork.welnew.web.sys;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.sys.SysData;
import cn.loosoft.stuwork.welnew.service.sys.SysDataManager;

/**
 * 
 * 基础数据设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "sysdata.action", type = "redirect") })
public class SysdataAction extends CrudActionSupport<SysData>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private Long              id;                                     // 编号

    private SysData           languageSet;                            // 基础数据实体

    private List<Long>        ids;                                    // 批量ID

    private Page<SysData>     page             = new Page<SysData>(8); // 分页查询

    private SysDataManager    sysDataManager;                         // 基础数据管理

    public Long getId()
    {
        return id;
    }

    public Page<SysData> getPage()
    {
        return page;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Autowired
    public void setSysDataManager(SysDataManager sysDataManager)
    {
        this.sysDataManager = sysDataManager;
    }

    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.ASC);
            page.setOrderBy("id");
        }
        page = sysDataManager.search(page, SysData.LXFS);// 来校方式

        return SUCCESS;
    }

    /**
     * 批量删除基础数据
     * 
     * @return
     */
    public String deletes()
    {
        sysDataManager.deleteSysData(ids);
        return RELOAD;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            languageSet = sysDataManager.get(id);
        }
        else
        {
            languageSet = new SysData();
            languageSet.setType("lxfs");
        }

    }

    @Override
    public String save() throws Exception
    {
        sysDataManager.save(languageSet);
        return RELOAD;
    }

    public SysData getModel()
    {
        // TODO Auto-generated method stub
        return languageSet;
    }

}
