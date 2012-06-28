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
package cn.loosoft.stuwork.stuinfo.dao.student;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.stuinfo.entity.student.Student;
import cn.loosoft.stuwork.stuinfo.util.BaseDao;

/**
 * 
 * 学生对象的泛型DAO.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-12
 */
@Component
public class StudentDao extends HibernateDao<Student, Long>
{
	//
    //private static final String DELETE_STUDENTS        = "update Student set deleted=true where id in(:ids)";
//改成直接删除
	private static final String DELETE_STUDENTS        = "delete from  Student where id in(:ids)";
	  
    private static final String GETBYIDCARD_STUDNET    = "from Student  where deleted=false and  IDcard=?";

    private static final String GETBYSTUDENTNO_STUDNET = "from Student  where  deleted=false and  studentNo=? ";

    private static final String RESIDENCE_STUDENT      = "from Student where IDcard=? and name=?";

    private static final String MAJORCLAZZINFO_STUDENT = "from Student where examineeNo=? and name=?";

    private static final String GETBYNOTICEID_STUDENT  = "from Student  where noticeId=?";

    /**
     * 
     * 获得某个专业下某个学历下的即将毕业的学生数
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param majorCode
     * @param education
     * @param finishDate
     * @return
     */
    public long countGraduteStus(String majorCode, String education,
            Date beginDate, Date endDate)
    {
        String sql = "from Student where  majorCode=? and education = ? and (finishDate >= ? and finishDate <= ?)";

        return this.countHqlResult(sql, majorCode, education, beginDate,
                endDate);
    }

    /**
     * 
     * 根据院系编码对院系下的专业进行分组
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param collegeCode
     * @return
     */
    public List<Student> findStuGroupCol(String collegeCode)
    {
        String sql = "from Student where collegeCode=? group by majorCode";

        return this.find(sql, collegeCode);
    }

    /**
     * 
     * 根据院系编码和专业编码查找学生
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param collegeCode
     * @return
     */
    public List<Student> findStuByCollMaj(String collegeCode, String majorCode)
    {
        String sql = "from Student where collegeCode=? and majorCode=?";

        return this.find(sql, collegeCode, majorCode);
    }

    /**
     * 
     * 获得某个专业下某个学历的某个年级的班级数
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param majorCode
     * @param education
     * @param grade
     * @return
     */
    public long countStuGroupCla(String majorCode, String education, int grade)
    {
        String countSql = " select count(*) from (select distinct(classcode) from student  where grade = "
                + grade
                + " and majorCode='"
                + majorCode
                + "' and education='"
                + education + "'  ) as t";

        Session session = getSession();
        Object obj = session.createSQLQuery(countSql).uniqueResult();

        return Long.valueOf(String.valueOf(obj));
    }

    /**
     * 
     * 获得某个专业下的某个年级的班级数
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param majorCode
     * @param education
     * @param grade
     * @return
     */
    public long countStuGroupCla(String majorCode, int grade)
    {
        String countSql = " select count(*) from (select distinct(classcode) from student  where grade = "
                + grade + " and majorCode='" + majorCode + "'  ) as t";

        Session session = getSession();
        Object obj = session.createSQLQuery(countSql).uniqueResult();

        return Long.valueOf(String.valueOf(obj));
    }

    /**
     * 
     * 根据专业,学历,年级获得下面的学生数
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param majorCode
     * @param length
     * @param grade
     * @return
     */
    public long countStuByProperty(String majorCode, String education, int grade)
    {
        String sql = "from Student where  majorCode=? and education = ? and grade = ? and graduated = ? and inSchool = ?";

        return this.countHqlResult(sql, majorCode, education, grade, false,
                true);
    }

    /**
     * 
     * 根据专业,年级获得下面的学生数
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param majorCode
     * @param length
     * @param grade
     * @return
     */
    public long countStuByProperty(String majorCode, int grade)
    {
        String sql = "from Student where  majorCode=? and grade = ? and graduated = ? and inSchool = ?";

        return this.countHqlResult(sql, majorCode, grade, false, true);
    }

    /**
     * 
     * 获得某个专业下某个学历的某个年级的班级数
     * 
     * @since 2011-12-15
     * @author fangyong
     * @param majorCode
     * @param education
     * @param grade
     * @return
     */
    public long countStuByCollegeCode(String collegeCode)
    {
        String sql = "from Student where collegeCode=? and graduated = ? and inSchool = ?";

        return this.countHqlResult(sql, collegeCode, false, true);
    }

    /**
     * 保存新增或修改的对象.
     */
    @Override
    public void save(Student student)
    {
        try
        {
            super.save(student);
        }
        catch (Exception e)
        {
            System.out.println(e);
            System.out.println("保存学员信息失败");
        }
    }

    /**
     * 批量删除迎新学员.
     */
    public void deleteStudents(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STUDENTS, map);
    }

    /**
     * 
     * 根据考生号和姓名取得学员
     * 
     * @since 2010-8-23
     * @author wxd
     * @param examineeNo
     * @param name
     * @return
     */
    public Student getByExamineeNo(String examineeNo, String name)
    {
        return super.findUnique(MAJORCLAZZINFO_STUDENT, examineeNo, name);
    }

    /**
     * 根据身份证号和姓名取得学员
     * 
     * @since 2010-8-25
     * @author wxd
     * @param idCardNo
     * @param name
     * @return
     */
    public Student getByIdCardNo(String idCardNo, String name)
    {
        return super.findUnique(RESIDENCE_STUDENT, idCardNo, name);
    }

    /**
     * 根据通知书编号取得学员
     * 
     * @since 2010-12-6
     * @author shanru.wu
     * @param notcieId
     * @return
     */
    public Student getByNoticeId(String noticeId)
    {
        return super.findUnique(GETBYNOTICEID_STUDENT, noticeId);
    }

    /**
     * 根据学号取得学员
     * 
     * @since 2010-1-10
     * @author shanru.wu
     * @param studentNo
     * @return
     */
    public Student getByStudentNo(String studentNo)
    {
        return super.findUnique(GETBYSTUDENTNO_STUDNET, studentNo);
    }

    /**
     * 根据省份证号取得学员
     * 
     * @since 2010-12-6
     * @author shanru.wu
     * @param IDcard
     * @return
     */
    public Student getByIDcard(String IDcard)
    {
        return super.findUnique(GETBYIDCARD_STUDNET, IDcard);
    }

    /**
     * 
     * 固定获取前N条学号(10,15,20)
     * 
     * @since 2010-12-25
     * @author shanru.wu
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @param studentNo
     * @return
     */
    public List<String> getStudentNosByCondition(String collegeCode,
            String majorCode, String classCode, String studentNo, String name,
            String IDcard, String period, String examineeNo, String inDate,
            String finishDate, int pageNo, int pageSize)
    {
        BaseDao baseDao = new BaseDao();
        String sql = "select studentNo from student where isDeleted=0";

        if (collegeCode != null && StringUtils.isNotEmpty(collegeCode))
        {

            sql += " and collegeCode='" + collegeCode + "'";

        }
        if (majorCode != null && StringUtils.isNotEmpty(majorCode))
        {
            sql += " and majorCode='" + majorCode + "'";
        }
        if (classCode != null && StringUtils.isNotEmpty(classCode))
        {
            sql += " and classCode='" + classCode + "'";
        }
        if (studentNo != null && StringUtils.isNotEmpty(studentNo))
        {
            studentNo = studentNo.trim();
            sql += " and studentNo='" + studentNo + "'";
        }
        if (name != null && StringUtils.isNotEmpty(name))
        {
            name = name.trim();
            sql += " and name='" + name + "'";
        }
        if (IDcard != null && StringUtils.isNotEmpty(IDcard))
        {
            IDcard = IDcard.trim();
            sql += " and IDcard='" + IDcard + "'";
        }
        if (period != null && StringUtils.isNotEmpty(period))
        {
            sql += " and period<'" + period + "'";
        }
        if (examineeNo != null && StringUtils.isNotEmpty(examineeNo))
        {
            examineeNo = examineeNo.trim();
            sql += " and examineeNo='" + examineeNo + "'";
        }
        if (inDate != null)
        {
            sql += " and inDate='" + inDate + "'";
        }
        if (inDate != null)
        {
            sql += " and finishDate='" + finishDate + "'";
        }
        sql += " limit " + ((pageNo * pageSize) - pageSize) + "," + pageSize;
        return baseDao.searchStuId(sql);
    }

    /**
     * 
     * 根据查询条件批量获取学号
     * 
     * @since 2010-1-17
     * @author shanru.wu
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @param studentNo
     * @return
     */
    public List<String> getStudentNosCondition(String collegeCode,
            String majorCode, String classCode, String studentNo, String name,
            String IDcard, String period, String examineeNo, String inDate,
            String finishDate)
    {
        String hql = "select studentNo from Student student where deleted=false";
        if (collegeCode != null && StringUtils.isNotEmpty(collegeCode))
        {

            hql += " and student.collegeCode='" + collegeCode + "'";

        }
        if (majorCode != null && StringUtils.isNotEmpty(majorCode))
        {
            hql += " and student.majorCode='" + majorCode + "'";
        }
        if (classCode != null && StringUtils.isNotEmpty(classCode))
        {
            hql += " and student.classCode='" + classCode + "'";
        }
        if (studentNo != null && StringUtils.isNotEmpty(studentNo))
        {
            studentNo = studentNo.trim();
            hql += " and student.studentNo='" + studentNo + "'";
        }
        if (name != null && StringUtils.isNotEmpty(name))
        {
            name = name.trim();
            hql += " and student.name='" + name + "'";
        }
        if (IDcard != null && StringUtils.isNotEmpty(IDcard))
        {
            IDcard = IDcard.trim();
            hql += " and student.IDcard='" + IDcard + "'";
        }
        if (period != null && StringUtils.isNotEmpty(period))
        {
            hql += " and student.period<'" + period + "'";
        }
        if (examineeNo != null && StringUtils.isNotEmpty(examineeNo))
        {
            examineeNo = examineeNo.trim();
            hql += " and student.examineeNo='" + examineeNo + "'";
        }
        if (inDate != null)
        {
            hql += " and student.inDate='" + inDate + "'";
        }
        if (finishDate != null)
        {
            hql += " and student.finishDate='" + finishDate + "'";
        }
        return super.find(hql);
    }

    public long countStudent(String collegeCode, String majorCode,
            String classCode, String studentNo, String name, String IDcard,
            String period, String examineeNo, String inDate, String finishDate)
    {
        String hql = "from Student where studentNo!=null and deleted=false";
        if (collegeCode != null && StringUtils.isNotEmpty(collegeCode))
        {

            hql += " and collegeCode='" + collegeCode + "'";

        }
        if (majorCode != null && StringUtils.isNotEmpty(majorCode))
        {
            hql += " and majorCode='" + majorCode + "'";
        }
        if (classCode != null && StringUtils.isNotEmpty(classCode))
        {
            hql += " and classCode='" + classCode + "'";
        }
        if (studentNo != null && StringUtils.isNotEmpty(studentNo))
        {
            studentNo = studentNo.trim();
            hql += " and studentNo='" + studentNo + "'";
        }
        if (name != null && StringUtils.isNotEmpty(name))
        {
            name = name.trim();
            hql += " and name='" + name + "'";
        }
        if (IDcard != null && StringUtils.isNotEmpty(IDcard))
        {
            IDcard = IDcard.trim();
            hql += " and IDcard='" + IDcard + "'";
        }
        if (period != null && StringUtils.isNotEmpty(period))
        {
            hql += " and period<'" + period + "'";
        }
        if (examineeNo != null && StringUtils.isNotEmpty(examineeNo))
        {
            examineeNo = examineeNo.trim();
            hql += " and examineeNo='" + examineeNo + "'";
        }
        if (inDate != null)
        {
            hql += " and inDate='" + inDate + "'";
        }
        if (finishDate != null)
        {
            hql += " and finishDate='" + finishDate + "'";
        }

        return super.countHqlResult(hql);
    }

    /**
     * 
     * 取得最大序号
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param majorCode
     *            所在专业
     * @return
     */
    public int getMaxNumber(String majorCode)
    {
        String hql = "select max(orderNum) from Student where majorCode=?";
        return super.findUnique(hql, majorCode);
    }

    /**
     * 
     * 判断学生是否存在
     * 
     * @since 2010-12-9
     * @author shanru.wu
     * @return
     */
    public boolean exist(String examineeNo)
    {
        long res = super.countHqlResult("from Student where examineeNo=?",
                examineeNo);
        return res > 0 ? true : false;
    }

    private static final String GETBYIDCARD_EXAMINEENO = "from Student  where examineeNo=?";

    /**
     * 根据考生号取得学员
     * 
     * @since 2010-12-16
     * @author wsr
     * @param IDcard
     * @return
     */
    public Student getByExamineeNo(String examineeNo)
    {
        return super.findUnique(GETBYIDCARD_EXAMINEENO, examineeNo);
    }

    /**
     * 
     * 根据条件查询学生
     * 
     * @since 2011-4-19
     * @author yong.geng
     * @param collegeCode
     * @param majorCode
     * @param clazzCodeString
     * @return
     */
    public List<Student> getBatchStu(String collegeCode, String majorCode,
            String clazzCodeString)
    {
        String hql = "from Student student where ";
        if (collegeCode != null && StringUtils.isNotEmpty(collegeCode))
        {
            hql += " student.collegeCode='" + collegeCode + "' ";
        }
        if (majorCode != null && StringUtils.isNotEmpty(majorCode))
        {
            hql += "and student.majorCode='" + majorCode + "' ";
        }
        if (0 != clazzCodeString.length())
        {
            hql += "and student.classCode in (" + clazzCodeString + ")";
        }

        return super.find(hql);
    }

}
