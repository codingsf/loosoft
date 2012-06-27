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
package cn.loosoft.stuwork.arch.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

/**
 * excel下载类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2011-1-12
 */

public class BaseExcelDownLoad implements ExcelDownLoad
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
            HttpServletResponse response) throws IOException
    {

        // 打开指定文件的流信息
        InputStream is = new FileInputStream(inPutFileName);
        // 写出流信息
        int data = -1;
        OutputStream outputstream = response.getOutputStream();

        // 清空输出流
        response.reset();
        // 设置响应头和下载保存的文件名
        response.setHeader("content-disposition", "attachment;filename="
                + outPutFileName);
        // 定义输出类型
        response.setContentType("APPLICATION/msexcel");

        while ((data = is.read()) != -1)
        {
            outputstream.write(data);
        }
        is.close();
        outputstream.close();

        // response.flushBuffer();

    }

    /** */
    /**
     * 在文件不存在的情况下，采用生成输出流的方式实现左键点击下载功能。
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
            HttpServletResponse response) throws Exception
    {

        // 取得输出流
        OutputStream out = response.getOutputStream();

        // 清空输出流
        response.reset();

        outPutFileName = URLEncoder.encode(outPutFileName, "UTF-8");

        // 设置响应头和下载保存的文件名
        response.setHeader("content-disposition", "attachment;filename="
                + outPutFileName);
        // 定义输出类型
        response.setContentType("APPLICATION/msexcel; charset=UTF-8");

        ExcelOperator op = new ExcelOperator();
        // out:传入的输出流
        op.WriteExcel(downExcel, out);

        out.close();

        // 这一行非常关键，否则在实际中有可能出现莫名其妙的问题！！！
        response.flushBuffer();// 强行将响应缓存中的内容发送到目的地

    }
}
