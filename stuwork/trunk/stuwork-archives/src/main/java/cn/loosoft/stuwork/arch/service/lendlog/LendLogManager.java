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
package cn.loosoft.stuwork.arch.service.lendlog;

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
import cn.loosoft.stuwork.arch.dao.lendlog.LendLogDao;
import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;

/**
 * 档案调阅实体的管理类.
 * 
 * @author shanru.wu
 * @since 2010-12-18
 * @version 1.0
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class LendLogManager extends EntityManager<LendLog, Long>
{
    LendLogDao lendLogDao;

    /**
     * 
     * 查询最近一次学生档案的调阅情况.
     * 
     * @since 2010-12-24
     * @author shanru.wu
     * @param stuId
     */
    public LendLog getRecentLendLog(String stuId)
    {
        return lendLogDao.getRecentLendLog(stuId);
    }

    /**
     * 
     * 保存档案调阅的扫描件
     * 
     * @since 2010-12-26
     * @author shanru.wu
     * @param file
     * @param fileFileName
     * @param lendLog
     */
    public void saveLendLog(File file, String fileFileName, LendLog lendLog)
    {

        try
        {
            // 获得当前年月
            String date = DateFormatUtils.format(new Date(), "yyyyMM");

            // 设置文件路径，优先存储在本地，如本地存储失败，则存储至服务器路径上
            String localFilePath = PropertyUtils.getProperty(
                    "lendlog.file.path", RequestUtils.getRealPath(
                            ServletActionContext.getServletContext(),
                            "archivesFolder"));

            // 重新设置文件路径，以当前年月作为存储目录　
            localFilePath = localFilePath + "\\" + date;
            System.out.println(localFilePath);
            // 　存储文件，获得存储后的文件名
            String filename = FileUtils.saveFile(localFilePath, file,
                    fileFileName, "lendlog");// 前缀
            lendLog.setFileName(filename);
            // 　重新设置文件名
            filename = File.separator + date + File.separator + filename;
            lendLogDao.save(lendLog);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 
     * 批量删除调阅信息.
     * 
     * @since 2010-12-21
     * @author shanru.wu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        lendLogDao.deletes(ids);
    }

    @Autowired
    public void setLendLogDao(LendLogDao lendLogDao)
    {
        this.lendLogDao = lendLogDao;
    }

    @Override
    protected HibernateDao<LendLog, Long> getEntityDao()
    {
        return lendLogDao;
    }

}
