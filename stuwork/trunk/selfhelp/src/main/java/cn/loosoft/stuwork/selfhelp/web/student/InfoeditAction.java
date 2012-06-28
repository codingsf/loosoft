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

import java.io.File;
import java.net.InetAddress;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.common.lib.util.file.FileUtils;
import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.PoliticsFace;

/**
 * 
 * 学生基础信息修改Action
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-15
 */
@Namespace("/student")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "baseinfo.action", type = "redirect") })
public class InfoeditAction extends CrudActionSupport<StudentDTO>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private StudentWebService studentWebService;

    // -- 页面属性 -- //
    private StudentDTO        studentDTO;

    private File              picfile;

    // 上传文件名

    private String            picfileFileName;

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        this.studentDTO = studentWebService.getStudentByStudentNo(SpringSecurityUtils
                .getCurrentUserName());
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        studentDTO =  studentWebService.getStudentByStudentNo(SpringSecurityUtils
                .getCurrentUserName());
    }

    @Override
    public String save() throws Exception
    {
        if (null != picfile)
        {
            // 获得当前年月
            String date = DateFormatUtils.format(new Date(), "yyyyMM");
            // 设置文件路径，优先存储在本地，如本地存储失败，则存储至服务器路径上
            String localFilePath = PropertyUtils
                    .getProperty("news.attachment.file.path", RequestUtils
                            .getRealPath(ServletActionContext
                                    .getServletContext(), "stuImg"));
            // 重新设置文件路径，以当前年月作为存储目录
            localFilePath = localFilePath + "\\" + date;
            localFilePath = localFilePath.replace("selfhelp", "stuinfo");

            // 存储文件，获得存储后的文件名
            String filename = FileUtils.saveFile(localFilePath, picfile,
                    picfileFileName, "att");// 前缀

            InetAddress inetAddress = InetAddress.getLocalHost();

            // 保存
            // student.setImg("../" + "stuImg" + "/" + date + "/" + filename);
            studentDTO.setImg("http://" + inetAddress.getHostAddress()
                    + ":8080/stuwork-stuinfo" + "/" + "stuImg" + "/" + date
                    + "/" + filename);
        }

        studentWebService.saveStudent(studentDTO);
        return RELOAD;
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

    public void setPicfile(File picfile)
    {
        this.picfile = picfile;
    }

    public void setPicfileFileName(String picfileFileName)
    {
        this.picfileFileName = picfileFileName;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }
}
