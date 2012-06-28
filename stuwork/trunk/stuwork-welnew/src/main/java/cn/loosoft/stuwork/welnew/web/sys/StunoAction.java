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
package cn.loosoft.stuwork.welnew.web.sys;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.sys.SysData;
import cn.loosoft.stuwork.welnew.service.sys.SysDataManager;

/**
 * 
 * 学号设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "stuno.action", type = "redirect") })
public class StunoAction extends CrudActionSupport<SysData>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private SysDataManager    sysDataManager;       // 基础数据管理

    private SysData           sysData;              // 基础数据实体

    private boolean           enbale;               // 是否自动

    public boolean isEnbale()
    {
        return enbale;
    }

    public void setEnbale(boolean enbale)
    {
        this.enbale = enbale;
    }

    @Autowired
    public void setSysDataManager(SysDataManager sysDataManager)
    {
        this.sysDataManager = sysDataManager;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-12
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-12
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-12
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        sysData = sysDataManager.getSysData(SysData.XHSZ);
        if (sysData != null)
        {
            if (sysData.getSetvalue().equals("是"))
            {
                enbale = true;
            }
            else
            {
                enbale = false;
            }
        }
        else
        {
            sysData = new SysData();
        }
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-12
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        System.out.println(enbale);
        // TODO Auto-generated method stub
        if (enbale)
        {
            sysData.setSetvalue("是");
        }
        else
        {
            sysData.setSetvalue("否");
        }
        sysData.setType(SysData.XHSZ);
        sysDataManager.save(sysData);
        return INPUT;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-12
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public SysData getModel()
    {
        // TODO Auto-generated method stub
        return sysData;
    }

}
