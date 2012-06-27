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
package cn.loosoft.stuwork.arch.web.lendlog;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.Constant;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.lendlog.LendLogManager;
import cn.loosoft.stuwork.arch.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelModel;

/**
 * 
 * 档案调阅记录Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-18
 */
@Namespace("/lendlog")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "lend-log.action", type = "redirect"),
        @Result(name = "detail", location = "lend-log-detail.jsp") })
public class LendLogAction extends CrudActionSupport<LendLog>
{

    private static final long         serialVersionUID = 1L;

    private static final String       DETAIL           = "detail";

    private final HttpServletResponse response         = Struts2Utils
                                                               .getResponse();

    HttpServletRequest                request          = Struts2Utils
                                                               .getRequest();

    private LendLogManager            lendLogManager;                              // 调阅管理

    ArchivesManager                   archivesManager;                             // 档案管理

    StudentWebService                 studentWebService;                           // 学生信息

    // --页面属性访问函数-- //
    private LendLog                   entity;                                      // 调阅实体

    private Page<LendLog>             page             = new Page<LendLog>(
                                                               Constant.PAGE_SIZE); // 分页查询

    private Long                      id;                                          // 编号

    private List<Long>                ids;                                         // ID列表

    private String                    stuNo;                                       // 学号

    private String                    actionMessage;

    private StudentDTO                studentDTO;

    private Archives                  archives;

    private File                      file;                                        // 文件

    private String                    fileFileName;                                // 文件名称

    private List<LabelValue>          selectPageList;

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
            entity = lendLogManager.get(id);
        }
        else
        {

            entity = new LendLog();
        }

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public LendLog getModel()
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
        return INPUT;
    }

    /**
     * 
     * 档案调阅详情
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @return
     */
    public String detail()
    {
        this.studentDTO = studentWebService.getStudentByStudentNo(stuNo);
        this.archives = archivesManager.getArchives(stuNo);
        entity = lendLogManager.get(id);
        return DETAIL;
    }

    @Override
    public String delete() throws Exception
    {
        lendLogManager.delete(id);
        Struts2Utils.renderText("删除调阅记录成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    public String deletes() throws Exception
    {
        if (null != this.ids && this.ids.size() > 0)
        {
            lendLogManager.deletes(ids);
            addActionMessage("批量删除调阅信息成功");
        }
        else
        {
            addActionMessage("没有可删除记录，请勾选");
        }

        return RELOAD;
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
        HttpServletRequest request = Struts2Utils.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("lendDate");
        }

        page = lendLogManager.search(page, filters);
        return SUCCESS;
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
        if (archives.getStatus().equals("调阅")) // 服务器段判断档案是否被调阅
        {
            addActionMessage("操作失败，档案已被调阅");
            return RELOAD;
        }
        entity.setStuId(stuNo);
        entity
                .setName(studentWebService.getStudentByStudentNo(stuNo) != null ? studentWebService
                        .getStudentByStudentNo(stuNo).getName()
                        : "");
        lendLogManager.saveLendLog(file, fileFileName, entity);
        archives.setStatus("调阅"); // 更改档案状
        archivesManager.save(archives);
        addActionMessage("档案调阅成功");
        return RELOAD;
    }

    /**
     * 
     * 导出excel
     * 
     * @since 2011-1-10
     * @author Administrator
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("lendDate");
        }

        page = lendLogManager.search(page, filters);
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;调阅组织;调阅时间;计划归还时间;实际归还时间;调档函扫描件;经办人";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        for (LendLog lendLog : page.getResult())
        {
            LendLog item = lendLog;
            ArrayList rowData = new ArrayList();
            rowData.add(item.getStuId());
            rowData.add(item.getName());
            rowData.add(item.getOrganization());
            rowData.add(String.valueOf(item.getLendDate()));
            rowData.add(String.valueOf(item.getPlanDate()));
            rowData.add(String.valueOf(item.getReturnDate() == null ? "没有归档"
                    : item.getReturnDate()));
            rowData.add(String.valueOf(item.getFileName() == null ? "没有提供"
                    : item.getFileName()));
            rowData.add(item.getOperater());
            data.add(rowData);
        }

        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("调阅记录");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("调阅记录.xls", excel, response);

        }
        catch (Exception e)
        {

            e.printStackTrace();

        }
        return null;
    }

    // --其他 Action 函数-- //
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

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public void setFile(File file)
    {
        this.file = file;
    }

    public void setFileFileName(String fileFileName)
    {
        this.fileFileName = fileFileName;
    }

    // --页面属性访问函数-- //
    public LendLog getEntity()
    {
        return entity;
    }

    public Page<LendLog> getPage()
    {
        return page;
    }

    public String getActionMessage()
    {
        return actionMessage;
    }

    public String getStuNo()
    {
        return stuNo;
    }

    public StudentDTO getStudentDTO()
    {
        return studentDTO;
    }

    public Archives getArchives()
    {
        return archives;
    }

    /**
     * @return the selectPageList
     */
    public List<LabelValue> getSelectPageList()
    {
        selectPageList = new ArrayList<LabelValue>();
        selectPageList.add(new LabelValue("10", "10"));
        selectPageList.add(new LabelValue("15", "15"));
        selectPageList.add(new LabelValue("20", "20"));
        return selectPageList;
    }

}
