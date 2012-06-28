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
package cn.loosoft.stuwork.workstudysite.web.file;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudysite.Constant;
import cn.loosoft.stuwork.workstudysite.entity.file.FileUpDown;
import cn.loosoft.stuwork.workstudysite.service.file.FileManager;

/**
 * 
 * 文件下载Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-6
 */
@Namespace("/file")
@Action(results = { @Result(type = "stream", name = "success", params = {
        "inputName", "downloadFile", "contentDisposition",
        "attachment;filename=\"${downloadFileName}\"", "bufferSize", "4096" }) })
public class DownAction extends CrudActionSupport<FileUpDown>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private FileUpDown        entity;

    private FileManager       fileManager;

    private String            fileName;                                    // struts2取得下载文件的名称，必须这样写。

    // 页面属性
    private Long              id;

    private Page<FileUpDown>  page             = new Page<FileUpDown>(
                                                       Constant.PAGE_SIZE);

    /**
     * 
     * 和上面的参数inputName的值对应的方法，此方法用来返回流文件的。
     * 
     * @since 2011-3-7
     * @author Administrator
     * @return
     * @throws FileNotFoundException
     * @throws UnsupportedEncodingException
     */
    public InputStream getDownloadFile() throws FileNotFoundException,
            UnsupportedEncodingException
    {
        String realName = fileManager.get(id).getFileRealName();
        String root = fileManager.get(id).getAddress() + "/" + realName;
        return new FileInputStream(root);
    }

    /**
     * 
     * 此方法是struts2自己设置下载文件名称的方法，必须要的。否则下载文件名称不对。
     * 
     * @since 2011-3-7
     * @author Administrator
     * @return
     * @throws UnsupportedEncodingException
     */
    public String getDownloadFileName() throws UnsupportedEncodingException
    {
        return this.fileName = setRealName();

    }

    private String setRealName() throws UnsupportedEncodingException
    {
        String name = fileManager.get(id).getFileRealName();
        return new String(name.getBytes("gbk"), "iso-8859-1");
    }

    @Override
    public String input() throws Exception
    {
        return null;
    }

    @Override
    public String list() throws Exception
    {
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

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public String getFileName()
    {
        return fileName;
    }

    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }

}
