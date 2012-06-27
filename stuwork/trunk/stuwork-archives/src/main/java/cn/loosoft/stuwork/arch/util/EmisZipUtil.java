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

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Description of the class
 * 
 * @author Administrator
 * @version 1.0
 * @since 2011-1-19
 */

public class EmisZipUtil extends ZipOutputStream
{
    public EmisZipUtil(OutputStream outputStream)
    {
        this(outputStream, defaultEncoding, defaultLevel);
    }

    public EmisZipUtil(String file) throws IOException
    {
        this(new FileOutputStream(new File(file)), defaultEncoding,
                defaultLevel);
    }

    public EmisZipUtil(File file) throws IOException
    {
        this(new FileOutputStream(file), defaultEncoding, defaultLevel);
    }

    /**
     * 统一调用的构造函数
     * 
     * @param outputStream
     *            输出流(输出路径),*.zip
     * @param encoding
     *            编码
     * @param level
     *            压缩级别 0-9
     * */
    public EmisZipUtil(OutputStream outputStream, String encoding, int level)
    {
        super(outputStream);

        buf = new byte[1024];// 1024 KB缓冲

        if (level < 0 || level > 9)
        {
            level = 7;
        }
        this.setLevel(level);

        comment = new StringBuffer();
    }

    public String put(String fileName) throws IOException
    {
        return put(fileName, "");
    }

    /**
     * 加入要压缩的文件或文件夹
     * 
     * @param fileName
     *            加入一个文件,或一个文件夹
     * @param pathName
     *            生成ZIP时加的文件夹路径
     * @return fileName
     * */
    public String put(String fileName, String pathName) throws IOException
    {
        File file = new File(fileName);

        if (!file.exists())
        {
            comment.append("发现一个不存在的文件或目录: ").append(fileName).append("\n");
            return null;
        }

        // 递归加入文件
        if (file.isDirectory())
        {
            pathName += file.getName() + "/";
            String fileNames[] = file.list();
            if (fileNames != null)
            {
                for (String f : fileNames)
                {
                    put(fileName + "\\" + f, pathName);
                }
            }
            return fileName;
        }

        fileCount++;
        // System.out.println(fileCount + " = " + fileName);
        // System.out.println("file = " + file.getAbsolutePath());

        BufferedInputStream in = null;
        BufferedOutputStream out = null;
        try
        {
            in = new BufferedInputStream(new FileInputStream(file));
            out = new BufferedOutputStream(this);
            if (userFullPathName)
            {
                pathName += file.getPath();
            }
            this.putNextEntry(new ZipEntry(pathName + file.getName()));
            int len;
            // BufferedOutputStream会自动使用 this.buf,如果再使用in.read(buf)数据会错误
            while ((len = in.read()) > -1)
            {
                out.write(len);
            }
        }
        catch (IOException ex)
        {
            comment.append("一个文件读取写入时错误: ").append(fileName).append("\n");
        }

        if (out != null)
        {
            out.flush();
        }
        if (in != null)
        {
            in.close();
        }

        this.closeEntry();
        return file.getAbsolutePath();
    }

    public String[] put(String[] fileName) throws IOException
    {
        return put(fileName, "");
    }

    public String[] put(String[] fileName, String pathName) throws IOException
    {
        for (String file : fileName)
        {
            put(file, pathName);
        }
        return fileName;
    }

    /**
     * 压缩的文件个数
     * 
     * @return int
     * */
    public int getFileCount()
    {
        return this.fileCount;
    }

    // 压缩级别:0-9
    public static int     defaultLevel     = 7;

    // 编码,简体:GB2312,繁体:BIG5
    public static String  defaultEncoding  = "GB2312";

    // 压缩时用全路径,会生成对应的目录,false:不带路径,只有文件名
    public static boolean userFullPathName = false;

    // 注释
    public StringBuffer   comment;

    private int           fileCount        = 0;

}
