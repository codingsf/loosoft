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
package cn.loosoft.stuwork.arch.web.returnlog;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;
import cn.loosoft.stuwork.arch.entity.returnlog.ReturnLog;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.lendlog.LendLogManager;
import cn.loosoft.stuwork.arch.service.returnlog.ReturnLogManager;

/**
 * 
 * 档案归档管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-18
 */
@Namespace("/returnlog")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "return-log.action", type = "redirect"),
        @Result(name = ReturnLogAction.DETAIL, location = "return-log-detail.jsp") })
public class ReturnLogAction extends CrudActionSupport<ReturnLog>
{
    private static final long   serialVersionUID = 1L;

    HttpServletRequest          request          = Struts2Utils.getRequest();

    private static final String DETAIL           = "detail";

    private ReturnLogManager    returnLogManager;                            // 归档信息

    private LendLogManager      lendLogManager;                              // 调阅管理

    private StudentWebService   studentWebService;                           // 学生信息

    ArchivesManager             archivesManager;                             // 档案管理

    // --页面属性-- //
    private ReturnLog           entity;                                      // 归档信息

    private LendLog             lendLog;                                     // 调阅信息

    private Page<ReturnLog>     page             = new Page<ReturnLog>(8);   // 分页列表查询归档信息

    private Long                id;                                          // 编号

    private String              stuNo;                                       // 学号

    private Archives            archives;                                    // 档案信息

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = returnLogManager.get(id);
        }
        else
        {

            entity = new ReturnLog();
        }

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public ReturnLog getModel()
    {
        return entity;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    // --CURD Action 函数-- //
    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        this.archives = archivesManager.getArchives(stuNo);
        lendLog = lendLogManager.getRecentLendLog(stuNo); // 获取最近一次调阅记录

        return INPUT;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("id");
        }
        page = returnLogManager.search(page);
        return SUCCESS;
    }

    public String detail()
    {
        this.entity = returnLogManager.getRecentReturnLog(stuNo);
        this.lendLog = lendLogManager.getRecentLendLog(stuNo);
        return DETAIL;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        Archives archives = archivesManager.getArchives(stuNo);
        if (archives.getStatus().equals("在库"))
        {
            addActionMessage("操作失败，该档案已在库");

            return RELOAD;
        }
        archives.setStatus("在库"); // 归档时将档案状态设为在库
        archivesManager.save(archives);

        this.lendLog = lendLogManager.getRecentLendLog(stuNo);
        lendLog.setReturnDate(entity.getReturnDate()); // 将归档时间添加到调阅的实际归还时间
        lendLogManager.save(lendLog);

        entity.setStuId(stuNo); // 设置归档的学生学号
        entity
                .setName(studentWebService.getStudentByStudentNo(stuNo) != null ? studentWebService
                        .getStudentByStudentNo(stuNo).getName()
                        : ""); // 设置学生姓名
        entity.setLendNum(this.getLendLog().getId()); // 设置归档序号(外键，对应调阅信息中的主键)
        returnLogManager.save(entity);
        addActionMessage("档案归档成功");
        return RELOAD;
    }

    // --其他 Action 函数-- //

    @Autowired
    public void setReturnLogManager(ReturnLogManager returnLogManager)
    {
        this.returnLogManager = returnLogManager;
    }

    @Autowired
    public void setLendLogManager(LendLogManager lendLogManager)
    {
        this.lendLogManager = lendLogManager;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

    public void setStuNo(String stuNo)
    {
        this.stuNo = stuNo;
    }

    // --页面属性访问函数-- //
    public ReturnLog getEntity()
    {
        return entity;
    }

    /**
     * 调阅信息
     */
    public LendLog getLendLog()
    {
        return lendLog;
    }

    /**
     * 学号
     */
    public String getStuNo()
    {
        return stuNo;
    }

    public Page<ReturnLog> getPage()
    {
        return page;
    }

    /**
     * 档案
     */
    public Archives getArchives()
    {
        return archives;
    }
}
