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
package cn.loosoft.stuwork.arch.webservice.archives;

import javax.jws.WebService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.student.ArchivesWebService;
import cn.loosoft.data.webservice.api.student.dto.ArchivesDTO;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;
import cn.loosoft.stuwork.arch.entity.outlog.OutLog;
import cn.loosoft.stuwork.arch.entity.returnlog.ReturnLog;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.lendlog.LendLogManager;
import cn.loosoft.stuwork.arch.service.outlog.OutlogManager;
import cn.loosoft.stuwork.arch.service.returnlog.ReturnLogManager;

/**
 * 学生档案的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-17
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.student.ArchivesWebService")
public class ArchivesWebServiceImpl implements ArchivesWebService
{
    ArchivesManager  archivesManager;

    LendLogManager   lendLogManager;  // 调阅信息

    OutlogManager    outlogManager;

    ReturnLogManager returnLogManager;

    /**
     * 根据考生号查询档案信息
     * 
     * @since 2011-4-17
     * @author shanru.wu
     * @param examineeNo
     * @return
     */
    public ArchivesDTO getArchives(String stuId)
    {
        ArchivesDTO archivesDTO = new ArchivesDTO();
        if (stuId != null && StringUtils.isNotEmpty(stuId))
        {
            Archives archives = archivesManager.getArchives(stuId);
            LendLog lendLog = lendLogManager.getRecentLendLog(stuId);
            OutLog outLog = outlogManager.getOutLog(stuId);

            ReturnLog returnLog = returnLogManager.getRecentReturnLog(stuId);
            if (archives != null)
            {
                archivesDTO = new ArchivesDTO(archives.getStuId(), archives
                        .getName(), archives.getExamineeNo(), archives
                        .getArchivesInfo(), archives.getStorageTime(), archives
                        .getStoreInfo(), archives.getRecipient(), archives
                        .getTransfer(), archives.getReason(), archives
                        .getOperater(), archives.getStatus());
            }
            if (lendLog != null)
            {
                archivesDTO.setLendOrganization(lendLog.getOrganization());
                archivesDTO.setLendDate(lendLog.getLendDate());
                archivesDTO.setLendPlanDate(lendLog.getPlanDate());
                archivesDTO.setLendReturnDate(lendLog.getReturnDate());
                archivesDTO.setLendFileName(lendLog.getFileName());
                archivesDTO.setLendOperater(lendLog.getOperater());
                archivesDTO.setLendRemark(lendLog.getRemark());
            }
            if (outLog != null)
            {
                archivesDTO.setOutOrganization(outLog.getOrganization());
                archivesDTO.setOutDate(outLog.getOutDate());
                archivesDTO.setOutFileName(outLog.getFileName());
                archivesDTO.setOutLocation(outLog.getLocation());
                archivesDTO.setOutType(outLog.getType());
                archivesDTO.setOutIsbn(outLog.getIsbn());
                archivesDTO.setOutAddress(outLog.getAddress());
                archivesDTO.setOutOperater(outLog.getOperater());
                archivesDTO.setOutRemark(outLog.getRemark());
            }
            if (returnLog != null)
            {
                archivesDTO.setReturnDate(returnLog.getReturnDate());
            }
        }
        return archivesDTO;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    @Autowired
    public void setLendLogManager(LendLogManager lendLogManager)
    {
        this.lendLogManager = lendLogManager;
    }

    @Autowired
    public void setOutlogManager(OutlogManager outlogManager)
    {
        this.outlogManager = outlogManager;
    }

    @Autowired
    public void setReturnLogManager(ReturnLogManager returnLogManager)
    {
        this.returnLogManager = returnLogManager;
    }
}