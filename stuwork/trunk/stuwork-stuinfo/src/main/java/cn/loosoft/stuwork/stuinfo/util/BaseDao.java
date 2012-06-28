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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.google.common.collect.Lists;

/**
 * 最原始JDBC查询
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2011-1-16
 */

public class BaseDao
{
    private Connection conn   = null;

    private Statement  stmt   = null;

    ResultSet          rs     = null;

    private String     driver = "";

    private String     url    = "";

    private String     user   = "";

    private String     pwd    = "";

    /** Creates a new instance of Operation */
    public BaseDao()
    {
        init();
    }

    private void init()
    {
        try
        {

            Configuration rc = new Configuration(Configuration
                    .getAbsolutePath("application.properties"));// 绝对路径
            driver = rc.getValue("jdbc.driver");
            url = rc.getValue("jdbc.url");
            user = rc.getValue("jdbc.username");
            pwd = rc.getValue("jdbc.password");
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url, user, pwd);
            stmt = conn.createStatement();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * TODO 查询记录
     * 
     * @param sn
     *            记录的学生姓名
     * @return String 查询的结果
     * @throws SQLException
     */
    public List<String> searchStuId(String sql)
    {
        List<String> list = Lists.newArrayList();
        try
        {
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                String str = rs.getString("studentNo");
                list.add(str);
            }

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {

            try
            {
                if (rs != null)
                {
                    rs.close();
                }
                if (stmt != null)
                {
                    stmt.close();
                }
                if (conn != null)
                {
                    conn.close();
                }
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }

        }
        return list;
    }

    public static void main(String[] args) throws Exception
    {
        // String a = "　aaaa aaaa ";
        // a = a.replaceAll("　", " ");
        // a = a.trim();
        // while (a.startsWith(" "))
        // {
        // a = a.substring(1, a.length()).trim();
        // }
        // while (a.endsWith(" "))
        // {
        // a = a.substring(0, a.length() - 1).trim();
        // }
        // System.out.println(a);
        java.util.Date date1 = new java.util.Date();
        System.out.println(date1.toString()); // 结
        String dateString = "Mon Feb 07 16:58:41 CST 2011";
        SimpleDateFormat sdf = new SimpleDateFormat(
                "EEE MMM dd HH:mm:ss z yyyy", Locale.US);
        Date d = sdf.parse(dateString);
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(sd.format(d));
    }

}
