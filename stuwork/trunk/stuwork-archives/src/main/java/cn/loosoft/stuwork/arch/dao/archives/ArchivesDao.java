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
package cn.loosoft.stuwork.arch.dao.archives;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.util.BaseDao;
import cn.loosoft.stuwork.arch.vo.CountVO;

/**
 * 
 * 档案的泛型DAO.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-17
 */
@Component
public class ArchivesDao extends HibernateDao<Archives, Long>
{

    /**
     * 
     * 查询状态为在库和调阅的总记录数
     * 
     * @since 2011-1-16
     * @author shanru.wu
     * @param status
     * @return
     */
    public long countArchives(String stuId, String name)
    {
        String hql = "from Archives where status!='调出'";
        if (stuId != null && StringUtils.isNotEmpty(stuId))
        {
            stuId = stuId.trim();
            hql += " and stuId='" + stuId + "'";
        }
        if (name != null && StringUtils.isNotEmpty(name))
        {
            name = name.trim();
            hql += " and name='" + name + "'";
        }
        return super.countHqlResult(hql);
    }

    /**
     * 院系统计
     */
    public List<CountVO> collegeCount()
    {
        BaseDao baseDao = new BaseDao();
        String sql = "select A.collegeName, A.status,A.amountA,B.amountB from (select inst.name as collegeName,arch.status as status,count(*) as amountA  from stuwork_stuinfo.student as stu  left join stuwork_backmanage.bm_institute as inst on stu.collegeCode = inst.code left join stuwork_archives.archives as arch on stu.studentNo = arch.stuId group by collegeName,status) as A left join (select inst.name as collegeName,count(*) as amountB from stuwork_stuinfo.student as stu left join stuwork_backmanage.bm_institute as inst on stu.collegeCode = inst.code group by collegeName) as B on A.collegeName = B.collegeName";
        return baseDao.collegeCount(sql);
    }

    /**
     * 专业统计
     */
    public List<CountVO> majorCount()
    {
        BaseDao baseDao = new BaseDao();
        String sql = "select B.collegeName,B.majorName,C.status,C.amount,B.total from (select A.collegeName ,A.majorName,count(student.collegeName and student.majorName) as total from(select institute.name as collegeName,specialty.name as majorName from stuwork_backmanage.bm_specialty as specialty left join stuwork_backmanage.bm_institute as institute on specialty.instituteID=institute.id) as A left join stuwork_stuinfo.student as student on student.collegeName=A.collegeName and student.majorName=A.majorName group by A.collegeName,A.majorName)as B  left join (select student.collegeName,student.majorName,archives.status, count(*)  as amount from stuwork_stuinfo.student as student left join stuwork_archives.archives as archives on archives.stuId=student.studentNo group by student.collegeName,student.majorName,archives.status) as C  on B.collegeName=C.collegeName and B.majorName=C.majorName group by B.collegeName,B.majorName,C.status";
        return baseDao.majorCount(sql);
    }

    /**
     * 班级统计
     */
    public List<CountVO> classCount()
    {
        BaseDao baseDao = new BaseDao();
        String sql = "select B.collegeName,B.majorName,B.className,C.status,C.amount,B.total from (select A.collegeCode,A.collegeName ,A.majorCode,A.majorName,A.classCode,A.className,count(student.collegeCode and student.majorCode and student.classCode) as total from(select institute.code as collegeCode, institute.name as collegeName,specialty.code as majorCode,specialty.name as majorName,class.code as classCode,class.name as className from stuwork_backmanage.bm_specialty as specialty left join stuwork_backmanage.bm_institute as institute on specialty.instituteID=institute.id right join stuwork_backmanage.bm_class as class on class. specialtyID=specialty.id) as A left join stuwork_stuinfo.student as student on student.collegeCode=A.collegeCode and student.majorCode=A.majorCode and student.classCode=A.classCode group by A.collegeCode,A.majorCode,A.classCode)as B  left join (select student.collegeCode,student.collegeName,student.majorCode,student.majorName,student.className,student.classCode,archives.status, count(*)  as amount from stuwork_stuinfo.student as student left join stuwork_archives.archives as archives on archives.stuId=student.studentNo group by student.collegeCode,student.majorCode,student.classCode,archives.status) as C  on B.collegeCode=C.collegeCode and B.majorCode=C.majorCode and B.classCode=C.classCode group by B.collegeCode,B.majorCode,B.classCode,C.status";
        return baseDao.classCount(sql);
    }

    /**
     * 
     * 获取状态为在库和调阅的学生
     * 
     * @since 2011-1-17
     * @author shanru.wu
     * @param stuId
     * @param name
     * @return
     */
    public Page<Archives> search(Page<Archives> page, String name,
            String stuId, String examineeNo)
    {
        String hql = "from Archives where status!='调出'";
        if (null != name && StringUtils.isNotEmpty(name))
        {
            name = name.trim();
            hql += " and name='" + name + "'";
        }
        if (null != stuId && StringUtils.isNotEmpty(stuId))
        {
            stuId = stuId.trim();
            hql += " and stuId='" + stuId + "'";
        }
        if (null != examineeNo && StringUtils.isNotEmpty(examineeNo))
        {
            stuId = stuId.trim();
            hql += " and examineeNo='" + examineeNo + "'";
        }

        return super.findPage(page, hql);
    }

}
