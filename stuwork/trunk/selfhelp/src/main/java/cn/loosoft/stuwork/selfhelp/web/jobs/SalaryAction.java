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
package cn.loosoft.stuwork.selfhelp.web.jobs;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.data.webservice.api.query.SalaryWebService;
import cn.loosoft.data.webservice.api.query.dto.SalaryDTO;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;

/**
 * 学生工资信息查询Action Description of the class
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-18
 */
@Namespace("/jobs")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "salary.action", type = "redirect"),
        @Result(name = "detail", location = "salary-detail.jsp") })
public class SalaryAction extends CrudActionSupport<SalaryDTO>
{

    /**
     * serialVersionUID long
     */
    private static final long                      serialVersionUID = 1L;

    private SalaryWebService                       salaryWebService;

    @Autowired
    private StudentWebService studentWebService;

    // --页面属性--//
    private Long                                   id;

    private SalaryDTO                              entity;

    private List<SalaryDTO>                        salaryDTOList;

    private final cn.loosoft.stuwork.selfhelp.Page commonPage       = new cn.loosoft.stuwork.selfhelp.Page();

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        StudentDTO currentUser = studentWebService.getStudentByStudentNo(SpringSecurityUtils
                .getCurrentUserName());

        commonPage.setTotalCount(salaryWebService.getAllSalaryCount(currentUser
                .getStudentNo()));
        salaryDTOList = salaryWebService.getSalaryByExamineeNo(currentUser
                .getStudentNo(), commonPage.getPageNo());
        return SUCCESS;
    }

    public String detail()
    {
        this.entity = salaryWebService.getSalaryById(id);
        return "detail";
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public SalaryDTO getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    public SalaryDTO getEntity()
    {
        return entity;
    }

    public void setEntity(SalaryDTO entity)
    {
        this.entity = entity;
    }

    public List<SalaryDTO> getSalaryDTOList()
    {
        return salaryDTOList;
    }

    public void setSalaryDTOList(List<SalaryDTO> salaryDTOList)
    {
        this.salaryDTOList = salaryDTOList;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Autowired
    public void setSalaryWebService(SalaryWebService salaryWebService)
    {
        this.salaryWebService = salaryWebService;
    }

    public cn.loosoft.stuwork.selfhelp.Page getCommonPage()
    {
        return commonPage;
    }
}
