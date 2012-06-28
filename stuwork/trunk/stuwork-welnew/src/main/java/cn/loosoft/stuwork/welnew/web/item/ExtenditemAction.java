package cn.loosoft.stuwork.welnew.web.item;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;

/**
 * 
 * 发放项目设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "extenditem.action", type = "redirect") })
public class ExtenditemAction extends CrudActionSupport<CostItem>
{

    private static final long serialVersionUID = 1L;

    private List<Long>        ids;                                     // 批量id

    private CostItem          costItem;

    private CostItemManager   costItemManager;                         // 缴费项目管理

    private Long              id;                                      // 编号

    private List<CostItem>    costItemList;                            // 缴费项目设置

    private Page<CostItem>    page             = new Page<CostItem>(8); // 分页查询

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Autowired
    public void setCostItemManager(CostItemManager costItemManager)
    {
        this.costItemManager = costItemManager;
    }

    public Page<CostItem> getPage()
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
    public String list() throws Exception
    {
        // TODO Auto-generated method stub
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.ASC);
            page.setOrderBy("id");
        }
        List<PropertyFilter> list = new ArrayList<PropertyFilter>();
        list.add(new PropertyFilter("EQB_give", "1"));
        page = costItemManager.search(page, list);
        return SUCCESS;
    }

    /**
     * 批量删除发放项目设置
     * 
     * @return
     */
    public String deletes()
    {
        costItemManager.updateCost(ids);
        return RELOAD;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            costItem = costItemManager.get(id);
        }
        else
        {
            costItem = new CostItem();
        }

    }

    @Override
    public String save() throws Exception
    {
        costItemManager.save(costItem);
        addActionMessage("保存发放项目设置成功");
        return RELOAD;
    }

    public CostItem getModel()
    {
        // TODO Auto-generated method stub
        return costItem;
    }

    /**
     * @return the costItemList
     */
    public List<CostItem> getCostItemList()
    {
        costItemList = costItemManager.getAll();
        return costItemList;
    }
}
