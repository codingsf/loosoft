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
package cn.loosoft.stuwork.arch.web.changelog;

import java.util.ArrayList;
import java.util.Date;
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
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.Constant;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.changelog.ChangeLog;
import cn.loosoft.stuwork.arch.entity.store.Store;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.changelog.ChangelogManager;
import cn.loosoft.stuwork.arch.service.store.StoreManager;
import cn.loosoft.stuwork.arch.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelModel;

/**
 * 
 * 变更管理Action.
 * 
 * @author jie.yange
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/changelog")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "change.action", type =

        "redirect"), @Result(name = "update", location = "change-update.jsp") })
public class ChangeAction extends CrudActionSupport<Archives>
{

    private static final long         serialVersionUID = 1L;

    private final HttpServletRequest  request          = Struts2Utils
                                                               .getRequest();

    private final HttpServletResponse response         = Struts2Utils
                                                               .getResponse();

    private ArchivesManager           archivesManager;                             // 类型管理

    private ChangelogManager          changelogManager;                            // 变更管理

    private StoreManager              storeManager;                                // 档案库位

    private Archives                  stuArchives;                                 // 类型实体

    private ChangeLog                 changeLog;                                   // 变更实体

    private String                    stuId;                                       // 学号

    private String                    dictionaryName;                              // 应缴材料名称

    private Page<Archives>            page             = new Page<Archives>(
                                                               Constant.PAGE_SIZE); // 分页查询

    public List<Store>                areaList;                                    // 所有区域

    @Autowired
    private StudentWebService         studentWebService;

    private String                    actionMessage;                               // 提示信息

    private String                    stuNo;                                       // 学号

    private String                    name;                                        // 姓名

    public String getStuNo()
    {
        return stuNo;
    }

    public void setStuNo(String stuNo)
    {
        this.stuNo = stuNo;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getActionMessage()
    {
        return actionMessage;
    }

    /**
     * @return the page
     */
    public Page<Archives> getPage()
    {
        return page;
    }

    public List<Store> getAreaList()
    {
        return storeManager.getAll();
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

        // TODO Auto-generated method stub
        return INPUT;
    }

    public String updateArchive()
    {
        String content = request.getParameter("content");
        String operater = request.getParameter("operater");
        String remark = request.getParameter("remark");
        StudentDTO studentDTO = studentWebService.getStudentByStudentNo(stuId);
        if (request.getParameter("areaText") != ""
                && request.getParameter("rankText") != ""
                && request.getParameter("rowText") != ""
                && request.getParameter("columnText") != "")
        {
            String areaText = request.getParameter("areaText");
            String rankText = request.getParameter("rankText");
            String rowText = request.getParameter("rowText");
            String columnText = request.getParameter("columnText");

            stuArchives = archivesManager.getArchives(stuId);
            String kuwei = stuArchives.getStoreInfo();
            String storeInfo = areaText + "区" + rankText + "排" + rowText + "行"
                    + columnText + "列";
            stuArchives.setStoreInfo(storeInfo);

            changeLog = new ChangeLog();

            if (content != "" && content != null)
            {
                stuArchives.setArchivesInfo(stuArchives.getArchivesInfo() + ","
                        + content);
                changeLog.setContent("添加了" + content);
            }
            if (!storeInfo.equals(stuArchives.getArchivesInfo()))
            {
                if (changeLog.getContent() != null
                        && changeLog.getContent() != "")
                {
                    changeLog.setContent(changeLog.getContent() + "," + kuwei
                            + "变更为" + storeInfo);

                }
                else
                {
                    changeLog.setContent(kuwei + "变更为" + storeInfo);
                }
            }
            if (operater != "" && operater != null)
            {
                stuArchives.setOperater(operater);
                changeLog.setOperater(operater);
            }
            archivesManager.save(stuArchives);
            changeLog.setChangeDate(new Date());

            if (remark != "" && remark != null)
            {
                changeLog.setRemark(remark);
            }
            else
            {
                changeLog.setRemark("无");
            }
            changeLog.setStuId(stuId);
            changeLog.setName(studentDTO.getName());
            changelogManager.save(changeLog);
        }
        else
        {

            changeLog = new ChangeLog();

            changeLog.setStuId(stuId);
            changeLog.setName(studentDTO.getName());
            changeLog.setOperater(operater);
            changeLog.setRemark(remark);
            changeLog.setContent(content);
            changeLog.setChangeDate(new Date());
            changelogManager.save(changeLog);

        }
        return RELOAD;
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

    public String update()
    {
        dictionaryName = archivesManager.getArchivesStr();
        return "update";
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
        if (stuId != null && stuId != "")
        {
            changeLog = changelogManager.getChangeLog(stuId);
        }
        else
        {
            changeLog = new ChangeLog();
        }

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
        archivesManager.save(stuArchives);
        return RELOAD;
    }

    /**
     * 
     * 导出excel
     * 
     * @since 2011-1-8
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
            Archives archive = list.get(i);
            rowData.add(archive.getStuId());
            rowData.add(archive.getName());
            rowData.add(archive.getStorageTime());
            rowData.add(archive.getStatus());
            rowData.add(archive.getStoreInfo());
            data.add(rowData);

        }
        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("变更记录");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载

        // 调用自编的下载类，实现Excel文件的下载
        ExcelDownLoad downLoad = new BaseExcelDownLoad();

        // 不生成文件，直接生成文件输出流供下载
        downLoad.downLoad("变更记录.xls", excel, response);

        downLoad.downLoad("调出记录.xls", excel, response);
        PageContext pageContext = (PageContext) request.getSession()
                .getAttribute("pageContext");
        JspWriter out = pageContext.getOut();
        out.clear();
        out = pageContext.pushBody();
        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-18
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public Archives getModel()
    {
        // TODO Auto-generated method stub
        return stuArchives;
    }

    public ChangeLog getChangeLog()
    {
        return changeLog;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    public void setStuId(String stuId)
    {
        this.stuId = stuId;
    }

    public String getStuId()
    {
        return stuId;
    }

    @Autowired
    public void setChangelogManager(ChangelogManager changelogManager)
    {
        this.changelogManager = changelogManager;
    }

    @Autowired
    public void setStoreManager(StoreManager storeManager)
    {
        this.storeManager = storeManager;
    }

    public String getDictionaryName()
    {
        return dictionaryName;
    }

}
