//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: qingang
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

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.log.DevolverLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.DevolverCoVO;
import cn.loosoft.stuwork.welnew.vo.DevolverQXVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 转移统计
 * 
 * @author qingang
 * @version 1.0
 * @since 2011-9-1
 */
@Namespace("/count")
public class DevolvereportAction extends ActionSupport
{

    /**
     * serialVersionUID long
     */
    private static final long  serialVersionUID = 6260619720510283424L;

    @Autowired
    private WelbatchManager    welbatchManager;

    @Autowired
    private StudentManager     studentManager;

    @Autowired
    private DevolverLogManager devolverLogManager;

    private List<DevolverQXVO> qxList           = Lists.newArrayList();

    private List<DevolverCoVO> devolverLists    = Lists.newArrayList();

    public List<DevolverCoVO> getDevolverLists()
    {
        return devolverLists;
    }

    @Override
    public String execute() throws Exception
    {
        try
        {
            // 获得当前批次
            Welbatch curWelbatch = welbatchManager.getCurrentBatch();

            // 获得当前批次下的已报到人数
            long num = studentManager.countStudent(curWelbatch, true);

            qxList = devolverLogManager.getCountQX(curWelbatch, num);

            devolverLists = devolverLogManager.getCountByCollege(curWelbatch,
                    num);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public List<DevolverQXVO> getQxList()
    {
        return qxList;
    }

}
