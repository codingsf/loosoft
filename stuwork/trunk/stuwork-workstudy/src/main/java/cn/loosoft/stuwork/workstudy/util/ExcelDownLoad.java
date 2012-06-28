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
package cn.loosoft.stuwork.workstudy.util;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

/**
 * excel下载接口
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2011-1-12
 */

public interface ExcelDownLoad
{

    /** */
    /**
     * 在已文件已存在的情况下，采用读取文件流的方式实现左键点击下载功能， 本系统没有采取这个方法,而是直接将数据传往输出流,效率更高。
     * 
     * @param inPutFileName
     *            读出的文件名
     * @param outPutFileName
     *            　保存的文件名
     * @param HttpServletResponse
     *            　
     * @see HttpServletResponse
     * @throws IOException
     */
    public void downLoad(String inPutFileName, String outPutFileName,
            HttpServletResponse response) throws IOException;

    /** */
    /**
     * 在已文件不存在的情况下，采用生成输出流的方式实现左键点击下载功能。
     * 
     * @param outPutFileName
     *            　保存的文件名
     * @param out
     *            ServletOutputStream对象
     * @param downExcel
     *            填充了数据的ExcelModel
     * @param HttpServletResponse
     *            　
     * @see HttpServletResponse
     * @throws Exception
     */
    public void downLoad(String outPutFileName, ExcelModel downExcel,
            HttpServletResponse response) throws Exception;
}
