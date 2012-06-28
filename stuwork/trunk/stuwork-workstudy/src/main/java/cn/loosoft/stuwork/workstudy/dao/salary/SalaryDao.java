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
package cn.loosoft.stuwork.workstudy.dao.salary;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.workstudy.entity.salary.Salary;
import cn.loosoft.stuwork.workstudy.util.JdbcUtil;

/**
 * 
 * 工资泛型DAO.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-4
 */
@Component
public class SalaryDao extends HibernateDao<Salary, Long>
{
    private static final String GETBYIDCARD_STUDENTNO = "from Salary where studentNo=?";

    private static final String QUERYNEWSBY_ID         = "from Salary where id=?";

    /**
     * 根据考生号查询学生工资信息 Description of this Method
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param examineeNo
     * @return
     */
    public List<Salary> getByStudentNo(String studentNo)
    {
        return super.find(GETBYIDCARD_STUDENTNO, studentNo);

    }

    /**
     * 根据考生号查询学生工资信息，并分页 Description of this Method
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param examineeNo
     * @param pageNo
     * @return
     */
    public List<Salary> getSalaryByStudentNo(String studentNo, int pageNo)
    {
        String sql = "select * from stujob_salary where studentNo='"
                + studentNo + "' limit " + ((pageNo * 20) - 20) + "," + 20;
        List<Salary> list = new ArrayList<Salary>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            conn = JdbcUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                Salary salary = new Salary();
                salary.setId(rs.getLong("id"));
                salary.setStudentName(rs.getString("studentName"));
                salary.setStudentNo(rs.getString("studentNo"));
                salary.setPostName(rs.getString("postName"));
                salary.setCompanyName(rs.getString("companyName"));
                salary.setWorkStartTime(rs.getDate("workStartTime"));
                salary.setWorkStopTime(rs.getDate("workStopTime"));
                salary.setWorkTime(rs.getString("workTime"));
                salary.setStandard(rs.getString("standard"));
                salary.setAmount(rs.getString("amount"));
                list.add(salary);
            }
        }
        catch (Exception e)
        {
            e.getStackTrace();
        }
        finally
        {
            JdbcUtil.release(rs, stmt, conn);
        }

        return list;

    }

    public Salary getSalaryById(Long id)
    {
        return super.findUnique(QUERYNEWSBY_ID, id);
    }
}
