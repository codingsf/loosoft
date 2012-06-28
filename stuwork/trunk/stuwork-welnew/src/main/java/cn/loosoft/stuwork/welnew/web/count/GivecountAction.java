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
package cn.loosoft.stuwork.welnew.web.count;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.item.ExtendItemManager;
import cn.loosoft.stuwork.welnew.vo.AllSchoolGiveVO;
import cn.loosoft.stuwork.welnew.vo.SchoolGiveVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 发放统计Action.
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-3-25
 */
@Namespace("/count")
public class GivecountAction extends ActionSupport
{

    /**
     * serialVersionUID long
     */
    private static final long     serialVersionUID = 1L;

    private WelbatchManager       welbatchManager;

    private ExtendItemManager     extendItemManager;

    private CostItemManager       costItemManager;

    private List<AllSchoolGiveVO> giveVOs          = Lists.newArrayList(); // 统计全校发放人数

    private List<SchoolGiveVO>    schoolGiveVOs    = Lists.newArrayList(); // 统计各学院发放人数

    private long                  size;                                   // 统计发放项目个数

    /**
     * 统计发放人数
     * 
     * @since 2011-9-1
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String execute() throws Exception
    {
        // 获得当前批次
        Welbatch welbatch = welbatchManager.getCurrentBatch();

        // 获得统计全校发放人数列表
        giveVOs = extendItemManager.getAllSchoolGive(welbatch);

        // 获得统计各学院发放人数列表
        schoolGiveVOs = extendItemManager.getSchoolGive(welbatch);

        // 统计发放项目个数
        size = costItemManager.countExtendItems();

        return SUCCESS;
    }

    @Autowired
    public void setExtendItemManager(ExtendItemManager extendItemManager)
    {
        this.extendItemManager = extendItemManager;
    }

    @Autowired
    public void setCostItemManager(CostItemManager costItemManager)
    {
        this.costItemManager = costItemManager;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

    // 统计全校发放人数
    public List<AllSchoolGiveVO> getGiveVOs()
    {
        return giveVOs;
    }

    // 统计各学院发放人数
    public List<SchoolGiveVO> getSchoolGiveVOs()
    {
        return schoolGiveVOs;
    }

    // 统计发放项目个数
    public long getSize()
    {
        return size;
    }

}
