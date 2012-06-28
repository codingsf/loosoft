package cn.loosoft.stuwork.welnew.web.news;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.news.DownFile;
import cn.loosoft.stuwork.welnew.service.news.DownFileManager;

/**
 * 
 * 附件管理Action.
 * 
 * @author jie.yange
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/news")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "downfile.action", type = "redirect") })
public class DownfileAction extends CrudActionSupport<DownFile>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private DownFileManager   downFileManager;                         // 上次附件管理

    private Long              id;                                      // 编号

    private DownFile          downFile;                                // 附件实体

    private Page<DownFile>    page             = new Page<DownFile>(8); // 分页查询

    private File              picfile;                                 // 上传文件名

    private Long[]            ids;

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    // 查询
    @Override
    public String list() throws Exception
    {
        // 设置默认排序方式
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("postTime");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);

        // 获取发布时间的结束时间
        String endPostTime = ParamUtils.getParameter(request, "endPostTime",
                null);
        if (StringUtils.isNotBlank(endPostTime))
        {
            filters.add(new PropertyFilter("LED_postTime", endPostTime
                    + " 23:59:59"));
        }

        page = downFileManager.search(page, filters);

        return SUCCESS;
    }

    // 保存
    @Override
    public String save() throws Exception
    {
        if (picfile != null)
        {
            downFileManager.saveAttachment(picfile, picfileFileName, downFile);
        }
        return RELOAD;
    }

    // 删除
    @Override
    public String delete()
    {
        if (null == id && null != ids)
        {
            downFileManager.deleteAttachment(ids);
        }
        else
            if (null != id)
            {
                Long[] recIds = { id };
                downFileManager.deleteAttachment(recIds);
            }
        return RELOAD;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            downFile = downFileManager.get(id);
        }
        else
        {
            downFile = new DownFile();
        }

    }

    public DownFile getModel()
    {
        return downFile;
    }

    public void setIds(Long[] ids)
    {
        this.ids = ids;
    }

    public void setPicfile(File picfile)
    {
        this.picfile = picfile;
    }

    @Autowired
    public void setDownFileManager(DownFileManager downFileManager)
    {
        this.downFileManager = downFileManager;
    }

    public void setPicfileFileName(String picfileFileName)
    {
        this.picfileFileName = picfileFileName;
    }

    private String picfileFileName;

    public Page<DownFile> getPage()
    {
        return page;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

}
