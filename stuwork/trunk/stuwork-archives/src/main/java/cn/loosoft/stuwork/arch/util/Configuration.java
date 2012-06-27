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
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;

/**
 * 
 * 读取properties文件
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-4-14
 */
public class Configuration
{
    private final Properties propertie;

    private FileInputStream  inputFile;

    private FileOutputStream outputFile;

    /**
     * 初始化Configuration类
     * 
     * @since 2011-4-14
     */
    public Configuration()
    {
        propertie = new Properties();
    }

    /**
     * 初始化Configuration类
     * 
     * @param filePath
     *            要读取的配置文件的路径+名称
     */
    public Configuration(String filePath)
    {

        propertie = new Properties();
        try
        {
            inputFile = new FileInputStream(filePath);
            propertie.load(inputFile);
            inputFile.close();
        }
        catch (FileNotFoundException ex)
        {
            System.out.println("读取属性文件--->失败！- 原因：文件路径错误或者文件不存在");
            ex.printStackTrace();
        }
        catch (IOException ex)
        {
            System.out.println("装载文件--->失败!");
            ex.printStackTrace();
        }
    }

    /**
     * 
     * 取得文件在项目中的绝对路径
     * 
     * @since 2011-4-14
     * @author shanru.wu
     * @param path
     * @return
     */
    public static String getAbsolutePath(String path)
    {
        ClassPathResource resource = new ClassPathResource(path);
        try
        {
            path = resource.getURL().getPath().replace("20%", "");
        }
        catch (Exception e)
        {
            System.out.println(e.toString());
        }
        return path;

    }

    /**
     * 重载函数,得到key的值
     * 
     * @param key
     *            取得其值的键
     * @return key的值
     */
    public String getValue(String key)
    {
        if (propertie.containsKey(key))
        {
            String value = propertie.getProperty(key);// 得到某一属性的值
            return value;
        }
        else
        {
            return "";
        }
    }

    /**
     * 重载函数，得到key的值
     * 
     * @param fileName
     *            properties文件的路径+文件名
     * @param key
     *            取得其值的键
     * @return key的值
     */
    public String getValue(String fileName, String key)
    {
        try
        {
            String value = "";
            inputFile = new FileInputStream(fileName);
            propertie.load(inputFile);
            inputFile.close();
            if (propertie.containsKey(key))
            {
                value = propertie.getProperty(key);
                return value;
            }
            else
            {
                return value;
            }
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
            return "";
        }
        catch (IOException e)
        {
            e.printStackTrace();
            return "";
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            return "";
        }
    }

    /**
     * 清除properties文件中所有的key和其值
     */
    public void clear()
    {
        propertie.clear();
    }

    /**
     * 改变或添加一个key的值，当key存在于properties文件中时该key的值被value所代替， 当key不存在时，该key的值是value
     * 
     * @param key
     *            要存入的键
     * @param value
     *            要存入的值
     */
    public void setValue(String key, String value)
    {
        propertie.setProperty(key, value);
    }

    /**
     * 将更改后的文件数据存入指定的文件中，该文件可以事先不存在。
     * 
     * @param fileName
     *            文件路径+文件名称
     * @param description
     *            对该文件的描述
     */
    public void saveFile(String fileName, String description)
    {
        try
        {
            outputFile = new FileOutputStream(fileName);
            propertie.store(outputFile, description);
            outputFile.close();
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException ioe)
        {
            ioe.printStackTrace();
        }
    }

    public static void main(String[] args)
    {
        Configuration rc = new Configuration(
                "\\WEB-INF\\classes\\application.properties");// 相对路径

        String driver = rc.getValue("jdbc.driver");// 以下读取properties文件的值
        String url = rc.getValue("jdbc.url");
        String username = rc.getValue("jdbc.username");
        String password = rc.getValue("jdbc.password");

        System.out.println(driver);// 以下输出properties读出的值
        System.out.println(url);
        System.out.println(username);
        System.out.println(password);

        // Configuration cf = new Configuration();
        // String ipp = cf.getValue(".\config\test.properties", "ip");
        // System.out.println("ipp = " + ipp);
        // cf.clear();
        // cf.setValue("min", "999");
        // cf.setValue("max", "1000");
        // cf.saveFile(".\config\save.perperties", "test");

        // Configuration saveCf = new Configuration();
        // saveCf.setValue("min", "10");
        // saveCf.setValue("max", "1000");
        // saveCf.saveFile(".\config\save.perperties");

    }
}
