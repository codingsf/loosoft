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
package cn.loosoft.stuwork.arch.web.outlog;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

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

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.Constant;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.outlog.OutLog;
import cn.loosoft.stuwork.arch.entity.sys.Dictionary;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.outlog.OutlogManager;
import cn.loosoft.stuwork.arch.service.sys.DictionaryManager;
import cn.loosoft.stuwork.arch.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelModel;
import cn.loosoft.stuwork.arch.vo.ArchivesVO;
import cn.loosoft.stuwork.common.OutlogType;

import com.google.common.collect.Lists;

/**
 * 
 * 调出记录管理Action.
 * 
 * @author jie.yange
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/outlog")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "outlog.action", type = "redirect"),
        @Result(name = "outRecord", location = "outRecord.jsp"),
        @Result(name = "outRecordAction", location = "outRecord.action", type = "redirect"),
        @Result(name = "outRecordInput", location = "outRecordInput.jsp"),
        @Result(name = "outlogdetail", location = "outlog-detail.jsp") })
public class OutlogAction extends CrudActionSupport<OutLog>
{

    /**
     * serialVersionUID long
     */
    private static final long         serialVersionUID = 1L;

    private ArchivesManager           archivesManager;                             // 类型管理

    private OutlogManager             outlogManager;                               // 调出记录管理

    private OutLog                    outLog;                                      // 调出记录实体

    private Page<Archives>            page             = new Page<Archives>(
                                                               Constant.PAGE_SIZE); // 分页查询

    private String                    stuId;                                       // 学生ID

    private File                      picfile;                                     // 文件

    private String                    picfileFileName;                             // 文件名称

    private Archives                  stuArchives;                                 // 学生库位实体

    private final HttpServletRequest  request          = Struts2Utils
                                                               .getRequest();

    private final HttpServletResponse response         = Struts2Utils
                                                               .getResponse();

    private String                    stuNo;                                       // 学号

    private String                    name;                                        // 姓名

    @Autowired
    private DictionaryManager         dictionaryManager;

    private List<Dictionary>          reasonList;

    private String                    actionMessage;

    private Archives                  outArchives;                                 // 回执录入

    private Long                      id;

    /**
     * @return the outArchives
     */
    public Archives getOutArchives()
    {
        return outArchives;
    }

    /**
     * @return the id
     */
    public Long getId()
    {
        return id;
    }

    /**
     * @param id
     *            the id to set
     */
    public void setId(Long id)
    {
        this.id = id;
    }

    /**
     * @return the actionMessage
     */
    public String getActionMessage()
    {
        return actionMessage;
    }

    /**
     * @return the selectPageList
     */
    public List<LabelValue> getOutlogTypeList()
    {
        return OutlogType.enumList;
    }

    public List<Dictionary> getReasonList()
    {
        reasonList = dictionaryManager.list(Dictionary.DDLY);
        return reasonList;
    }

    private List<ArchivesVO>  archivesVOs;                    // 学生档案列表

    @Autowired
    private StudentWebService studentWebService;

    private List<ArchivesVO>  tempList = Lists.newArrayList();

    public List<Dictionary> getOutTypeList()
    {
        return dictionaryManager.list(Dictionary.DDFS);
    }

    /**
     * @param tempList
     *            the tempList to set
     */
    public void setTempList(List<ArchivesVO> tempList)
    {
        this.tempList = tempList;
    }

    public List<ArchivesVO> getTempList()
    {
        return tempList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-18
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {

        if (stuId != null)
        {
            outLog = outlogManager.getOutLog(stuId);

        }
        else
        {
            outLog = new OutLog();
        }
        // TODO Auto-generated method stub
        return INPUT;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-18
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("id");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        filters.add(new PropertyFilter("EQS_status", "在库"));

        page = archivesManager.search(page, filters);
        return SUCCESS;

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-18
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {

        outLog = new OutLog();

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-18
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        stuArchives = archivesManager.getArchives(stuId);
        stuArchives.setStatus("调出");
        stuArchives.setOperater(SpringSecurityUtils.getCurrentUserName());
        archivesManager.save(stuArchives);
        StudentDTO studentDTO = studentWebService.getStudentByStudentNo(stuId);
        outLog.setName(studentDTO.getName());
        if (picfile != null)
        {
            outlogManager.saveAttachment(picfile, picfileFileName, outLog);// 已经上传成功了
        }
        outlogManager.save(outLog);
        // TODO Auto-generated method stub
        actionMessage = "调出档案成功";
        return "outlogdetail";
    }

    /**
     * 
     * 调出的档案信息(回执)
     * 
     * @since 2011-1-10
     * @author jie.yang
     * @return
     * @throws Exception
     */
    public String outRecord()
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("id");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        filters.add(new PropertyFilter("EQS_status", "调出"));
        page = archivesManager.search(page, filters);
        return "outRecord";
    }

    /**
     * 
     * 回执页面
     * 
     * @since 2011-1-10
     * @author jie.yang
     * @return
     * @throws Exception
     */
    public String outRecordInput()
    {
        outArchives = archivesManager.get(id);
        return "outRecordInput";
    }

    /**
     * 
     * 回执
     * 
     * @since 2011-1-10
     * @author jie.yang
     * @return
     * @throws Exception
     */
    public String updateRecord()
    {
        outArchives = archivesManager.get(id);
        outArchives.setOutRecord(request.getParameter("outRecord"));
        archivesManager.save(outArchives);
        actionMessage = "回执录入成功";
        return "outRecordInput";
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

        page = archivesManager.search(page, filters);
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;入库时间;档案状态;库位号;";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();
        List<Archives> list = page.getResult();

        for (int i = 0; i < list.size(); i++)
        {

            ArrayList rowData = new ArrayList();
            Archives archiveVo = list.get(i);
            rowData.add(archiveVo.getStuId());
            rowData.add(archiveVo.getName());
            rowData.add(archiveVo.getStorageTime());
            rowData.add(archiveVo.getStatus());
            rowData.add(archiveVo.getStoreInfo());
            data.add(rowData);

        }
        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("调出记录");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载

        // 调用自编的下载类，实现Excel文件的下载
        ExcelDownLoad downLoad = new BaseExcelDownLoad();

        // 不生成文件，直接生成文件输出流供下载
        downLoad.downLoad("调出记录.xls", excel, response);

        downLoad.downLoad("调出记录.xls", excel, response);
        PageContext pageContext = (PageContext) request.getSession()
                .getAttribute("pageContext");
        JspWriter out = pageContext.getOut();
        out.clear();
        out = pageContext.pushBody();
        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-18
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public OutLog getModel()
    {
        // TODO Auto-generated method stub
        return outLog;
    }

    public Page<Archives> getPage()
    {
        return page;
    }

    public void setPicfile(File picfile)
    {
        this.picfile = picfile;
    }

    public void setPicfileFileName(String picfileFileName)
    {
        this.picfileFileName = picfileFileName;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    @Autowired
    public void setOutlogManager(OutlogManager outlogManager)
    {
        this.outlogManager = outlogManager;
    }

    public void setStuId(String stuId)
    {
        this.stuId = stuId;
    }

    public String getStuId()
    {
        return stuId;
    }

    /**
     * @return the stuNo
     */
    public String getStuNo()
    {
        return stuNo;
    }

    /**
     * @param stuNo
     *            the stuNo to set
     */
    public void setStuNo(String stuNo)
    {
        this.stuNo = stuNo;
    }

    /**
     * @return the name
     */
    public String getName()
    {
        return name;
    }

    /**
     * @param name
     *            the name to set
     */
    public void setName(String name)
    {
        this.name = name;
    }

    /**
     * @return the archivesVOs
     */
    public List<ArchivesVO> getArchivesVOs()
    {
        return archivesVOs;
    }
}
