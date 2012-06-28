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
import cn.loosoft.stuwork.welnew.entity.item.CheckItem;
import cn.loosoft.stuwork.welnew.service.item.CheckItemManager;

/**
 * 
 * 审查项目设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "checkitem.action", type = "redirect") })
public class CheckitemAction extends CrudActionSupport<CheckItem>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private CheckItem         checkUp;                                  // 审查实体

    private List<Long>        ids;                                      // 批量id

    private Long              id;                                       // 编号

    private CheckItemManager  checkItemManager;                         // 审查管理

    private Page<CheckItem>   page             = new Page<CheckItem>(8); // 分页查询

    public Page<CheckItem> getPage()
    {
        return page;

    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Autowired
    public void setCheckItemManager(CheckItemManager checkItemManager)
    {
        this.checkItemManager = checkItemManager;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.ASC);
            page.setOrderBy("id");
        }
        page = checkItemManager.search(page);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            checkUp = checkItemManager.get(id);
        }
        else
        {
            checkUp = new CheckItem();
        }

    }

    /**
     * 批量删除审查项目设置
     * 
     * @return
     */
    public String deletes()
    {
        checkItemManager.deleteCheckItem(ids);
        return RELOAD;
    }

    @Override
    public String save() throws Exception
    {
        checkItemManager.save(checkUp);
        return RELOAD;
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

        if (checkItemManager.isCheckItemUnique(newProject, oldProject))
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

    public CheckItem getModel()
    {
        // TODO Auto-generated method stub
        return checkUp;
    }

}
