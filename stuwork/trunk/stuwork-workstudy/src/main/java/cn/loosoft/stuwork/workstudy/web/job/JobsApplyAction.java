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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;

/**
 * 
 * 岗位申报Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-3-3
 */
@Namespace("/job")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "jobs-apply.action", type = "redirect"),
        @Result(name = "detail", location = "jobs-apply-detail.jsp") })
public class JobsApplyAction extends CrudActionSupport<Jobs>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    @Autowired
    private JobsManager       jobsManager;

    @Autowired
    private AccountManager    accountManager;

    // -- 页面属性 --//
    private Long              id;

    private Jobs              entity;

    private Page<Jobs>        page             = new Page<Jobs>(
                                                       Constant.PAGE_SIZE);

    private List<Long>        ids;                                         // 批量id

    private String            startPub;                                    // 开始时间

    private String            endPub;                                      // 结束时间

    public void setEntity(Jobs entity)
    {
        this.entity = entity;
    }

    // -- ModelDriven 与 Preparable函数 --//
    public Jobs getModel()
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
            entity = jobsManager.get(id);
        }
        else
        {
            entity = new Jobs();
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
            page.setOrder(Page.ASC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        // 必须判断是否为null，因为空值传进参数，会报错
        if (startPub != null && endPub != null)
        {
            if (startPub.length() != 0 && endPub.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_pubdate", startPub));
                filters.add(new PropertyFilter("LED_pubdate", endPub));
            }

        }
        // 根据当前登录用户的id，找到其所在单位。没有的话，就显示全部
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

        ParamPropertyUtils.replacePropertyRule(filters);
        filters.add(new PropertyFilter("EQS_auditStatus", Constant.SHZ));
        page = jobsManager.search(page, filters);
        return SUCCESS;
    }

    public String detail()
    {
        this.entity = jobsManager.get(id);
        return "detail";
    }

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        // 保存用户并放入成功信息.
        entity.setCreateDate(DateUtils.getNowTimestamp());
        // 根据当前登录用户的id，找到其所在单位.
        User user = accountManager.getUser(SpringSecurityUtils
                .getCurrentUserName());

        if (user != null)
        {
            entity.setCompany(user.getCompany());
        }
        entity.setPostStatus(Constant.ZPZ);
        entity.setAuditStatus(Constant.SHZ);
        jobsManager.save(entity);
        addActionMessage("岗位保存成功");

        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        jobsManager.delete(id);
        Struts2Utils.renderText("职位删除成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2011-3-3
     * @author bing.hu
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        if (null != ids && ids.size() > 0)
        {
            jobsManager.deletes(ids);
            addActionMessage("批量删除职位成功");
        }
        else
        {
            addActionMessage("没有可删除记录,请勾选");
        }

        return RELOAD;
    }

    /**
     * list页面分页显示所有新闻类型列表.
     */
    public Page<Jobs> getPage()
    {
        return page;
    }

    public Jobs getEntity()
    {
        return entity;
    }

    // -- 其他 Action 函数--//

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    public Long getId()
    {
        return id;
    }

    public String getStartPub()
    {
        return startPub;
    }

    public void setStartPub(String startPub)
    {
        this.startPub = startPub;
    }

    public String getEndPub()
    {
        return endPub;
    }

    public void setEndPub(String endPub)
    {
        this.endPub = endPub;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}
