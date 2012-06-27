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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import cn.loosoft.stuwork.arch.vo.CountVO;

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

    private ResultSet  rs     = null;

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
     * 院系统计
     */
    public List<CountVO> collegeCount(String sql)
    {
        List<CountVO> countVOs = Lists.newArrayList();
        try
        {
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                CountVO countVO = new CountVO();
                countVO.setCollegeName(rs.getString("collegeName"));
                String status = rs.getString("status");
                countVO.setTotal(Integer.parseInt(rs.getString("amountB")));
                countVO.setAmount(Integer.parseInt(rs.getString("amountA")));
                if (null == status || StringUtils.isEmpty(status))
                {
                    status = "缺档";
                }
                countVO.setStatus(status);
                countVOs.add(countVO);
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
        return countVOs;
    }

    /**
     * 专业统计
     */
    public List<CountVO> majorCount(String sql)
    {
        List<CountVO> countVOs = Lists.newArrayList();
        try
        {
            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                CountVO countVO = new CountVO();
                countVO.setCollegeName(rs.getString("collegeName"));
                countVO.setMajorName(rs.getString("majorName"));
                String status = rs.getString("status");
                countVO.setTotal(rs.getInt("total"));
                countVO.setAmount(rs.getInt("amount"));
                if (null == status || StringUtils.isEmpty(status))
                {
                    status = "缺档";
                }
                countVO.setStatus(status);
                countVOs.add(countVO);
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
        return countVOs;
    }

    /**
     * 班级统计
     */
    public List<CountVO> classCount(String sql)
    {
        List<CountVO> countVOs = Lists.newArrayList();
        try
        {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next())
            {
                CountVO countVO = new CountVO();
                countVO.setCollegeName(rs.getString("collegeName"));
                countVO.setClassName(rs.getString("className"));
                countVO.setMajorName(rs.getString("majorName"));
                String status = rs.getString("status");
                countVO.setTotal(rs.getInt("total"));
                countVO.setAmount(rs.getInt("amount"));
                if (null == status || StringUtils.isEmpty(status))
                {
                    status = "缺档";
                }
                countVO.setStatus(status);
                countVOs.add(countVO);
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
        return countVOs;
    }

    public static void main(String[] args) throws Exception
    {
        String sql = "select A.collegeName, A.status,A.amountA,B.amountB from (select inst.name as collegeName,arch.status as status,count(*) as amountA  from stuwork_stuinfo.student as stu  left join stuwork_backmanage.bm_institute as inst on stu.collegeCode = inst.code left join stuwork_archives.archives as arch on stu.studentNo = arch.stuId group by collegeName,status) as A left join (select inst.name as collegeName,count(*) as amountB from stuwork_stuinfo.student as stu left join stuwork_backmanage.bm_institute as inst on stu.collegeCode = inst.code group by collegeName) as B on A.collegeName = B.collegeName";
        BaseDao baseDao = new BaseDao();
        List<CountVO> countVOs = baseDao.collegeCount(sql);
        if (null != countVOs)
        {
            System.out.println(countVOs.size());
            for (int i = 0; i < countVOs.size(); i++)
            {
                CountVO countVO = countVOs.get(i);
                System.out.println(countVO.getStatus());
            }
        }
        else
        {
            System.out.println("为空");
        }

    }

}
