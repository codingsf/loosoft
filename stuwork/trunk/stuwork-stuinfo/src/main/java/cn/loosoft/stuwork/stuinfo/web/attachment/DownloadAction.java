//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: fangyong
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

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.stuwork.stuinfo.util.FileUploadUtil;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 管理附件下载Action
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-5
 */
@Namespace("/attachment")
@Action(results = { @Result(type = "stream", name = "success", params = {
        "inputName", "downloadFile", "contentDisposition",
        "attachment;filename=${downloadFileName}", "bufferSize", "4096" }) })
        public class DownloadAction extends ActionSupport
        {
    private static final long serialVersionUID = 6329383258366253255L;

    private String            fileName;

    public String getFileName()
    {
        return fileName;
    }

    public void setFileName()

    {
        HttpServletRequest request = Struts2Utils.getRequest();
        // 得到请求下载的文件名
        String fname = request.getParameter("name");
        try
        {
            /*
             * 
             * 对fname参数进行UTF-8解码,注意:实际进行UTF-8解码时会使用本地编码，本机为GBK。
             * 
             * 这里使用request.setCharacterEncoding解码无效.
             * 
             * 只有解码了getDownloadFile()方法才能在下载目录下正确找到请求的文件
             */

            if ("GET".equals(request.getMethod()))
            {
                fname = new String(fname.getBytes("ISO-8859-1"), "UTF-8");
            }
        }
        catch (Exception e)

        {
            e.printStackTrace();
        }

        this.fileName = fname;
    }

    /** 提供转换编码后的供下载用的文件名 */

    public String getDownloadFileName()
    {

        String downFileName = fileName;
        try
        {
            return URLEncoder.encode(downFileName,"utf-8");
        }
        catch (UnsupportedEncodingException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "";
        }
    }

    /*
     * 
     * @getDownloadFile 此方法对应的是struts.xml文件中的： <param
     * 
     * name="inputName">downloadFile</param> 返回下载文件的流，可以参看struts2的源码
     */
    public InputStream getDownloadFile() throws Exception

    {
        this.setFileName();
        String path = ParamUtils.getParameter(ServletActionContext.getRequest(),"path","");
        if(!path.isEmpty())
        {
            path+="\\";
        }
        String filePath = PropertyUtils.getProperty(
                "student.attachment.file.path", RequestUtils.getRealPath(
                        ServletActionContext.getServletContext(), ""))
                        + "\\" + path + fileName;
        String profix = fileName.substring(fileName.lastIndexOf("."));
        HttpServletResponse response = Struts2Utils.getResponse();
        String[] downStrArray = FileUploadUtil.getContentType(fileName, profix);

        response.reset();

        response.setHeader("Content-Type", downStrArray[0]);

        response.setHeader("Content-Disposition", "attachment;filename="
                + java.net.URLEncoder.encode(fileName, "UTF-8"));
        return new FileInputStream(filePath);
    }

    @Override
    public String execute() throws Exception

    {
        return SUCCESS;
    }
        }
