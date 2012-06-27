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
package cn.loosoft.stuwork.arch.service.outlog;

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
import cn.loosoft.stuwork.arch.dao.outlog.OutlogDao;
import cn.loosoft.stuwork.arch.entity.outlog.OutLog;

/**
 * 
 * 调出管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class OutlogManager extends EntityManager<OutLog, Long>
{

    private OutlogDao outlogDao;

    /**
     * 
     * 根据学号查询
     * 
     * @since 2010-12-18
     * @author yangjie
     * @param stuId
     * @return
     */
    public OutLog getOutLog(String stuId)
    {
        if (outlogDao.findBy("stuId", stuId).size() > 1)
        {
            return outlogDao.findBy("stuId", stuId).get(0);
        }
        else
        {
            return outlogDao.findUniqueBy("stuId", stuId);
        }
    }

    /**
     * 
     * 批量删除调出信息.
     * 
     * @since 2010-12-21
     * @author jie.yang
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        outlogDao.deletes(ids);
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
            OutLog outLog)
    {

        try
        {
            // 获得当前年月
            String date = DateFormatUtils.format(new Date(), "yyyyMM");

            // 设置文件路径，优先存储在本地，如本地存储失败，则存储至服务器路径上
            String localFilePath = PropertyUtils.getProperty(
                    "outlog.outlog.file.path", RequestUtils.getRealPath(
                            ServletActionContext.getServletContext(),
                            "archivesFolder"));

            // 重新设置文件路径，以当前年月作为存储目录　
            localFilePath = localFilePath + "\\" + date;

            // 　存储文件，获得存储后的文件名
            String filename = FileUtils.saveFile(localFilePath, picfile,
                    picfileFileName, "archives");// 前缀
            outLog.setFileName(filename);
            // 　重新设置文件名
            filename = File.separator + date + File.separator + filename;
            // 保存
            outLog.setLocation(localFilePath);
            outLog.setOutDate(new Date());

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Autowired
    public void setOutlogDao(OutlogDao outlogDao)
    {
        this.outlogDao = outlogDao;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.service.EntityManager#getEntityDao()
     */
    @Override
    protected HibernateDao<OutLog, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return outlogDao;
    }

}
