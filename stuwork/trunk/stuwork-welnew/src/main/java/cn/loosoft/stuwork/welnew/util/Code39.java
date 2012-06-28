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

import java.awt.Color;
import java.awt.Graphics;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * Description of the class
 * 
 * @author Administrator
 * @version 1.0
 * @since 2010-12-26
 */

public class Code39
{
    private static final int rate = 2;      // 条码宽条与窄条宽度之比

    private final int        m_nNarrowWidth; // 窄条的宽度像素数

    private final int        m_nImageHeight; // 条码的高度像素数

    private boolean          m_bRotato;     // 输出的图像是否需要先旋转

    /** */
    /**
     * 根据strCodes传入的字符串，生成符合BarCode 39规范的JPEG输出流；
     * 
     * @param nNarrowWidth
     * @param nImageHeight
     */
    public Code39(int nNarrowWidth, int nImageHeight)
    {
        m_nNarrowWidth = nNarrowWidth;
        m_nImageHeight = nImageHeight;
        m_bRotato = false;
    }

    /**
     * 
     构造函数，默认窄条宽为4像素，条码高度是100像素；
     */
    public Code39()
    {
        this(1, 33);
    }

    /** */
    /**
     * 设置是否需要将结果图像在输出之前进行旋转；系统默认是不旋转
     * 
     * @param b
     *            true:旋转，false:不旋转
     */
    public void setRotato(boolean b)
    {
        m_bRotato = b;
    }

    /** */
    /**
     * 生成相应的Bar Code图像，格式以jpeg格式的输出流；
     * 
     * @param strCodes
     *            要生成条码的字符串，注意该字符串需要包含首尾的两个星号
     * @param out
     *            接结果的输出流
     * @throws IOException
     * @throws ImageFormatException
     * @throws IOException
     */
    public void getImage(String strCodes, String path)
    throws ImageFormatException, IOException
    {
        System.getProperty("file.separator");
        File myPNG = new File(path);
        OutputStream out = new FileOutputStream(myPNG);
        if (null == strCodes || null == out || 0 == strCodes.length())
        {
            return;
        }

        int nImageWidth = (strCodes.length() * (3 * rate + 7) * m_nNarrowWidth);

        BufferedImage bi = new BufferedImage(nImageWidth, m_nImageHeight + 13,
                BufferedImage.TYPE_INT_RGB);
        Graphics g = bi.getGraphics();

        g.setColor(Color.WHITE);
        g.fillRect(0, 0, nImageWidth, m_nImageHeight);

        g.setColor(Color.BLACK);
        int startx = 0;
        // strCodes = strCodes.substring(1, strCodes.length() - 1);
        // System.out.println(strCodes);
        for (int i = 0; i < strCodes.length(); i++)
        {
            startx = drawOneChar(g, startx, strCodes.charAt(i));
        }

        g.setColor(Color.WHITE);
        g.fillRect(0, 33, nImageWidth, 13);// 跟上面33一致

        g.setColor(Color.BLACK);
        strCodes = strCodes.substring(1, strCodes.length() - 1);

        int strLength = nImageWidth / strCodes.length();

        for (int i = 0; i < strCodes.length(); i++)
        {

            g.drawString(String.valueOf(strCodes.charAt(i)), i * strLength + 7,
                    45);// 62-17=45
        }
        if (m_bRotato)
        {
            bi = flipX2Y(bi);
        }

        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
        encoder.encode(bi);

        while (true) // 图片生成完毕后，向下运行
        {
            if (myPNG.exists())
            {
                // System.out.println("---------over");
                break;
            }
        }
    }

    /** */
    /**
     * 辅助方法，绘制一个字符
     * 
     * @param g
     *            画布
     * @param x
     *            起始位置
     * @param ch
     *            要绘制的字符
     * @return 下一个要绘制字符的位置
     */
    private int drawOneChar(Graphics g, int x, char ch)
    {
        short sCode = getCharCode(ch);
        for (int i = 0; i < 9; i++)
        {
            int width = m_nNarrowWidth;

            if (((0x100 >>> i) & sCode) != 0)
            {
                width *= rate;
            }

            if ((i & 0x1) == 0)
            {
                g.fillRect(x, 0, width, m_nImageHeight);
            }

            x += width;
        }
        return x + m_nNarrowWidth;
    }

    /** */
    /**
     * 图像翻转，即X与Y方向互换
     * 
     * @param in
     *            源图像
     * @return 翻转后的图像
     */
    private BufferedImage flipX2Y(BufferedImage in)
    {
        BufferedImage out = new BufferedImage(in.getHeight(), in.getWidth(), in
                .getType());
        // 请查看JDK
        AffineTransform affineTransform = new AffineTransform(0, 1, 1, 0, 0, 0);
        AffineTransformOp affineTransformOp = new AffineTransformOp(
                affineTransform, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
        return affineTransformOp.filter(in, out);
    }

    // 原来旋转的版本，仅供参考
    // private BufferedImage rotate(BufferedImage in)
    // {
    // int width = in.getWidth();
    // int height = in.getHeight();
    // BufferedImage out = new BufferedImage(height, width, in.getType());
    //
    // AffineTransform affineTransform =
    // AffineTransform.getRotateInstance(Math.toRadians(90));
    // affineTransform.translate(0, -height);
    //   
    // AffineTransformOp affineTransformOp = new
    // AffineTransformOp(affineTransform,
    // AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
    // affineTransformOp.filter(in, out);
    // return out;
    // }

    // Code39符号表
    private static final char[]  m_chars = { '0', '1', '2', '3', '4', '5', '6',
        '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
        'X', 'Y', 'Z', '-', '.', ' ', '*', '$', '/', '+', '%' };

    // Code39符号所对应的码表，16进制编码 n为0 w为1
    private static final short[] m_codes = { 0x34, 0x121, 0x61, 0x160, 0x31,
        0x130, 0x70, 0x25, 0x124, 0x64, 0x109, 0x49, 0x148, 0x19, 0x118,
        0x58, 0xd, 0x10c, 0x4c, 0x1c, 0x103, 0x43, 0x142, 0x13, 0x112,
        0x52, 0x7, 0x106, 0x46, 0x16, 0x181, 0xc1, 0x1c0, 0x91, 0x190,
        0xd0, 0x85, 0x184, 0xc4, 0x94, 0xa8, 0xa2, 0x8a, 0x2a };

    /** */
    /**
     * 通过码表符号获得码表字符
     * 
     * @param ch
     *            码表符号
     * @return 码表值
     */
    private static short getCharCode(char ch)
    {
        for (int i = 0; i < m_chars.length; i++)
        {
            if (ch == m_chars[i])
            {
                return m_codes[i];
            }
        }
        return 0;
    }

    // 生成条形码的数据----8位随机字符串
    public String barcodeData()
    {
        String dataFinal = null;
        // String dataTemp = longDateFormat.format(new java.util.Date());
        Random r = new Random();
        String strRandom = "" + r.nextInt(9) + "" + r.nextInt(9) + ""
        + r.nextInt(9) + "" + r.nextInt(9) + "";
        dataFinal = strRandom;
        // dataFinal = dataTemp+strRandom;
        /*
         * while(hasCus(dataFinal)) //判断是否有此客户代码 {
         * strRandom=""+r.nextInt(9)+""+r
         * .nextInt(9)+""+r.nextInt(9)+""+r.nextInt
         * (9)+""+r.nextInt(9)+""+r.nextInt
         * (9)+""+r.nextInt(9)+""+r.nextInt(9)+""; dataFinal =
         * dataTemp+strRandom; }
         */
        return dataFinal;
    }

    public static void main(String[] args){
        Code39 code = new Code39();
        try
        {
            code.getImage("*10340321155752*",
                    "d:\\10340321155752" + ".jpg");
        }
        catch (ImageFormatException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

}
