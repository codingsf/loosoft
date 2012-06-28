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
package cn.loosoft.stuwork.workstudy.web.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.file.FileUpDown;
import cn.loosoft.stuwork.workstudy.service.file.FileManager;

/**
 * 
 * 文件上传Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-6
 */
@Namespace("/file")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "upload.action", type = "redirect"),
        @Result(name = "uploadPage", location = "uploadPage.jsp"),
        @Result(name = "down", location = "down.jsp") })
public class UploadAction extends CrudActionSupport<FileUpDown>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private FileUpDown        entity;

    private FileManager       fileManager;

    // 页面属性
    private Long              id;

    private Page<FileUpDown>  page             = new Page<FileUpDown>(
                                                       Constant.PAGE_SIZE);

    private File              file;

    private String            fileFileName;

    private String            fileContentType;

    /**
     * 
     * 跳转到上传页面
     * 
     * @since 2011-3-6
     * @author yong.geng
     * @return
     * @throws Exception
     */
    public String upload() throws Exception
    {
        return "uploadPage";
    }

    /**
     * 
     * 跳转到下载页面
     * 
     * @since 2011-3-6
     * @author yong.geng
     * @return
     * @throws Exception
     */
    public String down() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("uploadDate");
            page.setOrder(Page.DESC);
        }
        page = fileManager.search(page);
        return "down";
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("uploadDate");
            page.setOrder(Page.DESC);
        }
        page = fileManager.search(page);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = fileManager.get(id);
        }
        else
        {
            entity = new FileUpDown();
        }
    }

    /**
     * 
     * 上传文件
     * 
     * @since 2011-3-6
     * @author yong.geng
     * @return
     * @throws Exception
     */
    @Override
    public String save() throws Exception
    {
        // String root =
        // ServletActionContext.getRequest().getRealPath("/upload");

        String root = PropertyUtils.getProperty("news.attachment.file.path",
                RequestUtils.getRealPath(ServletActionContext
                        .getServletContext(), "upload"));
        this.entity.setFileRealName(this.getFileFileName());
        this.entity.setAddress(root);
        this.entity.setUploadDate(new Date());
        this.entity.setUploadUser(SpringSecurityUtils.getCurrentUserName());
        fileManager.save(this.entity);
        InputStream is = new FileInputStream(file);

        // 在项目下面如果没有upload文件夹，就创建一个。
        File folder = new File(root);
        if (!folder.exists())
        {
            folder.mkdir();
        }
        File destFile = new File(folder, this.getFileFileName());
        OutputStream os = new FileOutputStream(destFile);
        byte[] buffer = new byte[400];
        int length = 0;
        while ((length = is.read(buffer)) > 0)
        {
            os.write(buffer, 0, length);
        }
        is.close();
        os.close();
        addActionMessage("文件上传成功!");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        FileUpDown fileUpDown = fileManager.get(id);
        String path = fileUpDown.getAddress() + "/"
                + fileUpDown.getFileRealName();
        File deleteFile = new File(path);
        if (deleteFile.exists())
        {
            deleteFile.delete();

        }
        fileManager.delete(id);
        return RELOAD;
    }

    public FileUpDown getModel()
    {
        return entity;
    }

    public FileUpDown getEntity()
    {
        return entity;
    }

    public void setEntity(FileUpDown entity)
    {
        this.entity = entity;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Page<FileUpDown> getPage()
    {
        return page;
    }

    public void setPage(Page<FileUpDown> page)
    {
        this.page = page;
    }

    @Autowired
    public void setFileManager(FileManager fileManager)
    {
        this.fileManager = fileManager;
    }

    public File getFile()
    {
        return file;
    }

    public void setFile(File file)
    {
        this.file = file;
    }

    public String getFileFileName()
    {
        return fileFileName;
    }

    public void setFileFileName(String fileFileName)
    {
        this.fileFileName = fileFileName;
    }

    public String getFileContentType()
    {
        return fileContentType;
    }

    public void setFileContentType(String fileContentType)
    {
        this.fileContentType = fileContentType;
    }

}
