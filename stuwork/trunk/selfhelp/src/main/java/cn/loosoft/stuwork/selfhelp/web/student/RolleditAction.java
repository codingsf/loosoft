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

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.PoliticsFace;

/**
 * 
 * 学生学籍信息修改Action
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-15
 */
@Namespace("/student")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "rollinfo.action", type = "redirect") })
public class RolleditAction extends CrudActionSupport<StudentDTO>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private StudentWebService studentWebService;

    // -- 页面属性 -- //
    private StudentDTO        studentDTO;

    // private File picfile;
    //
    // // 上传文件名
    //
    //  
    //
    // private String picfileFileName;

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
        this.studentDTO = studentWebService.getStudentByExamineeNo(currentUser
                .getExamineeNo());
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        StudentDTO currentUser = studentWebService.getStudentByStudentNo(SpringSecurityUtils
                .getCurrentUserName());
        studentDTO = studentWebService.getStudentByExamineeNo(currentUser
                .getExamineeNo());

    }

    @Override
    public String save() throws Exception
    {
        studentWebService.saveStudent(studentDTO);
        return RELOAD;
        // return null;
    }

    public StudentDTO getModel()
    {
        // TODO Auto-generated method stub
        return studentDTO;
    }

    // -- 页面属性访问函数 --//
    public List<LabelValue> getZzmm()
    {
        return PoliticsFace.enumList;
    }

    public List<LabelValue> getMz()
    {
        return Nation.enumList;
    }

    public List<LabelValue> getHyzk()
    {
        return Marriage.enumList;
    }

    public StudentDTO getStudentDTO()
    {
        return studentDTO;
    }

    // public void setPicfile(File picfile)
    // {
    // this.picfile = picfile;
    // }
    //
    // public void setPicfileFileName(String picfileFileName)
    // {
    // this.picfileFileName = picfileFileName;
    // }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }
}
