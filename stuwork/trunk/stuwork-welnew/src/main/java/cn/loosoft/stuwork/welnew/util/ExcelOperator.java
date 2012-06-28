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
package cn.loosoft.stuwork.welnew.util;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 * excel操作类
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2011-1-12
 */

public class ExcelOperator
{
    /**
     * 将数据信息写入到Excel表文件，采取自建输出流的方式。
     * 
     * @param excel
     *            ExcelModel Excel表的模型对象
     * @throws Exception
     */
    public void WriteExcel(ExcelModel excel) throws Exception
    {

        try
        {

            String file = excel.getPath();

            // 新建一输出文件流
            FileOutputStream fOut = new FileOutputStream(file);
            BufferedOutputStream bf = new BufferedOutputStream(fOut);

            HSSFWorkbook workbook = this.getInitWorkbook(excel);

            // 把相应的Excel 工作簿存盘
            workbook.write(fOut);
            fOut.flush();
            bf.flush();
            // 操作结束，关闭文件
            bf.close();
            fOut.close();
            // System.out.println("Done!");
        }
        catch (Exception e)
        {
            // System.out.print("Failed!");
            throw new Exception(e.getMessage());
        }

    }

    /** */
    /**
     * 将数据信息写入到Excel表文件 ，采取传入输出流的方式。
     * 
     * @param excel
     *            Excel表的模型对象
     * @param out
     *            OutputStream 输出流
     * @throws Exception
     */
    public void WriteExcel(ExcelModel excel, OutputStream out) throws Exception
    {
        try
        {
            HSSFWorkbook workbook = this.getInitWorkbook(excel);
            workbook.write(out);

            out.close();
            // System.out.println("Done!");
        }
        catch (Exception e)
        {
            // System.out.println("Failed!");
            throw new Exception(e.getMessage());
        }

    }

    /** */
    /**
     * 取得填充了数据的工作簿
     * 
     * @param excel
     *            ExcelModel Excel表的模型对象
     * @return HSSFWorkbook 工作簿对象
     */
    @SuppressWarnings("unchecked")
    private HSSFWorkbook getInitWorkbook(ExcelModel excel)
    {

        // 创建新的Excel 工作簿
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 在Excel工作簿中建一工作表
        HSSFSheet sheet = null;
        String sheetName = excel.getSheetName();

        if (sheetName != null)
        {
            sheet = workbook.createSheet(sheetName);
        }
        else
        {
            sheet = workbook.createSheet();
        }

        // 设置表头字体
        HSSFFont font_h = workbook.createFont();
        font_h.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

        // 设置格式
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setFont(font_h);

        // 在索引0的位置创建行（最顶端的行）
        HSSFRow row = sheet.createRow((short) 0);

        ArrayList header = excel.getHeader();
        if (header != null)
        {
            for (int i = 0; i < header.size(); i++)
            {

                // 在索引0的位置创建单元格（左上端）
                HSSFCell cell = row.createCell((short) i);
                // 定义单元格为字符串类型
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                // 设置解码方式
                // cell.setEncoding((short) 1);

                // 设置单元格的格式
                cell.setCellStyle(cellStyle);
                // 在单元格中写入表头信息
                cell.setCellValue((String) header.get(i));

            }
        }

        ArrayList cdata = excel.getData();
        for (int i = 0; i < cdata.size(); i++)
        {
            // 从第二行开始
            HSSFRow row1 = sheet.createRow(i + 1);
            ArrayList rdata = (ArrayList) cdata.get(i);
            // 打印一行数据
            for (int j = 0; j < rdata.size(); j++)
            {

                HSSFCell cell = row1.createCell((short) j);
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                // 设置字符编码方式
                // cell.setEncoding((short) 1);

                Object o = rdata.get(j);

                // 造型,使写入到表中的数值型对象恢复为数值型，
                // 这样就可以进行运算了
                if (o instanceof BigDecimal)
                {
                    BigDecimal b = (BigDecimal) o;
                    cell.setCellValue(b.doubleValue());
                }
                else
                    if (o instanceof Integer)
                    {
                        Integer it = (Integer) o;
                        cell.setCellValue(it.intValue());

                    }
                    else
                        if (o instanceof Long)
                        {
                            Long l = (Long) o;
                            cell.setCellValue(l.intValue());

                        }
                        else
                            if (o instanceof Double)
                            {
                                Double d = (Double) o;
                                cell.setCellValue(d.doubleValue());
                            }
                            else
                                if (o instanceof Float)
                                {
                                    Float f = (Float) o;
                                    cell.setCellValue(f.floatValue());
                                }
                                else
                                {
                                    cell.setCellValue(o + "");
                                }

            }

        }
        return workbook;

    }
}
