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
package cn.loosoft.stuwork.selfhelp.web.student;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.data.webservice.api.student.ArchivesWebService;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.ArchivesDTO;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 学生档案信息管理Action
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-15
 */
@Namespace("/student")
public class ArchivesinfoAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    ArchivesWebService        archivesWebService;

    @Autowired
    private StudentWebService studentWebService;

    // -- 页面属性 -- //
    private ArchivesDTO       archivesDTO;

    @Override
    public String execute()
    {
        StudentDTO currentUser = studentWebService
                .getStudentByStudentNo(SpringSecurityUtils.getCurrentUserName());

        this.archivesDTO = archivesWebService.getArchives(currentUser
                .getStudentNo());

        return SUCCESS;
    }

    // -- 页面访问函数 -- //
    public ArchivesDTO getArchivesDTO()
    {
        return archivesDTO;
    }

    @Autowired
    public void setArchivesWebService(ArchivesWebService archivesWebService)
    {
        this.archivesWebService = archivesWebService;
    }
}
