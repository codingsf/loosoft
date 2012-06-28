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
package cn.loosoft.stuwork.stuinfo.web.student;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.stuinfo.entity.batch.Batch;
import cn.loosoft.stuwork.stuinfo.entity.student.BankChange;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;
import cn.loosoft.stuwork.stuinfo.service.student.BankChangeManager;

/**
 * 
 * 银行账号异动管理Action.
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-10-19
 */
@Namespace("/student")
public class BankChangeAction extends CrudActionSupport<BankChange>
{

    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    private String                   pageCode         = "";                      // 分页显示数

    private List<LabelValue>         selectPageList;

    private String                   collegeCode;

    private String                   classCode;

    private String                   majorCode;

    private Page<BankChange>         page             = new Page<BankChange>(20);

    private List<Batch>              batches;

    // 批量删除ID

    private Long                     id;

    // ==页面访问函数== //

    private BankChange               bankChange;

    // 批次列表

    private final String             total            = "0";

    private final String             failnum          = "0";

    private final String             failstr          = "";

    private BankChangeManager        bankChangeManager;                          // 异动manage

    private BatchManager             batchManager;

    @Override
    public String list() throws Exception
    {
        // 设置分页属性
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("operateDateTime");
            page.setOrder(Page.DESC);
        }

        // 设置过滤器
        HttpServletRequest req = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils.buildPropertyFilters(req);
        ParamPropertyUtils.replacePropertyRule(filters);

        // 查询
        String endChangeDateTime = ParamUtils.getParameter(request,
                "endChangeDateTime", null);

        if (StringUtils.isNotBlank(endChangeDateTime))
        {
            filters.add(new PropertyFilter("LED_operateDateTime",
                    endChangeDateTime + " 23:59:59"));
        }
        page = bankChangeManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    public String save() throws Exception
    {
        return RELOAD;
    }

    @Override
    public String delete()
    {
        return RELOAD;
    }

    // ==ModelDriven 与 Preparable函数 == //
    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            bankChange = bankChangeManager.get(id);
        }
        else
        {
            bankChange = new BankChange();
        }
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public BankChange getModel()
    {
        return bankChange;
    }

    // ==CRUD Action 函数== //
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    public String getPageCode()
    {
        return pageCode;
    }

    @Autowired
    public void setBatchManager(BatchManager batchManager)
    {
        this.batchManager = batchManager;
    }

    @Autowired
    public void setBankChangeManager(BankChangeManager bankChangeManager)
    {
        this.bankChangeManager = bankChangeManager;
    }

    public List<LabelValue> getSelectPageList()
    {
        selectPageList = new ArrayList<LabelValue>();
        selectPageList.add(new LabelValue("10", "10"));
        selectPageList.add(new LabelValue("15", "15"));
        selectPageList.add(new LabelValue("20", "20"));
        return selectPageList;
    }

    // -- 页面属性访问函数 --//
    public String getTotal()
    {
        return total;
    }

    public String getFailnum()
    {
        return failnum;
    }

    public String getFailstr()
    {
        return failstr;
    }

    public Page<BankChange> getPage()
    {
        return page;
    }

    public BankChange getBankChange()
    {
        return bankChange;
    }

    public void setPageCode(String pageCode)
    {
        this.pageCode = pageCode;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    // 批次
    public List<Batch> getBatches()
    {

        try
        {
            this.batches = batchManager.getAll();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.batches == null)
        {
            this.batches = new ArrayList<Batch>();
        }

        return batches;
    }
}
