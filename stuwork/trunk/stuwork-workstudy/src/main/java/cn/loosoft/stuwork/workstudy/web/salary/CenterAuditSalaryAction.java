//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.workstudy.web.salary;

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

import cn.common.lib.vo.LabelValue;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.salary.Salary;
import cn.loosoft.stuwork.workstudy.service.salary.SalaryManager;

/**
 * 
 * 小组审核工资单Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-5
 */
@Namespace("/salary")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "center-audit-salary.action", type = "redirect"),
        @Result(name = "centerNoPass", location = "centerNoPass.jsp"),
        @Result(name = "nopassrecheck-detail", location = "../job/nopassrecheck-detail.jsp") })
public class CenterAuditSalaryAction extends CrudActionSupport<Salary>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private Salary            entity;

    private SalaryManager     salaryManager;

    // 页面属性
    private Long              id;

    private Page<Salary>      page             = new Page<Salary>(
                                                       Constant.PAGE_SIZE);

    private List<LabelValue>  statusList;

    private String            startWorkStartTime;

    private String            endWorkStartTime;

    private String            startWorkStopTime;

    private String            endWorkStopTime;

    /**
     * 小组审核工资通过
     */
    public String pass()
    {
        this.entity = salaryManager.get(id);
        entity.setCenterStatus(Constant.SHTG);
        entity.setCenterNoPassReason("");
        salaryManager.save(entity);
        // 因为直接输出内容而不经过jsp,因此返回null.
        Struts2Utils.renderText("操作成功,中心审核工资通过");
        return null;
    }

    /**
     * 
     * 中心审核工资不通过
     * 
     * @since 2011-3-6
     * @author Administrator
     * @return
     */
    public String unPass()
    {
        this.entity = salaryManager.get(id);
        return "centerNoPass";
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("createDate");
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        // 必须判断是否为null，因为空值传进参数，会报错
        if (startWorkStartTime != null && endWorkStartTime != null)
        {
            if (startWorkStartTime.length() != 0
                    && endWorkStartTime.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_workStartTime",
                        startWorkStartTime));
                filters.add(new PropertyFilter("LED_workStartTime",
                        endWorkStartTime));
            }
        }
        if (startWorkStopTime != null && endWorkStopTime != null)
        {
            if (startWorkStopTime.length() != 0
                    && endWorkStopTime.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_workStopTime",
                        startWorkStopTime));
                filters.add(new PropertyFilter("LED_workStopTime",
                        endWorkStopTime));
            }
        }
        filters.add(new PropertyFilter("EQS_groupStatus", Constant.SHTG));
        page = salaryManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = salaryManager.get(id);
        }
        else
        {
            entity = new Salary();
        }

    }

    @Override
    public String save() throws Exception
    {
        this.entity.setCenterStatus(Constant.SHWTG);
        salaryManager.save(entity);
        addActionMessage("原因填写成功!");
        return RELOAD;
    }

    /**
     * 查看中心未过原因 Description of this Method
     * 
     * @since 2011-3-17
     * @author bing.hu
     * @return
     */
    public String nopassrecheckDetail()
    {
        this.entity = salaryManager.get(id);
        return "nopassrecheck-detail";
    }

    public Salary getModel()
    {
        return entity;
    }

    @Autowired
    public void setSalaryManager(SalaryManager salaryManager)
    {
        this.salaryManager = salaryManager;
    }

    public Page<Salary> getPage()
    {
        return page;
    }

    public void setPage(Page<Salary> page)
    {
        this.page = page;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Salary getEntity()
    {
        return entity;
    }

    public void setEntity(Salary entity)
    {
        this.entity = entity;
    }

    public List<LabelValue> getStatusList()
    {
        return statusList = new Constant().getStatusList();
    }

    public String getStartWorkStartTime()
    {
        return startWorkStartTime;
    }

    public void setStartWorkStartTime(String startWorkStartTime)
    {
        this.startWorkStartTime = startWorkStartTime;
    }

    public String getEndWorkStartTime()
    {
        return endWorkStartTime;
    }

    public void setEndWorkStartTime(String endWorkStartTime)
    {
        this.endWorkStartTime = endWorkStartTime;
    }

    public String getStartWorkStopTime()
    {
        return startWorkStopTime;
    }

    public void setStartWorkStopTime(String startWorkStopTime)
    {
        this.startWorkStopTime = startWorkStopTime;
    }

    public String getEndWorkStopTime()
    {
        return endWorkStopTime;
    }

    public void setEndWorkStopTime(String endWorkStopTime)
    {
        this.endWorkStopTime = endWorkStopTime;
    }

}
