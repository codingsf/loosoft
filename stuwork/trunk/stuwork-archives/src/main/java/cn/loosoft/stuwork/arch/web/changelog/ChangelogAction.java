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

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.changelog.ChangelogManager;
import cn.loosoft.stuwork.arch.vo.ArchivesVO;

/**
 * 
 * 变更记录管理Action.
 * 
 * @author jie.yange
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/changelog")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "changelog.action", type = "redirect") })
public class ChangelogAction extends CrudActionSupport<ChangeLog>
{

    private static final long serialVersionUID = 1L;

    private ChangelogManager  changelogManager;                            // 变更记录管理

    private ChangeLog         changeLog;                                   // 变更记录实体

    private Long              id;                                          // 编号

    private Page<ChangeLog>   page             = new Page<ChangeLog>(
                                                       Constant.PAGE_SIZE); // 分页查询

    private ArchivesManager   archivesManager;                             // 档案管理

    @Autowired
    private StudentWebService studentWebService;                           // 学生webservices

    private StudentDTO        studentDTO;                                  // 学生实体

    private ArchivesVO        archivesVO;                                  // 档案学校关联实体

    private String            stuId;                                       // 学生编号

    private List<Long>        ids;                                         // ID列表

    /**
     * @param ids
     *            the ids to set
     */
    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    @Autowired
    public void setChangelogManager(ChangelogManager changelogManager)
    {
        this.changelogManager = changelogManager;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        studentDTO = studentWebService.getStudentByStudentNo(stuId);
        archivesVO = convertToArchives(studentDTO);
        return INPUT;
    }

    /**
     * 
     * 将学生、档案信息po转化成vo输出到页面
     * 
     * @since 2010-12-23
     * @author shanru.wu
     * @param studentDTOs
     * @return
     */
    public ArchivesVO convertToArchives(StudentDTO studentDTO)
    {

        ArchivesVO archivesVO = null;
        if (null != studentDTO)
        {
            Archives archives = archivesManager.getArchives(studentDTO
                    .getStudentNo());
            archivesVO = new ArchivesVO();
            archivesVO.setArchivesInfo(archives.getArchivesInfo()); // 档案材料
            archivesVO.setStoreInfo(archives.getStoreInfo()); // 档案库位
            archivesVO.setStatus(archives.getStatus());
            archivesVO.setSex(studentDTO.getSex());
        }

        return archivesVO;
    }

    public String deletes() throws Exception
    {
        changelogManager.deletes(ids);
        addActionMessage("批量删除调阅信息成功");
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
        // TODO Auto-generated method stub

        HttpServletRequest request = Struts2Utils.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("changeDate");
        }
        page = changelogManager.search(page, filters);
        return SUCCESS;
    }

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
            changeLog = changelogManager.get(id);
        }
        else
        {
            changeLog = new ChangeLog();
        }

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
        // TODO Auto-generated method stub
        changelogManager.save(changeLog);
        return RELOAD;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public ChangeLog getModel()
    {
        // TODO Auto-generated method stub
        return changeLog;
    }

    public Page<ChangeLog> getPage()
    {
        return page;
    }

    public StudentDTO getStudentDTO()
    {
        return studentDTO;
    }

    public ArchivesVO getArchivesVO()
    {
        return archivesVO;
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

    public void setStuId(String stuId)
    {
        this.stuId = stuId;
    }

}
