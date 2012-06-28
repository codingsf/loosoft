package cn.loosoft.stuwork.workstudy.web.company;

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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.company.Company;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.company.CompanyManager;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;

/**
 * 
 * 单位设置Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */

@Namespace("/company")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "company.action", type = "redirect"),
        @Result(name = "detail", location = "company-detail.jsp") })
public class CompanyAction extends CrudActionSupport<Company>
{

    private static final long serialVersionUID = 1L;

    private CompanyManager    companyManager;

    private JobsManager       jobsManager;

    private AccountManager    accountManager;

    // -- 页面属性 --//
    private Long              id;

    private Company           entity;

    private Page<Company>     page             = new Page<Company>(
                                                       Constant.PAGE_SIZE);

    private List<Long>        ids;                                         // 批量id

    List<Jobs>                jobList;

    public void setJobList(List<Jobs> jobList)
    {
        this.jobList = jobList;
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
        // TODO Auto-generated method stub

        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        page = companyManager.search(page, filters);
        return SUCCESS;
    }

    /**
     * 查看详细信息
     * 
     * @since 2011-2-28
     * @author bing.hu
     * @return
     */
    public String detail()
    {
        this.entity = companyManager.get(id);
        return "detail";
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub
        if (id != null)
        {
            entity = companyManager.get(id);
        }
        else
        {
            entity = new Company();
        }
    }

    @Override
    public String save() throws Exception
    {
        // 保存单位并放入成功信息.
        entity.setFreeze("using");
        companyManager.save(entity);
        addActionMessage("保存单位成功");

        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        if (accountManager.findCompanyId(id).size() > 0)
        {
            Struts2Utils.renderText("此单位在正在使用中..只能停用..不能删除!");
        }
        else
        {

            // 先删除单位信息
            companyManager.delete(id);
            // 查找此单位对应的岗位信息
            jobList = jobsManager.findcompany(id);
            // 循环删除此单位对应的岗位信息
            for (int i = 0; i < jobList.size(); i++)
            {
                jobsManager.delete(jobList.get(i).getId());
            }

            Struts2Utils.renderText("删除单位成功");
            // 因为直接输出内容而不经过jsp,因此返回null.
        }
        return null;

    }

    /**
     * 
     * 删除多笔记录
     * 
     * @since 2011-2-15
     * @author bing.hu
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception
    {
        if (null != ids && ids.size() > 0)
        {
            if (accountManager.findCompanyId(id).size() > 0)
            {
                Struts2Utils.renderText("此单位在正在使用中..只能停用..不能删除!");
            }
            else
            {
                companyManager.deletes(ids);
                jobList = jobsManager.findcompany(id);
                // 循环删除此单位对应的岗位信息
                for (int i = 0; i < jobList.size(); i++)
                {
                    jobsManager.delete(jobList.get(i).getId());
                }
                addActionMessage("批量删单位成功");
            }
        }
        else
        {
            addActionMessage("没有可删除记录,请勾选");
        }

        return RELOAD;
    }

    /**
     * 冻结单位 //如果此单位在使用中。。只能被冻结，不能被删除 Description of this Method
     * 
     * @since 2011-3-16
     * @author bing.hu
     * @return
     */
    public String freeze()
    {
        this.entity = companyManager.get(id);
        entity.setFreeze("stop");
        companyManager.save(entity);
        return RELOAD;

    }

    /**
     * 启用此单位 Description of this Method
     * 
     * @since 2011-3-16
     * @author bing.hu
     * @return
     */
    public String using()
    {
        this.entity = companyManager.get(id);
        entity.setFreeze("using");
        companyManager.save(entity);
        return RELOAD;

    }

    public Company getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    public void setPage(Page<Company> page)
    {
        this.page = page;
    }

    public Page<Company> getPage()
    {
        return page;
    }

    @Autowired
    public void setCompanyManager(CompanyManager companyManager)
    {
        this.companyManager = companyManager;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public Company getEntity()
    {
        return entity;
    }

    @Autowired
    public void setJobsManager(JobsManager jobsManager)
    {
        this.jobsManager = jobsManager;
    }

    public Long getId()
    {
        return id;
    }

    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }

}
