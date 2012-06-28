//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: qingang
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
package cn.loosoft.stuwork.stuinfo.web.attachment;

import java.io.File;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.common.lib.util.file.FileUtils;
import cn.common.lib.util.web.ParamUtils;
import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.common.lib.vo.LabelValue;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.stuwork.stuinfo.entity.student.Student;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;
import cn.loosoft.stuwork.stuinfo.service.student.StudentManager;
import cn.loosoft.stuwork.stuinfo.util.FileUploadUtil;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 操作图片或附件上传的Action
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-3-28
 */
@ParentPackage("json-default")
@Namespace("/attachment")
@Results( {
        @Result(name = "success", type = "json", params = { "contentType",
                "text/html" }),
        @Result(name = "error", type = "json", params = { "contentType",
                "text/html" }) })
public class UploadAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long   serialVersionUID   = 1L;
    @Autowired
    private BatchManager batchManager;//
    @Autowired
    private StudentManager studentManager;//
    private File                picfile;

    private String              picfileFileName;

    private String              fileFileContentType;

    private String              message            = null;

    private String              delPicFileName;                    // 删除附件时的名字

    private String              avatarname;                        // 上传成功之后的文件名

    private static final String FAILUPLOAD_MESSAGE = "对不起，文件上传失败.";

    private static final String FAILDELETE_MESSAGE = "对不起，文件删除失败.";

    // 上传学生照片
    @Override
    public String execute() throws Exception
    {
    	//学号
        String studentNo = ParamUtils.getParameter(Struts2Utils.getRequest(), "stuno");
        String inYear = DateUtils.getDateFromDateTime(new Date(), "yyyy");
        if(StringUtils.isEmpty(studentNo)){
        	//当前批次
        	inYear = batchManager.getCurrentBatch().getYear();
        }else{
        	Student s = studentManager.getByStudentNo(studentNo);
        	if(s != null)
        		inYear =DateUtils.getDateFromDateTime(s.getInDate(), "yyyy");
        }
        
        // 设置文件路径，优先存储在本地，如本地存储失败，则存储至服务器路径上
        String localFilePath = PropertyUtils.getProperty("upload.path",
                RequestUtils.getRealPath(ServletActionContext
                        .getServletContext(), "/"))
                + UploadPath.PICTUREPATH + UploadPath.STUDENTPIC + "/" + inYear;
        // + UploadPath.PICTUREPATH + UploadPath.STUDENTPIC + "/" + year;

        try
        { 	
        	//存储文件，获得存储后的文件名
            avatarname = FileUtils.saveFile(localFilePath, picfile,
            		studentNo+picfileFileName.substring(picfileFileName.indexOf(".")),"");
            avatarname = "/" + inYear + "/" + avatarname;// 附件后加上日期方便保存到数据库中
        }
        catch (Exception e)
        {
            e.printStackTrace();
            message = FAILUPLOAD_MESSAGE;
        }
        return SUCCESS;
    }

    // 删除学生照片
    public String deleteStudentPic()
    {
        try
        {
            String filePath = PropertyUtils.getProperty("upload.path",
                    RequestUtils.getRealPath(ServletActionContext
                            .getServletContext(), "/"))
                    + UploadPath.PICTUREPATH
                    + UploadPath.STUDENTPIC
                    + this.delPicFileName;// 取得附件前半部分名称

            // 判断附件是否已存在,如存在则删除
            if (!FileUploadUtil.deleteFile(filePath))
            {
                Struts2Utils.renderJson(new LabelValue(FAILDELETE_MESSAGE, ""));
            }
        }
        catch (Exception e)
        {
            Struts2Utils.renderJson(new LabelValue(FAILDELETE_MESSAGE, ""));
        }
        return null;
    }

    public void setAvatarname(String avatarname)
    {
        this.avatarname = avatarname;
    }

    public String getAvatarname()
    {
        return avatarname;
    }

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    public File getPicfile()
    {
        return picfile;
    }

    public void setPicfile(File picfile)
    {
        this.picfile = picfile;
    }

    public String getPicfileFileName()
    {
        return picfileFileName;
    }

    public void setPicfileFileName(String picfileFileName)
    {
        this.picfileFileName = picfileFileName;
    }

    public String getFileFileContentType()
    {
        return fileFileContentType;
    }

    public void setFileFileContentType(String fileFileContentType)
    {
        this.fileFileContentType = fileFileContentType;
    }

    public void setDelPicFileName(String delPicFileName)
    {
        this.delPicFileName = delPicFileName;
    }

}
