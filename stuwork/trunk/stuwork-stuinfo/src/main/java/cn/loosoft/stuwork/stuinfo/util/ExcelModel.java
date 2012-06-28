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
package cn.loosoft.stuwork.stuinfo.util;

import java.util.ArrayList;

/**
 * Excel模型类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2011-1-12
 */

public class ExcelModel
{
    /**
     * 文件路径，这里是包含文件名的路径
     */
    protected String    path;

    /** */
    /**
     * 工作表名
     */
    protected String    sheetName;

    /** */
    /**
     * 表内数据,保存在二维的ArrayList对象中
     */
    protected ArrayList data;

    /** */
    /**
     * 数据表的标题内容
     */
    protected ArrayList header;

    /** */
    /**
     * 用于设置列宽的整型数组 这个方法在程序中暂未用到 适用于固定列数的表格
     */
    protected int[]     width;

    public ExcelModel()
    {
        path = "report.xls";
    }

    public ExcelModel(String path)
    {
        this.path = path;
    }

    public void setPath(String path)
    {
        this.path = path;
    }

    public String getPath()
    {
        return this.path;
    }

    public void setSheetName(String sheetName)
    {
        this.sheetName = sheetName;
    }

    public String getSheetName()
    {
        return this.sheetName;
    }

    public void setData(ArrayList data)
    {
        this.data = data;
    }

    public ArrayList getData()
    {
        return this.data;
    }

    public void setHeader(ArrayList header)
    {
        this.header = header;
    }

    public ArrayList getHeader()
    {
        return this.header;
    }

    public void setWidth(int[] width)
    {
        this.width = width;
    }

    public int[] getWidth()
    {
        return this.width;
    }
}
