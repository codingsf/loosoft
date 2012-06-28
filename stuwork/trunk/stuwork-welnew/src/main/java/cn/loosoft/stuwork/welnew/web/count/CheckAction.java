//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: zzHe
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
package cn.loosoft.stuwork.welnew.web.count;

import java.text.DecimalFormat;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.log.CheckLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.CheckCountVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 统计学费Action.
 * 
 * @author zzhe
 * @version 1.0
 * @since 2011-9-1
 */
@Namespace("/count")
public class CheckAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long  serialVersionUID = 1L;

    @Autowired
    private StudentManager     studentManager;

    @Autowired
    private WelbatchManager    welbatchManager;

    @Autowired
    private CheckLogManager    checkLogManager;

    private long               allCount;                               // 应审查人数

    private long               passCount;                              // 通过人数

    private long               unpassCount;                            // 未通过人数

    private long               noCheckCount;                           // 漏审人数

    private String             passRate;                               // 通过率

    private List<CheckCountVO> checks           = Lists.newArrayList(); // 各学院审核情况

    /**
     * 统计学费
     * 
     * @since 2011-9-1
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String execute() throws Exception
    {
        Welbatch welbatch = this.welbatchManager.getCurrentBatch();

        allCount = studentManager.countStudent(welbatch, true);

        passCount = studentManager.countChechPassStudent(null, welbatch);

        noCheckCount = checkLogManager.countNoCheckStudent(null, welbatch);

        unpassCount = allCount - passCount - noCheckCount;

        try
        {
            passRate = new DecimalFormat("0.00 ").format((float) passCount
                    * 100 / allCount);
        }
        catch (Exception e)
        {
            passRate = "0.00";
        }

        checks = checkLogManager.getCheckCounts(welbatch);

        return SUCCESS;
    }

    public long getAllCount()
    {
        return allCount;
    }

    public long getPassCount()
    {
        return passCount;
    }

    public long getUnpassCount()
    {
        return unpassCount;
    }

    public long getNoCheckCount()
    {
        return noCheckCount;
    }

    public String getPassRate()
    {
        return passRate;
    }

    public List<CheckCountVO> getChecks()
    {
        return checks;
    }
}
