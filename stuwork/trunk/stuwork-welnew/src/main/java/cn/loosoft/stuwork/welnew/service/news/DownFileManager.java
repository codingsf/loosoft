package cn.loosoft.stuwork.welnew.service.news;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.common.lib.util.file.FileUtils;
import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.news.DownFileDao;
import cn.loosoft.stuwork.welnew.entity.news.DownFile;

/**
 * 
 * 附件管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class DownFileManager extends EntityManager<DownFile, Long>
{

    private DownFileDao downFileDao;

    /**
     * 批量删除
     * 
     * @param ids
     */
    public void deleteAttachment(List<Long> ids)
    {
        downFileDao.deletes(ids);
    }

    /**
     * 
     * 保存资讯的附件
     * 
     * @since 2010-11-24
     * @author fangyong
     * @param picfile
     * @param picfileFileName
     * @param article
     */
    public void saveAttachment(File picfile, String picfileFileName,
            DownFile downfile)
    {
        String date = null;
        String localFilePath = null;
        String filename = null;
        try
        {
            // 获得当前年月
            date = DateFormatUtils.format(new Date(), "yyyyMM");

            // 设置文件路径，优先存储在本地，如本地存储失败，则存储至服务器路径上
            localFilePath = PropertyUtils.getProperty("upload.path",
                    RequestUtils.getRealPath(ServletActionContext
                            .getServletContext(), "/"))
                    + "/downfile" + "/" + date;

            // 　存储文件，获得存储后的文件名
            filename = FileUtils.saveFile(localFilePath, picfile,
                    picfileFileName, "atta");

            // 保存
            downfile.setPostTime(new Date());
            downfile.setFileName(localFilePath);
            downfile.setSaveName(date + "/" + filename);
            downfile.setName(picfileFileName);
            downFileDao.save(downfile);
        }
        catch (Exception e)
        {
        }
    }

    /**
     * 
     * 保存资讯的附件
     * 
     * @since 2010-11-24
     * @author fangyong
     * @param picfile
     * @param picfileFileName
     * @param article
     */
    public void deleteAttachment(Long[] ids)
    {
        for (Long id : ids)
        {
            String localFilePath = null;
            try
            {
                // 修改时先删除附件再新增附件
                if (id != null)
                {
                    DownFile downfile = downFileDao.get(id);

                    localFilePath = PropertyUtils.getProperty("upload.path",
                            RequestUtils.getRealPath(ServletActionContext
                                    .getServletContext(), "/"))
                            + "/downfile" + "/" + downfile.getSaveName();

                    // 判断附件是否已存在,如存在则删除
                    File file = new File(localFilePath);
                    org.apache.commons.io.FileUtils.deleteQuietly(file);

                    // 删除
                    downFileDao.delete(downfile);
                }
            }
            catch (Exception e)
            {
            }
        }
    }

    @Autowired
    public void setDownFileDao(DownFileDao downFileDao)
    {
        this.downFileDao = downFileDao;
    }

    @Override
    protected HibernateDao<DownFile, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return downFileDao;
    }

}
