package cn.loosoft.stuwork.welnew.web.item;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;

/**
 * 
 * 缴费项目设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "costitem.action", type = "redirect") })
public class CostitemAction extends CrudActionSupport<CostItem>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private CostItem          cost;                                        // 缴费实体

    private Long              id;                                          // 编号

    private CostItemManager   costItemManager;                             // 缴费管理

    private List<Long>        ids;                                         // 批量ID

    private Page<CostItem>    page             = new Page<CostItem>(
                                                       Constant.PAGE_SIZE); // 分页查询

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
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.ASC);
            page.setOrderBy("id");
        }
        page = costItemManager.search(page);
        return SUCCESS;
    }

    /**
     * 支持使用Jquery.validate Ajax检验用户名是否重复.
     * 
     * @throws UnsupportedEncodingException
     */
    public String checkProject() throws UnsupportedEncodingException
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setCharacterEncoding("UTF-8");
        String newProject = request.getParameter("project");
        newProject = new String(newProject.getBytes("ISO-8859-1"), "UTF-8");
        String oldProject = request.getParameter("oldProject");

        if (costItemManager.isCostItemUnique(newProject, oldProject))
        {
            Struts2Utils.renderText("true");
        }
        else
        {
            Struts2Utils.renderText("false");
        }
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            cost = costItemManager.get(id);
        }
        else
        {
            cost = new CostItem();
        }

    }

    @Override
    public String save() throws Exception
    {
        costItemManager.save(cost);
        return RELOAD;
    }

    public String deletes()
    {
        costItemManager.deleteCost(ids);
        return RELOAD;
    }

    public CostItem getModel()
    {
        return cost;
    }

    @Autowired
    public void setCostItemManager(CostItemManager costItemManager)
    {
        this.costItemManager = costItemManager;
    }

}
