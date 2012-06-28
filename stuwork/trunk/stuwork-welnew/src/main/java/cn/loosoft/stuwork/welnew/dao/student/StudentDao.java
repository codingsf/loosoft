//-------------------------------------------------------------------------
// Copyright (c) 2009-2012 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
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
package cn.loosoft.stuwork.welnew.dao.student;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.student.Student;

/**
 * 
 * 学生的泛型DAO.
 * 
 * @author shanru.wu
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-23
 */
@Component
public class StudentDao extends HibernateDao<Student, Long>
{
    private static final String DELETE_STUDENT                 = "delete from Student where id in(:ids)";

    private static final String GETBYIDCARDNO                  = "from Student where IDcard=? and welbatch=?";

    private static final String GETBYTESTNO                    = "from Student where examineeNo=? and welbatch=?";

    private static final String SEARCH_STUDENT                 = "from Student where 1=1 ";

    private static final String RESIDENCE_STUDENT              = "from Student where IDcard=? and name=?";

    private static final String MAJORCLAZZINFO_STUDENT         = "from Student where examineeNo=? and name=?";

    private static final String GETBYEXAMINEENO                = "from Student where examineeNo=?";

    private static final String GETBYNOTICEID_STUDENT          = "from Student  where noticeId=?";

    private static final String GETBYIDCARD_STUDNET            = "from Student  where IDcard=?";

    private static final String GETBYIDCARDANDNOTICEID_STUDNET = "from Student  where IDcard=? and noticeId=?";

    private static final String GETSTUDENTBYMAJOR              = "from Student where majorCode=? and welbatch=? and type=?";

    private static final String GETREPORTGROUPBYCOLLEGENAME    = "from Student where welbatch =? group by collegeName";

    private static final String GETREPORTGROUBYWELBATCH        = "from Student where welbatch =? group by majorName";

    private static final String GETREPORTGROUPBYMAJORNAME      = "from Student where welbatch =? and collegeName=? group by majorName";

    /**
     * 
     * 根据院系、专业、班级查询.
     * 
     * @since 2010-12-27
     * @author jie.yang
     * @param
     */
    public List<Student> getStudentList(String collegeCode, String majorCode,
            String classCode)
    {
        String hql = " from Student where 1=1";
        if (collegeCode != "" && collegeCode != null)
        {
            hql += "  and collegeCode='" + collegeCode + "'";
        }
        if (majorCode != "" && majorCode != null)
        {
            hql += " and majorCode='" + majorCode + "'";
        }
        if (classCode != "" && classCode != null)
        {
            hql += " and classCode='" + classCode + "'";
        }

        return super.find(hql);

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
            System.out.println("保存学员信息失败");
        }
    }

    /**
     * 批量删除迎新学员.
     */
    public void deleteStudents(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STUDENT, map);
    }

    /**
     * 
     * 根据考生号和批次取得学员
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @param testNo
     * @param batch
     * @return
     */
    public Student getByExamineeNo(String examineeNo, Welbatch batch)
    {
        return super.findUnique(GETBYTESTNO, examineeNo, batch);
    }

    /**
     * 
     * 根据考生号取得学员
     * 
     * @since 2010-1-24
     * @author shanru.wu
     * @param examineeNo
     * @return
     */
    public Student getByExamineeNo(String examineeNo)
    {
        return super.findUnique(GETBYEXAMINEENO, examineeNo);
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
     * 根据身份证号和姓名取得学员 Description of this Method
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
     * @author wsr
     * @param notcieId
     * @return
     */
    public Student getByNoticeId(String noticeId)
    {
        return super.findUnique(GETBYNOTICEID_STUDENT, noticeId);
    }

    /**
     * 根据省份证号取得学员
     * 
     * @since 2010-12-6
     * @author wsr
     * @param IDcard
     * @return
     */
    public Student getByIDcard(String IDcard)
    {
        return super.findUnique(GETBYIDCARD_STUDNET, IDcard);
    }

    /**
     * 
     * 根据通知书编号和身份证取得学员
     * 
     * @since 2011-4-28
     * @author yong.geng
     * @param noticeId
     * @param IDcard
     * @return
     */
    public Student getByNoticeIdAndIDcard(String noticeId, String IDcard)
    {
        return super.findUnique(GETBYIDCARDANDNOTICEID_STUDNET, IDcard,
                noticeId);
    }

    /**
     * 
     * 根据身份证号和批次取得学员
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @param idCardNo
     * @param batch
     * @return
     */
    public Student getByIdCardNo(String idCardNo, Welbatch batch)
    {
        return super.findUnique(GETBYIDCARDNO, idCardNo, batch);
    }

    /**
     * 根据传递的参数进行查询学员 Description of this Method
     * 
     * @since 2010-8-23
     * @author wxd
     * @param page
     * @param student
     * @return 分页学员对象
     */
    public Page<Student> getStudents(Page<Student> page, Student student)
    {
        String hql = SEARCH_STUDENT;
        Map<String, Object> values = new HashMap<String, Object>();
        if (null != student)
        {
            if (null != student.getWelbatch()
                    && (StringUtils.isNotEmpty(student.getWelbatch().getYear())))
            {
                values.put("year", student.getWelbatch().getYear());
            }

            if (StringUtils.isNotEmpty(student.getCollegeCode()))
            {
                values.put("institutecode", student.getCollegeCode());

            }

            values.put("isReged", student.isReged());

        }
        return this.findPage(page, hql, values);
    }

    /**
     * 
     * 按照成绩降序，取得专业下的所有学生新生
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @author shanru.wu
     * @param majorCode
     * @return
     */
    public List<Student> getStudents(String majorCode, Welbatch welbatch,
            String type, String orderBy, String order)
    {
        String hql = GETSTUDENTBYMAJOR + " order by " + orderBy + " " + order;
        return super.find(hql, majorCode, welbatch, type);
    }

    /**
     * 
     * Description of this Method
     * 
     * @since 2010-8-29
     * @author houbing.qian
     * @param majorCode
     * @param type
     * @param welbatch
     * @return
     */
    public long countStudent(String majorCode, String type, Welbatch welbatch)
    {
        return super.countHqlResult(
                "from Student where majorCode=? and type=? and welbatch=?",
                majorCode, type, welbatch);
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
     * 根据参数计算学生总数
     * 
     * @since 2010-9-30
     * @author fangyong
     * @param collegeCode
     *            学院代码 传null表示不区分
     * @param welbatch
     *            批次
     * @param isReged
     *            是否注册 传null表示不区分
     * @return
     */
    public long countStudent(String collegeCode, Welbatch welbatch,
            Boolean isReged)
    {
        Assert.notNull(welbatch);
        String hql = "";
        if (StringUtils.isEmpty(collegeCode))
        {
            if (isReged == null)
            {
                hql = "from Student where welbatch=?";
                return countHqlResult(hql, welbatch);
            }
            else
            {
                hql = "from Student where welbatch=? and reged=?";
                return countHqlResult(hql, welbatch, isReged);
            }
        }
        else
        {
            if (isReged == null)
            {
                hql = "from Student where collegeCode=? and welbatch=?";
                return countHqlResult(hql, collegeCode, welbatch);
            }
            else
            {
                hql = "from Student where collegeCode=? and welbatch=? and reged=?";
                return countHqlResult(hql, collegeCode, welbatch, isReged);
            }
        }
    }

    /**
     * 
     * 根据参数计算学生总数
     * 
     * @since 2010-9-30
     * @author fangyong
     * @param majorCode
     *            专业代码 传null表示不区分
     * @param welbatch
     *            批次
     * @param isReged
     *            是否注册 传null表示不区分
     * @return
     */
    public long countStudentByMajorCode(String collegeCode, String majorCode,
            Welbatch welbatch, Boolean isReged)
    {
        Assert.notNull(welbatch);
        Assert.notNull(collegeCode);
        Assert.notNull(majorCode);
        String hql = "";
        if (isReged == null)
        {
            hql = "from Student where collegeCode=? and majorCode=? and welbatch=?";
            return countHqlResult(hql, collegeCode, majorCode, welbatch);
        }
        else
        {
            hql = "from Student where collegeCode=? and majorCode=? and welbatch=? and reged=?";
            return countHqlResult(hql, collegeCode, majorCode, welbatch,
                    isReged);
        }
    }

    /**
     * 
     * 新生入学报到统计
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     *            批次
     * @return
     */
    public List<Student> getGroupStudentsByCollege(Welbatch welbatch)
    {
        return super.find(GETREPORTGROUPBYCOLLEGENAME, welbatch);
    }

    /**
     * 
     * 新生入学报到统计
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     *            批次
     * @return
     */
    public List<Student> getGroupStudentsByMajor(Welbatch welbatch)
    {
        return super.find(GETREPORTGROUBYWELBATCH, welbatch);
    }

    /**
     * 
     * 新生入学报到统计
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     *            批次
     * @return
     */
    public List<Student> getGroupStudentsByMajor(Welbatch welbatch,
            String collegeName)
    {
        return super.find(GETREPORTGROUPBYMAJORNAME, welbatch, collegeName);
    }

    public long countChechPassStudent(String collegeCode, Welbatch welbatch)
    {
        Assert.notNull(welbatch);
        String hql = "";
        if (StringUtils.isEmpty(collegeCode))
        {
            hql = "from Student where welbatch = ? and reged = true and checkPass = true";
            return countHqlResult(hql, welbatch);
        }
        else
        {
            hql = "from Student where collegeCode = ? and welbatch = ? and reged = true and checkPass = true";
            return countHqlResult(hql, collegeCode, welbatch);
        }
    }
}
