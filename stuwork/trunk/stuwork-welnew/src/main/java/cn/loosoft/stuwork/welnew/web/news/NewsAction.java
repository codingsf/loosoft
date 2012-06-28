package cn.loosoft.stuwork.welnew.web.news;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.NewsType;
import cn.loosoft.stuwork.welnew.entity.news.News;
import cn.loosoft.stuwork.welnew.service.news.NewsManager;

/**
 * 
 * 新闻网站管理Action.
 * 
 * @author jie.yange
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/news")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "news.action", type = "redirect") })
public class NewsAction extends CrudActionSupport<News>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private NewsManager       newManager;                          // 新闻管理类

    private News              news;                                // 新闻实体类

    private Long              id;

    private Page<News>        page             = new Page<News>(8); // 列表页面显示数据

    private List<Long>        ids;                                 // 批量id

    @Override
    public String input() throws Exception
    {
        new Object();
        return INPUT;
    }

    /**
     * 显示新闻的入学须知和报到须知
     */
    @Override
    public String list() throws Exception
    {
        // 设置默认排序方式
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("topTime,postTime");
            page.setOrder("desc,desc");
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);

        // 获取发布时间的结束时间
        String endPostTime = ParamUtils.getParameter(request, "endPostTime",
                null);
        if (StringUtils.isNotBlank(endPostTime))
        {
            filters.add(new PropertyFilter("LED_postTime", endPostTime
                    + " 23:59:59"));
        }
        // 查询
        page = newManager.search(page, filters);
        return SUCCESS;
    }

    /**
     * 保存
     * 
     * @since 2011-7-23
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        if (news != null)
        {
            if (news.isTop() == true)
            {
                news.setTopTime(new Date());
            }
            else
            {
                news.setTopTime(null);
            }
        }
        newManager.save(news);
        return RELOAD;
    }

    /**
     * 
     * 删除,包括单个删除和批量删除
     * 
     * @since 2011-7-23
     * @author fangyong
     * @return
     */
    public String deletes()
    {
        if (null == id && null != ids)
        {
            newManager.DeleteNews(ids);
        }
        else
            if (null != id)
            {
                newManager.delete(id);
            }
        return RELOAD;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            news = newManager.get(id);
            System.out.println(news.isTop());
        }
        else
        {
            news = new News();
            User user = (User) SpringSecurityUtils.getCurrentUser();
            news.setPostTime(new Date());
            news.setPublisher(user.getName());

        }

    }

    public News getModel()
    {
        return news;
    }

    @Autowired
    public void setNewManager(NewsManager newManager)
    {
        this.newManager = newManager;
    }

    public List<LabelValue> getNewTypeList()
    {
        return NewsType.newTypeList;
    }

    // -- ModelDriven 与 Preparable函数 --//
    public void setId(Long id)
    {
        this.id = id;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public Page<News> getPage()
    {
        return page;
    }
}
