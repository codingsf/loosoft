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
package cn.loosoft.stuwork.welnew.vo;

/**
 * Description of the class
 * 
 * @author Administrator
 * @version 1.0
 * @since 2010-11-11
 */

public class DevolverVO
{
    private long    id;

    private String  name;        // 名称

    private String  devolverDesc; // 描述

    private boolean devolver;    // 是否转移

    /**
     * @return the devolver
     */
    public boolean isDevolver()
    {
        return devolver;
    }

    /**
     * @param devolver
     *            the devolver to set
     */
    public void setDevolver(boolean devolver)
    {
        this.devolver = devolver;
    }

    /**
     * @return the name
     */
    public String getName()
    {
        return name;
    }

    /**
     * @param name
     *            the name to set
     */
    public void setName(String name)
    {
        this.name = name;
    }

    /**
     * @return the devolverDesc
     */
    public String getDevolverDesc()
    {
        return devolverDesc;
    }

    /**
     * @param devolverDesc
     *            the devolverDesc to set
     */
    public void setDevolverDesc(String devolverDesc)
    {
        this.devolverDesc = devolverDesc;
    }

    public long getId()
    {
        return id;
    }

    public void setId(long id)
    {
        this.id = id;
    }
}
