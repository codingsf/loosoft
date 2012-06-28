package cn.loosoft.stuwork.workstudy.web.news;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.news.News;
import cn.loosoft.stuwork.workstudy.entity.sys.NewsType;
import cn.loosoft.stuwork.workstudy.service.news.NewsManager;
import cn.loosoft.stuwork.workstudy.service.sys.NewsTypeManager;

/**
 * 
 * 新闻管理Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-25
 */
@Namespace("/news")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "news.action", type = "redirect"),
        @Result(name = "detail", location = "news-detail.jsp") })
public class NewsAction extends CrudActionSupport<News>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private NewsManager       newsManager;

    private NewsTypeManager   newsTypeManager;

    // -- 页面属性 --//
    private Long              id;

    private News              entity;

    private List<NewsType>    dataList;                                    // 列表页面显示数据

    private Page<News>        page             = new Page<News>(
                                                       Constant.PAGE_SIZE);

    private List<Long>        ids;                                         // 批量id

    // -- ModelDriven 与 Preparable函数 --//
    public News getModel()
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
            entity = newsManager.get(id);
        }
        else
        {
            entity = new News();
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
            page.setOrderBy("pubdate");
            page.setOrder(Page.DESC);
        }
        page = newsManager.search(page);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    public String detail()
    {
        this.entity = newsManager.get(id);
        return "detail";
    }

    @Override
    public String save() throws Exception
    {

        entity.setPubuser(SpringSecurityUtils.getCurrentUserName());
        entity.setPubdate(DateUtils.getNowTimestamp());
        // 保存用户并放入成功信息.
        newsManager.save(entity);
        addActionMessage("保存新闻成功");

        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        newsManager.delete(id);
        Struts2Utils.renderText("删除新闻成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2011-2-25
     * @author bing.hu
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        if (null != ids && ids.size() > 0)
        {
            newsManager.deletes(ids);
            addActionMessage("批量删除新闻成功");
        }
        else
        {
            addActionMessage("没有可删除记录,请勾选");
        }

        return RELOAD;
    }

    /**
     * list页面显示所有新闻类型列表.
     */
    public List<NewsType> getDataList()
    {
        this.dataList = newsTypeManager.getAll();
        return this.dataList;
    }

    /**
     * list页面分页显示所有新闻类型列表.
     */
    public Page<News> getPage()
    {
        return page;
    }

    // -- 其他 Action 函数 --//
    @Autowired
    public void setNewsManager(NewsManager newsManager)
    {
        this.newsManager = newsManager;
    }

    @Autowired
    public void setNewsTypeManager(NewsTypeManager newsTypeManager)
    {
        this.newsTypeManager = newsTypeManager;
    }

    public void setEntity(News entity)
    {
        this.entity = entity;
    }

    public News getEntity()
    {
        return entity;
    }

    public void setPage(Page<News> page)
    {
        this.page = page;
    }
}
