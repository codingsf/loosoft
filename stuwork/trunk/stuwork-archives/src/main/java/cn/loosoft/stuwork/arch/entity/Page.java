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
package cn.loosoft.stuwork.arch.entity;

/**
 * Description of the class
 * 
 * @author Administrator
 * @version 1.0
 * @since 2010-12-26
 */

public class Page
{
    private int pageNo = 1; // 页数

    private int pageSize;  // 每一页大小

    private int totalCount; // 总条数

    /**
     * 
     * 取得总记录数, 默认值为-1.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public int getTotalCount()
    {

        return totalCount;
    }

    public void setTotalCount(int totalCount)
    {
        this.totalCount = totalCount;
    }

    /**
     * @param pageSize
     *            the pageSize to set
     */
    public void setPageSize(int pageSize)
    {
        this.pageSize = pageSize;
    }

    /**
     * 
     * 是否还有下一页.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public boolean isHasNext()
    {
        return (pageNo + 1 <= getTotalPages());
    }

    /**
     * 
     * 取得下页的页号, 序号从1开始. 当前页为尾页时仍返回尾页序号.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public int getNextPage()
    {
        if (isHasNext())
        {
            return pageNo + 1;
        }
        else
        {
            return pageNo;
        }
    }

    /**
     * 
     * 是否还有上一页.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public boolean isHasPre()
    {
        return (pageNo - 1 >= 1);
    }

    /**
     * 取得上页的页号, 序号从1开始. 当前页为首页时返回首页序号.
     */
    public int getPrePage()
    {
        if (isHasPre())
        {
            return pageNo - 1;
        }
        else
        {
            return pageNo;
        }
    }

    /**
     * 获得当前页的页号,序号从1开始,默认为1.
     */
    public int getPageNo()
    {
        return pageNo;
    }

    /**
     * 获得每页的记录数量,默认为20.
     */
    public int getPageSize()
    {
        return pageSize;
    }

    /**
     * @since 2010-12-23
     * @author shanru.wu 根据pageSize与totalCount计算总页数, 默认值为-1.
     */
    public long getTotalPages()
    {
        if (this.getTotalCount() < 0)
        {
            return -1;
        }

        long count = this.getTotalCount() / pageSize;
        if (this.getTotalCount() % pageSize > 0)
        {
            count++;
        }
        return count;
    }

    /**
     * 
     * 设置当前页的页号,序号从1开始,低于1时自动调整为1.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     * 
     */
    public void setPageNo(int pageNo)
    {
        this.pageNo = pageNo;
        if (this.pageNo < 1)
        {
            this.pageNo = 1;
        }
    }

}
