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
package cn.loosoft.stuwork.welnew.web.noticeBook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.moveutil.MoveUtil;
import cn.loosoft.stuwork.welnew.service.moveutil.MoveUtilManager;

/**
 * 
 * 通知书管理Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2010-01-14
 */
@Namespace("/noticeBook")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "notice-book.action", type = "redirect"),
        @Result(name = "uploadPage", location = "upload-notice-image.jsp"),
        @Result(name = "setting", location = "setting-notice-image.jsp"),
        @Result(name = "view", location = "view-notice-image.jsp") })
public class NoticeBookAction extends CrudActionSupport<MoveUtil>
{
    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    @Autowired
    private MoveUtilManager   moveUtilManager;                             // 通知书设置管理

    // 页面属性
    private Long              id;

    private MoveUtil          entity;

    private Page<MoveUtil>    page             = new Page<MoveUtil>(
                                                       Constant.PAGE_SIZE);

    private File              file;

    private String            fileFileName;

    private String            fileContentType;

    private MoveUtil          mn;

    /**
     * @param id
     *            the id to set
     */
    public void setId(Long id)
    {
        this.id = id;
    }

    /**
     * @return the moveUtil
     */
    public MoveUtil getMoveUtil()
    {
        return entity;
    }

    /**
     * 
     * 查看设置后的通知书
     * 
     * @since 2011-3-31
     * @author yong.geng
     * @return
     */
    public String view()
    {
        mn = moveUtilManager.get(id);
        return "view";
    }

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
     * 跳转到设置图片页面
     * 
     * @since 2011-3-30
     * @author yong.geng
     * @return
     * @throws Exception
     */
    public String setting() throws Exception
    {
        fileFileName = moveUtilManager.get(id).getImageName();
        return "setting";
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-14
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub

        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-14
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("year");
            page.setOrder(Page.DESC);
        }
        page = moveUtilManager.search(page);
        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-14
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub
        if (id != null)
        {
            entity = moveUtilManager.get(id);
        }
        else
        {
            entity = new MoveUtil();
        }
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-14
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        moveUtilManager.save(entity);
        mn = moveUtilManager.get(id);
        return "view";
    }

    /**
     * 
     * 保存上传图片
     * 
     * @since 2011-3-30
     * @author Administrator
     * @return
     * @throws Exception
     */
    public String uploadImage() throws Exception
    {
        String root = ServletActionContext.getRequest().getRealPath(
                "/images/notice");
        moveUtilManager.setStatus();
        HttpServletRequest request = ServletActionContext.getRequest();
        MoveUtil moveUtil = new MoveUtil();
        moveUtil.setYear(request.getParameter("year"));
        moveUtil.setIntroduce(request.getParameter("introduce"));
        moveUtil.setAddress(root + "\\" + getFileFileName());
        moveUtil.setImageName(getFileFileName());
        moveUtil.setStatus("使用");
        moveUtilManager.save(moveUtil);
        InputStream is = new FileInputStream(file);

        File folder = new File(root);

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
        MoveUtil moveUtil = moveUtilManager.get(id);
        String path = moveUtil.getAddress();
        File deleteFile = new File(path);
        if (deleteFile.exists())
        {
            deleteFile.delete();

        }
        moveUtilManager.delete(id);
        return RELOAD;
    }

    public String using() throws Exception
    {
        moveUtilManager.setStatus();
        this.entity = moveUtilManager.get(id);
        this.entity.setStatus("使用");
        moveUtilManager.save(entity);

        return RELOAD;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-14
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public MoveUtil getModel()
    {
        return entity;
    }

    public Page<MoveUtil> getPage()
    {
        return page;
    }

    public void setPage(Page<MoveUtil> page)
    {
        this.page = page;
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

    public Long getId()
    {
        return id;
    }

    public MoveUtil getEntity()
    {
        return entity;
    }

    public void setEntity(MoveUtil entity)
    {
        this.entity = entity;
    }

    public MoveUtil getMn()
    {
        return mn;
    }

    public void setMn(MoveUtil mn)
    {
        this.mn = mn;
    }

}
