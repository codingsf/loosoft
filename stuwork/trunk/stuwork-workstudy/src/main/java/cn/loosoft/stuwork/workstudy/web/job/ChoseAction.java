package cn.loosoft.stuwork.workstudy.web.job;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;

/**
 * 
 * 用工选择Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-2-24
 */
@Namespace("/job")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "chose.action", type = "redirect") })
public class ChoseAction extends CrudActionSupport<Jobs>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private JobsManager       jobsManager;

    private AccountManager    accountManager;

    // -- 页面属性 --//
    private Long              id;

    private Jobs              entity;

    private Page<Jobs>        page             = new Page<Jobs>(
                                                       Constant.PAGE_SIZE);

    private String            startPubDate;

    private String            endPubDate;

    private String            startStopDate;

    private String            endStopDate;

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * 根据当前登录的单位id，找到这个单位发布的所有岗位
     * 
     * @since 2011-2-27
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        // 根据单位id去查询。。。。。。暂时没写，等单位搞好后，再写进来。
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("pubdate");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);

        // 根据当前登录用户的id，找到其所在单位。
        // 查询用户对应的单位,没有的话，就显示全部
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());
        // 如果是空，说明不是勤工系统的用户
        if (user != null)
        {
            if (user.getCompanyID() != null)
            {
                String compID = user.getCompanyID().toString();
                filters.add(new PropertyFilter("EQL_company.id", compID));
            }
        }
        page = jobsManager.search(page, filters);

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = jobsManager.get(id);
        }
        else
        {
            entity = new Jobs();
        }
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public Jobs getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    public Jobs getEntity()
    {
        return entity;
    }

    public void setEntity(Jobs entity)
    {
        this.entity = entity;
    }

    public Page<Jobs> getPage()
    {
        return page;
    }

    public void setPage(Page<Jobs> page)
    {
        this.page = page;
    }

    public String getStartPubDate()
    {
        return startPubDate;
    }

    public void setStartPubDate(String startPubDate)
    {
        this.startPubDate = startPubDate;
    }

    public String getEndPubDate()
    {
        return endPubDate;
    }

    public void setEndPubDate(String endPubDate)
    {
        this.endPubDate = endPubDate;
    }

    public String getStartStopDate()
    {
        return startStopDate;
    }

    public void setStartStopDate(String startStopDate)
    {
        this.startStopDate = startStopDate;
    }

    public String getEndStopDate()
    {
        return endStopDate;
    }

    public void setEndStopDate(String endStopDate)
    {
        this.endStopDate = endStopDate;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}
