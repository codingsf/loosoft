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
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;
import cn.loosoft.stuwork.welnew.service.item.DevolveItemManager;

/**
 * 
 * 转移项目设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "devolveitem.action", type = "redirect") })
public class DevolveitemAction extends CrudActionSupport<DevolveItem>
{

    /**
     * serialVersionUID long
     */
    private static final long  serialVersionUID = 1L;

    private DevolveItem        devolveType;                                // 转移实体

    private List<Long>         ids;                                        // 批量id

    private DevolveItemManager devolveItemManager;                         // 转移管理

    private Long               id;                                         // 编号

    private Page<DevolveItem>  page             = new Page<DevolveItem>(8); // 分页查询

    public Page<DevolveItem> getPage()
    {
        return page;
    }

    // /////////////////私有属性
    public void setId(Long id)
    {
        this.id = id;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    @Autowired
    public void setDevolveItemManager(DevolveItemManager devolveItemManager)
    {
        this.devolveItemManager = devolveItemManager;
    }

    // ////////////////////
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
        page = devolveItemManager.search(page);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            devolveType = devolveItemManager.get(id);
        }
        else
        {
            devolveType = new DevolveItem();
        }

    }

    /**
     * 支持使用Jquery.validate Ajax检验用户名是否重复.
     * 
     * @throws UnsupportedEncodingException
     */
    public String checkName() throws UnsupportedEncodingException
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setCharacterEncoding("UTF-8");
        String newName = request.getParameter("name");
        newName = new String(newName.getBytes("ISO-8859-1"), "UTF-8");
        String oldName = request.getParameter("oldName");

        if (devolveItemManager.isDevolveItemUnique(newName, oldName))
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

    /**
     * 批量删除转移项目设置
     * 
     * @return
     */
    public String deletes()
    {
        devolveItemManager.deleteDevolveItem(ids);
        return RELOAD;
    }

    @Override
    public String save() throws Exception
    {
        devolveItemManager.save(devolveType);
        return RELOAD;
    }

    public DevolveItem getModel()
    {
        // TODO Auto-generated method stub
        return devolveType;
    }

}
