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
package cn.loosoft.stuwork.welnew.web.noticeBook;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.moveutil.ReportNotice;
import cn.loosoft.stuwork.welnew.service.moveutil.ReportNoticeManager;

/**
 * 报道须知管理Action Description of the class
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-6
 */
@Namespace("/noticeBook")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "report-notice.action", type = "redirect") })
public class ReportNoticeAction extends CrudActionSupport<ReportNotice>
{

    /**
     * serialVersionUID long
     */
    private static final long   serialVersionUID = 1L;

    private ReportNoticeManager reportNoticeManager;

    // 页面属性
    private Long                id;

    private List<Long>          ids;

    private ReportNotice        entity;

    private Page<ReportNotice>  page             = new Page<ReportNotice>(
                                                         Constant.PAGE_SIZE);

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public ReportNotice getEntity()
    {
        return entity;
    }

    public void setEntity(ReportNotice entity)
    {
        this.entity = entity;
    }

    public Page<ReportNotice> getPage()
    {
        return page;
    }

    public void setPage(Page<ReportNotice> page)
    {
        this.page = page;
    }

    @Autowired
    public void setReportNoticeManager(ReportNoticeManager reportNoticeManager)
    {
        this.reportNoticeManager = reportNoticeManager;
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
        page = reportNoticeManager.search(page);

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub
        if (id != null)
        {
            entity = reportNoticeManager.get(id);
        }
        else
        {
            entity = new ReportNotice();
        }
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        this.entity.setStatus("未用");
        reportNoticeManager.save(entity);
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        reportNoticeManager.delete(id);
        Struts2Utils.renderText("删除记录成功");
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
            reportNoticeManager.deletes(ids);
            addActionMessage("批量删除成功");
        }
        else
        {
            addActionMessage("没有可删除记录,请勾选");
        }

        return RELOAD;
    }

    /**
     * 修改使用状态
     * 
     */
    public String using() throws Exception
    {
        this.entity = reportNoticeManager.get(id);
        this.entity.setStatus("使用");
        reportNoticeManager.save(entity);

        return RELOAD;

    }

    public ReportNotice getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    public List<Long> getIds()
    {
        return ids;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

}
