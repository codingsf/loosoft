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

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 学生Action
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-15
 */
@Namespace("/student")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "baseinfo.action", type = "redirect") })
public class ChangepwdAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private StudentWebService studentWebService;

    @Override
    public String execute() throws Exception
    {
    	return SUCCESS;
    	
    }
    // -- 页面属性 -- //
    /**
     * Ajax　判断密码是否输入正确 Description of this Method
     * 
     * @since 2011-10-14
     * @author fangyong
     * @return
     */
    public String checkLoginPwd()
    {
        HttpServletRequest        request          = Struts2Utils.getRequest();
        String oldPwd = request.getParameter("oldPwd");

        User user = (User) SpringSecurityUtils.getCurrentUser();

        StudentDTO studentDTO = studentWebService.getStudentByStudentNo(user
                .getUsername());

        if (oldPwd.equals(studentDTO.getPassword()))
        {
            Struts2Utils.renderText("true");
        }
        else
        {
            Struts2Utils.renderText("false");
        }
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    /**
     * 
     * 修改密码
     * 
     * @since 2011-10-14
     * @author fangyong
     * @return
     * @throws Exception
     */
    public String savePwd() throws Exception
    {
        HttpServletRequest        request          = Struts2Utils.getRequest();
        String pwd = ParamUtils.getParameter(request, "pwd", null);
        if (StringUtils.isNotBlank(pwd))
        {
            User user = (User) SpringSecurityUtils.getCurrentUser();

            StudentDTO studentDTO = studentWebService
                    .getStudentByStudentNo(user.getUsername());
            studentDTO.setPassword(pwd);

            studentWebService.saveStudent(studentDTO);
            addActionMessage("恭喜您,密码修改成功");
            request.setAttribute("userName", user.getUsername());
        }
        
        return SUCCESS;
    }
    
    // -- 页面属性访问函数 --//
    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

}
