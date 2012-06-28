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
package cn.loosoft.stuwork.stuinfo.service.student;

import java.io.File;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.common.lib.util.date.DateUtils;
import cn.common.lib.util.file.FileUtils;
import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.user.UserWebService;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.common.Education;
import cn.loosoft.stuwork.common.Grade;
import cn.loosoft.stuwork.common.Marriage;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.common.PoliticsFace;
import cn.loosoft.stuwork.stuinfo.dao.student.StudentDao;
import cn.loosoft.stuwork.stuinfo.entity.batch.Batch;
import cn.loosoft.stuwork.stuinfo.entity.student.Student;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;
import cn.loosoft.stuwork.stuinfo.util.ExcelUtils;
import cn.loosoft.stuwork.stuinfo.vo.ImportStudentNOVO;
import cn.loosoft.stuwork.stuinfo.vo.SpecialCountVO;

import com.google.common.collect.Lists;

/**
 * 学生实体的管理类.
 * 
 * @author shanru.wu
 * @since 2010-12-12
 * @version 1.0
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StudentManager extends EntityManager<Student, Long>
{

    private StudentDao          studentDao;

    UserWebService              userWebService;

    private InstituteWebService instituteWebService;

    private SpecialtyWebService specialtyWebService;

    private ClazzWebService     clazzWebService;

    private BatchManager        batchManager;

    /**
     * 批量软删除学生.
     */
    public void deletes(List<Long> ids)
    {
        studentDao.deleteStudents(ids);
    }

    public boolean isPropertyUnique(String examineeNo)
    {
        return studentDao.isPropertyUnique("examineeNo", examineeNo, "");
    }

    public List<Student> findStudents(String studentNo, String name,
            String IDcard, String examineeNo, String sex, String collegeCode,
            String majorCode, String classCode, String comname,
            String isInSchool)
    {

        String hql = "from Student where deleted='false'";
        String userName = SpringSecurityUtils.getCurrentUserName();
        UserDTO userDTO = userWebService.getUser(userName);
        if (StringUtils.isNotEmpty(userDTO.getClassCode()))
        {
            hql += " and classCode in (" + userDTO.getClassCode() + ")";
        }
        if (null != userDTO.getMajorCode()
                && StringUtils.isNotEmpty(userDTO.getMajorCode()))
        {
            hql += " and majorCode='" + userDTO.getMajorCode() + "'";
        }
        if (null != userDTO.getCollegeCode()
                && StringUtils.isNotEmpty(userDTO.getCollegeCode()))
        {
            hql += " and collegeCode='" + userDTO.getCollegeCode() + "'";
        }
        if (null != studentNo && StringUtils.isNotEmpty(studentNo))
        {
            hql += " and studentNo='" + studentNo + "'";
        }
        if (null != examineeNo && StringUtils.isNotEmpty(examineeNo))
        {
            hql += " and examineeNo='" + examineeNo + "'";
        }
        if (null != name && StringUtils.isNotEmpty(name))
        {
            hql += " and name='" + name + "'";
        }
        if (null != sex && StringUtils.isNotEmpty(sex))
        {
            hql += " and sex='" + sex + "'";
        }
        if (null != IDcard && StringUtils.isNotEmpty(IDcard))
        {
            hql += " and IDcard='" + IDcard + "'";
        }
        if (null != collegeCode && StringUtils.isNotEmpty(collegeCode))
        {
            hql += " and collegeCode='" + collegeCode + "'";
        }
        if (null != majorCode && StringUtils.isNotEmpty(majorCode))
        {
            hql += " and majorCode='" + majorCode + "'";
        }
        if (null != classCode && StringUtils.isNotEmpty(classCode))
        {
            hql += " and classCode='" + classCode + "'";
        }
        if (null != isInSchool && StringUtils.isNotEmpty(isInSchool))
        {
            hql += " and inSchool='" + isInSchool + "'";
        }

        if (null != comname && StringUtils.isNotEmpty(comname))
        {
            String[] com = comname.split("-");
            String year = com[0];
            String season = com[1];
            hql += " and year='" + year + "' and season='" + season + "'";
        }

        return studentDao.find(hql);
    }

    public Page<Student> search(Page<Student> page, String studentNo,
            String name, String IDcard, String examineeNo, String sex,
            String collegeCode, String majorCode, String classCode,
            String comname, String isInSchool)
    {

        String hql = "from Student where deleted='false'";
        String userName = SpringSecurityUtils.getCurrentUserName();
        UserDTO userDTO = userWebService.getUser(userName);
        if (StringUtils.isNotEmpty(userDTO.getClassCode()))
        {
            hql += " and classCode in (" + userDTO.getClassCode() + ")";
        }
        if (null != userDTO.getMajorCode()
                && StringUtils.isNotEmpty(userDTO.getMajorCode()))
        {
            hql += " and majorCode='" + userDTO.getMajorCode() + "'";
        }
        if (null != userDTO.getCollegeCode()
                && StringUtils.isNotEmpty(userDTO.getCollegeCode()))
        {
            hql += " and collegeCode='" + userDTO.getCollegeCode() + "'";
        }
        if (null != studentNo && StringUtils.isNotEmpty(studentNo))
        {
            hql += " and studentNo='" + studentNo + "'";
        }
        if (null != examineeNo && StringUtils.isNotEmpty(examineeNo))
        {
            hql += " and examineeNo='" + examineeNo + "'";
        }
        if (null != name && StringUtils.isNotEmpty(name))
        {
            hql += " and name='" + name + "'";
        }
        if (null != sex && StringUtils.isNotEmpty(sex))
        {
            hql += " and sex='" + sex + "'";
        }
        if (null != IDcard && StringUtils.isNotEmpty(IDcard))
        {
            hql += " and IDcard='" + IDcard + "'";
        }
        if (null != collegeCode && StringUtils.isNotEmpty(collegeCode))
        {
            hql += " and collegeCode='" + collegeCode + "'";
        }
        if (null != majorCode && StringUtils.isNotEmpty(majorCode))
        {
            hql += " and majorCode='" + majorCode + "'";
        }
        if (null != classCode && StringUtils.isNotEmpty(classCode))
        {
            hql += " and classCode='" + classCode + "'";
        }
        if (null != comname && StringUtils.isNotEmpty(comname))
        {
            String[] com = comname.split("-");
            String year = com[0];
            String season = com[1];
            hql += " and year='" + year + "' and season='" + season + "'";
        }

        if (null != isInSchool && StringUtils.isNotEmpty(isInSchool))
        {
            hql += " and inSchool='" + isInSchool + "'";
        }

        return studentDao.findPage(page, hql);
    }

    /**
     * 
     * 获取学生总记录数
     * 
     * @since 2011-1-16
     * @author shanru.wu
     * @return
     */
    public long countStudent(String collegeCode, String majorCode,
            String classCode, String studentNo, String name, String IDcard,
            String period, String examineeNo, String inDate, String finishDate)
    {
        return studentDao
                .countStudent(collegeCode, majorCode, classCode, studentNo,
                        name, IDcard, period, examineeNo, inDate, finishDate);
    }

    /**
     * 
     * 根据考生号查询
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @param examineeNo
     * @param batch
     * @return
     */
    public Student getByExamineeNo(String ExamineeNo)
    {
        return studentDao.getByExamineeNo(ExamineeNo);
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
        return studentDao.getByNoticeId(noticeId);
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
        return studentDao.getByIDcard(IDcard);
    }

    /**
     * 根据学号号取得学员
     * 
     * @since 2010-12-6
     * @author shanru.wu
     * @param IDcard
     * @return
     */
    public Student getByStudentNo(String studentNo)
    {
        return studentDao.getByStudentNo(studentNo);
    }

    /**
     * 
     * 固定获取前N(10,15,20)条学号
     * 
     * @since 2010-11-24
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
        return studentDao.getStudentNosByCondition(collegeCode, majorCode,
                classCode, studentNo, name, IDcard, period, examineeNo, inDate,
                finishDate, pageNo, pageSize);
    }

    /**
     * 
     * 根据查询条件批量获取学号
     * 
     * @since 2010-11-24
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
            String finishDate)
    {
        return studentDao.getStudentNosCondition(collegeCode, majorCode,
                classCode, studentNo, name, IDcard, period, examineeNo, inDate,
                finishDate);
    }

    /**
     * 
     * 保存资讯的附件
     * 
     * @since 2010-11-24
     * @author fangyong
     * @param picfile
     * @param picfileFileName
     * @param article
     */
    public void saveAttachment(File picfile, String picfileFileName,
            Student student)
    {

        try
        {
            // 获得当前年月
            String date = DateFormatUtils.format(new Date(), "yyyyMM");

            // 设置文件路径，优先存储在本地，如本地存储失败，则存储至服务器路径上
            String localFilePath = PropertyUtils
                    .getProperty("news.attachment.file.path", RequestUtils
                            .getRealPath(ServletActionContext
                                    .getServletContext(), "stuImg"));
            // 重新设置文件路径，以当前年月作为存储目录
            localFilePath = localFilePath + "\\" + date;

            // 存储文件，获得存储后的文件名
            String filename = FileUtils.saveFile(localFilePath, picfile,
                    picfileFileName, "att");// 前缀

            InetAddress inetAddress = InetAddress.getLocalHost();

            // 保存
            // student.setImg("../" + "stuImg" + "/" + date + "/" + filename);
            student.setImg("http://" + inetAddress.getHostAddress()
                    + ":8080/stuwork-stuinfo" + "/" + "stuImg" + "/" + date
                    + "/" + filename);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 
     * 从Excel表格中批量导入新生信息
     * 
     * @param file
     * @param dstPath
     * @param type
     * @author shanru.wu
     * @since 2010-12-16
     * @return
     */
    public List<String> importstudent(File file, String dstPath,
            List<Student> errorInfo, List<String> errorList, boolean isTest)
    {
        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);
        List<String> keyList = new ArrayList<String>();

        SimpleDateFormat sdf = new SimpleDateFormat(
                "EEE MMM dd HH:mm:ss z yyyy", Locale.US);
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");

        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, false);
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }
        if (filetype.equalsIgnoreCase("xls"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, true);
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }
        Student student;

        List<String> result = new ArrayList<String>();
        int total = 0;
        int fail = 0;
        String failstr = "";
        if (null != datas && datas.size() > 1)
        {
            total = datas.size() - 1;
            for (int i = 1; i < datas.size(); i++)
            {
                try
                {
                    Map<String, String> data = datas.get(i);
                    student = new Student();
                    String examineeNo = "";
                    String className = ""; // 班级
                    String classCode = "";// 班级代码
                    String majorCode = "";// 专业代码
                    String collegeCode = ""; // 学院代码
                    String majorName = ""; // 专业
                    String collegeName = ""; // 学院
                    String birthday = "";
                    String inDate = "";
                    String finishDate = "";
                    for (int j = 0; j < keyList.size(); j++)
                    {

                        String key = keyList.get(j);
                        if (null == key || StringUtils.isEmpty(key))
                        {
                            continue;
                        }
                        student.setPassword(Student.DEFAULTPWD);

                        if (key.equals("学号"))
                        {
                            student.setStudentNo(data.get(key));// 学号
                            continue;
                        }
                        if (key.equals("姓名"))
                        {
                            student.setName(data.get(key));// 姓名
                            continue;
                        }
                        if (key.equals("性别"))
                        {
                            String sexdesc = data.get(key);
                            if ("男".equals(sexdesc))
                            {
                                student.setSex("m");// 性别
                            }
                            else
                                if ("女".equals(sexdesc))
                                {
                                    student.setSex("f");// 性别
                                }
                                else
                                {
                                    student.setSex(sexdesc);
                                }
                            continue;
                        }
                        if (key.equals("考生号"))
                        {
                            examineeNo = data.get(key);
                            student.setExamineeNo(examineeNo);// 考生号
                            continue;
                        }
                        if (key.equals("身份证号"))
                        {
                            student.setIDcard(data.get(key));// 身份证号
                            continue;
                        }
                        if (key.equals("姓名拼音"))
                        {
                            student.setPinyin(data.get(key));// 姓名拼音

                            continue;
                        }
                        if (key.equals("出生日期"))
                        {
                            birthday = data.get(key);
                            if (StringUtils.isNotEmpty(birthday))
                            {
                                if (birthday.contains("-"))
                                {
                                    student.setBirthday(DateUtils.getDate(
                                            birthday, "yyyy-MM-dd"));
                                }
                                else
                                {
                                    Date birthdayTemp = sdf.parse(birthday);
                                    String birthdayString = sd
                                            .format(birthdayTemp);
                                    student.setBirthday(DateUtils.getDate(
                                            birthdayString, "yyyy-MM-dd"));
                                }
                            }
                            else
                            {
                                student.setBirthday(null);
                            }

                            continue;
                        }
                        if (key.equals("曾用名"))
                        {
                            student.setFormer(data.get(key));// 曾用名
                            continue;
                        }
                        if (key.equals("入学前户口"))
                        {
                            student.setAccount(data.get(key));// 入学前户口
                            continue;
                        }
                        if (key.equals("寝室信息"))
                        {
                            student.setRoombed(data.get(key));// 寝室信息
                            continue;
                        }
                        if (key.equals("学院"))
                        {
                            collegeName = data.get(key);
                            collegeName = collegeName.replaceAll(" ", " ")
                                    .trim();
                            student.setCollegeName(collegeName);// 学院
                            collegeCode = instituteWebService
                                    .getInstituteCode(student.getCollegeName());
                            student.setCollegeCode(collegeCode);
                            continue;
                        }

                        if (key.equals("专业"))
                        {
                            majorName = data.get(key);
                            majorName = majorName.replaceAll(" ", " ").trim();
                            student.setMajorName(majorName);// 专业
                            majorCode = specialtyWebService
                                    .getSpecialtyCode(student.getMajorName());
                            student.setMajorCode(majorCode);
                            continue;
                        }
                        if (key.equals("班级"))

                        {
                            className = data.get(key);
                            className = className.replaceAll(" ", " ").trim();
                            student.setClassName(className);// 班级
                            continue;
                        }
                        if (key.equals("班主任"))
                        {
                            student.setHeadTeacher(data.get(key));// 班主任
                            continue;
                        }
                        if (key.equals("班主任电话"))
                        {
                            student.setHeadTeacherPhone(data.get(key));// 班主任电话
                            continue;
                        }
                        if (key.equals("辅导员"))
                        {
                            student.setCounselor(data.get(key));// 辅导员
                            continue;
                        }
                        if (key.equals("辅导员电话"))
                        {

                            student.setCounselorPhone(data.get(key));// 辅导员电话
                            continue;
                        }

                        if (key.equals("培养方式"))
                        {
                            String type = "";
                            if ("统招".equals((String) data.get(key)))
                            {
                                type = "tz";
                            }
                            else
                                if ("对口".equals((String) data.get(key)))
                                {
                                    type = "dk";
                                }
                                else
                                    if (("专升本").equals((String) data.get(key)))
                                    {
                                        type = "zsb";
                                    }
                            student.setType(type);
                            continue;
                        }

                        if (key.equals("学制"))
                        {
                        	String g = String.valueOf(data.get(key));
                        	if(g.indexOf(".")>-1){
                        		g = g.substring(0,g.indexOf("."));
                        	}
                            student.setLength(g);// 学制
                            continue;
                        }
                        if (key.equals("籍贯"))
                        {
                            student.setBirthPlace(data.get(key));// 学制
                            continue;
                        }

                        if (key.equals("民族"))
                        {
                            String nation = Nation.getValue(data.get(key));
                            student.setNation(nation); // 民族
                            continue;
                        }
                        if (key.equals("政治面貌"))
                        {
                            String politicsFace = PoliticsFace.getValue(data
                                    .get(key));
                            student.setPoliticsFace(politicsFace); // 政治面貌
                            continue;
                        }
                        if (key.equals("学历"))
                        {
                            String education = Education
                                    .getValue(data.get(key));
                            student.setEducation(education); // 学历
                            continue;
                        }
                        if (key.equals("学位"))
                        {
                            student.setDegree(data.get(key)); // 学位
                            continue;
                        }
                        if (key.equals("入学时间"))
                        {
                            inDate = data.get(key);
                            if (StringUtils.isNotEmpty(inDate))
                            {
                                if (inDate.contains("-"))
                                {
                                    student.setInDate(DateUtils.getDate(inDate,
                                            "yyyy-MM-dd"));
                                }
                                else
                                {
                                    Date inDateTemp = sdf.parse(inDate);

                                    String inDateString = sd.format(inDateTemp);
                                    student.setInDate(DateUtils.getDate(
                                            inDateString, "yyyy-MM-dd"));
                                }
                            }
                            else
                            {
                                student.setInDate(null);
                            }
                            continue;
                        }
                        if (key.equals("毕业时间"))
                        {
                            finishDate = data.get(key);
                            if (StringUtils.isNotEmpty(finishDate))
                            {
                                if (finishDate.contains("-"))
                                {
                                    student.setFinishDate(DateUtils.getDate(
                                            finishDate, "yyyy-MM-dd"));
                                }
                                else
                                {
                                    Date finishDateTemp = sdf.parse(finishDate);
                                    String finishDateString = sd
                                            .format(finishDateTemp);
                                    student.setFinishDate(DateUtils.getDate(
                                            finishDateString, "yyyy-MM-dd"));
                                }
                            }
                            else
                            {
                                student.setFinishDate(null);
                            }

                            continue;
                        }
                        if (key.equals("研究方向导师"))
                        {
                            student.setHierophant(data.get(key)); // 研究方向导师
                            continue;
                        }
                        if (key.equals("一卡通号"))
                        {
                            student.setCardNum(data.get(key)); // 一卡通号
                            continue;
                        }
                        if (key.equals("教育方向"))
                        {
                            student.setEdudirection(data.get(key)); // 教育方向
                            continue;
                        }
                        if (key.equals("父亲姓名"))
                        {
                            student.setFatherName(data.get(key)); // 父亲姓名
                            continue;
                        }
                        if (key.equals("母亲姓名"))
                        {
                            student.setMotherName(data.get(key)); // 母亲姓名
                            continue;
                        }
                        if (key.equals("家庭邮编"))
                        {
                            student.setFamilyCode(data.get(key)); // 家庭邮编
                            continue;
                        }
                        if (key.equals("家庭电话"))
                        {
                            student.setHomePhone(data.get(key)); // 家庭电话
                            continue;
                        }
                        if (key.equals("血型"))
                        {
                            student.setBlood(data.get(key)); // 血型
                            continue;
                        }
                        if (key.equals("健康状况"))
                        {
                            student.setHealthInfo(data.get(key)); // 健康状况
                            continue;
                        }
                        if (key.equals("婚姻状况"))
                        {
                            String marryInfo = Marriage.getValue(data.get(key));
                            student.setMarryInfo(marryInfo); // 婚姻状况
                            continue;
                        }
                        if (key.equals("心理状况"))
                        {
                            student.setPsyInfo(data.get(key)); // 心理状况
                            continue;
                        }
                        if (key.equals("国别"))
                        {
                            student.setCountry(data.get(key)); // 国别
                            continue;
                        }
                        if (key.equals("宗教信仰"))
                        {
                            student.setReligion(data.get(key)); // 宗教信仰
                            continue;
                        }
                        if (key.equals("银行名称"))
                        {
                            student.setBankName(data.get(key)); // 银行名称
                            continue;
                        }
                        if (key.equals("银行账户"))
                        {
                            student.setBankAccount(data.get(key)); // 银行账户
                            continue;
                        }
                        if (key.equals("个人主页"))
                        {
                            student.setOnlineWeb(data.get(key)); // 个人主页
                            continue;
                        }
                        if (key.equals("邮箱"))
                        {
                            student.setEmail(data.get(key)); // 邮箱
                            continue;
                        }
                        if (key.equals("特长"))
                        {
                            student.setSpecialty(data.get(key)); // 特长
                            continue;
                        }
                        if (key.equals("备注"))
                        {
                            student.setRemarks(data.get(key)); // 备注
                            continue;
                        }
                        if (key.equals("是否毕业"))
                        {
                            student
                                    .setGraduated("是".equals(data.get(key)) ? true
                                            : false);
                            continue;
                        }
                        if (key.equals("是否在校"))
                        {

                            student
                                    .setInSchool("是".equals(data.get(key)) ? true
                                            : false);
                            continue;
                        }
                        if (key.equals("是否注册"))
                        {

                            student.setReged("是".equals(data.get(key)) ? true
                                    : false);
                            continue;
                        }
                        if (key.equals("毕业中学"))
                        {
                            student.setGraduateSchool(data.get(key)); // 毕业中学
                            continue;
                        }
                        if (key.equals("届数"))
                        {
                            student.setPeriod(data.get(key));
                            continue;
                        }
                        if (key.equals("是否属于港澳台"))
                        {
                            boolean isAutonomy = data.get(key) == ""
                                    || data.get(key) == null ? false : true;
                            student.setAutonomy(isAutonomy); // 是否属于港澳台
                            continue;
                        }
                        if (key.equals("家庭地址"))
                        {
                            student.setAddress(data.get(key));// 联系地址
                            continue;
                        }
                        if (key.equals("联系电话"))
                        {
                            student.setPhone(data.get(key));// 联系电话
                            continue;
                        }

                        if (key.equals("生源地"))
                        {
                            student.setTestaddr(data.get(key));// 生源地
                        }

                        if (key.equals("年级"))
                        {
                        	String g = String.valueOf(data.get(key));
                        	if(g.indexOf(".")>-1){
                        		g = g.substring(0,g.indexOf("."));
                        	}
                            student.setGrade(Integer.parseInt(g));// 年级
                        }
                    }

                    // BatchDTO batchDTO = batchWebService.getCurrentBatch();
                    Batch batch = batchManager.getCurrentBatch();
                    if (null != batch)
                    {
                        classCode = clazzWebService.getClazzCodeByName(
                                className, student.getType(), batch.getYear(),
                                batch.getSeason());
                        student.setClassCode(classCode);
                        student.setYear(batch.getYear());
                        student.setSeason(batch.getSeason());
                    }

                    // 判断学生是否已经导入
                    if (!studentDao.isPropertyUnique("examineeNo", examineeNo,
                            "")
                            || StringUtils.isEmpty(collegeCode)
                            || StringUtils.isEmpty(majorCode)
                            || StringUtils.isEmpty(classCode) || batch == null)
                    {
                        fail++;
                        if (i == 1)
                        {
                            failstr = failstr + i;
                        }
                        else
                        {
                            failstr = failstr + "," + i;
                        }
                    }
                    if (StringUtils.isEmpty(student.getName())
                            || StringUtils.isEmpty(student.getSex())
                            || StringUtils.isEmpty(student.getExamineeNo())
                            || StringUtils.isEmpty(student.getIDcard())
                            || null == student.getBirthday()
                            || StringUtils.isEmpty(student.getCollegeCode())
                            || StringUtils.isEmpty(student.getMajorCode())
                            || StringUtils.isEmpty(student.getLength())
                            || StringUtils.isEmpty(student.getEducation())
                            || null == student.getInDate()
                            || 0 == student.getGrade()
                            || StringUtils.isEmpty(student.getType()))
                    {
                        errorInfo.add(student);
                        errorList.add("此生所填写的必填项字段中存在空值,请预设");
                        continue;
                    }
                    if (batch == null)
                    {
                        errorInfo.add(student);
                        errorList.add("批次管理中,至少设置一个为当前批次");
                        continue;
                    }
                    if (!studentDao.isPropertyUnique("examineeNo", examineeNo,
                            ""))
                    {
                        errorInfo.add(student);
                        errorList.add("该生已存在");
                        continue;
                    }
                    if (StringUtils.isEmpty(collegeCode))
                    {
                        errorInfo.add(student);
                        errorList.add("此生所填写的学院在系统中不存在,请预设");
                        continue;
                    }
                    if (StringUtils.isEmpty(majorCode))
                    {
                        errorInfo.add(student);
                        errorList.add("此生所填写的专业在系统中不存在,请预设");
                        continue;
                    }
                    if (StringUtils.isEmpty(classCode))
                    {
                        errorInfo.add(student);
                        errorList.add("此生所填写的班级在系统中不存在或者无当前批次的班级,请预设");
                        continue;
                    }
                    if (StringUtils.isNotEmpty(birthday))
                    {
                        if (birthday.split("-").length != 3)
                        {
                            errorInfo.add(student);
                            errorList.add("此生所填写的出生日期格式不正确,应为yyyy-MM-dd");
                            fail++;
                            if (i == 1)
                            {
                                failstr = failstr + i;
                            }
                            else
                            {
                                failstr = failstr + "," + i;
                            }
                            continue;
                        }
                    }
                    if (StringUtils.isNotEmpty(inDate))
                    {
                        if (inDate.split("-").length != 3)
                        {
                            errorInfo.add(student);
                            errorList.add("此生所填写的入学时间格式不正确,应为yyyy-MM-dd");
                            fail++;
                            if (i == 1)
                            {
                                failstr = failstr + i;
                            }
                            else
                            {
                                failstr = failstr + "," + i;
                            }
                            continue;
                        }
                    }
                    if (StringUtils.isNotEmpty(finishDate))
                    {
                        if (finishDate.split("-").length != 3)
                        {
                            errorInfo.add(student);
                            errorList.add("此生所填写的毕业时间格式不正确,应为yyyy-MM-dd");
                            fail++;
                            if (i == 1)
                            {
                                failstr = failstr + i;
                            }
                            else
                            {
                                failstr = failstr + "," + i;
                            }
                            continue;
                        }
                    }
                    if (!(isTest))
                    {
                        this.studentDao.save(student);
                    }
                }
                catch (Exception e)
                {
                    e.printStackTrace();
                    fail++;
                    if (i == 1)
                    {
                        failstr = failstr + i;
                    }
                    else
                    {
                        failstr = failstr + "," + i;
                    }
                }
            }
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        result.add(failstr);
        return result;
    }

    /**
     * 
     * 从Excel表格中批量导入新生学号
     * 
     * @param file
     * @param dstPath
     * @param type
     * @author shanru.wu
     * @since 2010-12-16
     * @return
     */
    public List<String> importstudentNo(File file, String dstPath,
            List<ImportStudentNOVO> stuNoErrorInfo,
            List<String> stuNoErrorList, boolean isTest)
    {
        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);
        List<String> keyList = new ArrayList<String>();

        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, false);
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }
        if (filetype.equalsIgnoreCase("xls"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, true);
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }
        Student student;
        List<String> result = new ArrayList<String>();
        int total = 0;
        int fail = 0;
        String failstr = "";
        ImportStudentNOVO stuNOVO = null;
        if (null != datas && datas.size() > 1)
        {

            total = datas.size() - 1;
            for (int i = 1; i < datas.size(); i++)
            {
                try
                {
                    String name = StringUtils.isBlank((datas.get(i)).get("姓名")) ? ""
                            : (datas.get(i)).get("姓名");
                    String idCard = StringUtils.isBlank((datas.get(i))
                            .get("身份证号")) ? "" : (datas.get(i)).get("身份证号");
                    String exameeNo = StringUtils.isBlank((datas.get(i))
                            .get("考生号")) ? "" : (datas.get(i)).get("考生号");
                    String studentNo = StringUtils.isBlank((datas.get(i))
                            .get("学号")) ? "" : (datas.get(i)).get("学号");

                    // 判断考生号或学号非空
                    if (StringUtils.isEmpty(exameeNo)
                            || StringUtils.isEmpty(studentNo))
                    {
                        stuNOVO = new ImportStudentNOVO(name, idCard, exameeNo,
                                studentNo);
                        stuNoErrorInfo.add(stuNOVO);
                        stuNoErrorList.add("考生号或学号为空");
                        fail++;
                        if (i == 1)
                        {
                            failstr = failstr + i;
                        }
                        else
                        {
                            failstr = failstr + "," + i;
                        }
                        continue;
                    }

                    // 判断是否有该考生号的学生
                    student = studentDao.getByExamineeNo(exameeNo);
                    if (student == null)
                    {
                        stuNOVO = new ImportStudentNOVO(name, idCard, exameeNo,
                                studentNo);
                        stuNoErrorInfo.add(stuNOVO);
                        stuNoErrorList.add("不存在该考生号的学生");
                        fail++;
                        if (i == 1)
                        {
                            failstr = failstr + i;
                        }
                        else
                        {
                            failstr = failstr + "," + i;
                        }
                        continue;
                    }

                    // 判断导入的姓名与该考生号对应的姓名是否相同
                    if (StringUtils.isNotBlank(name))
                    {
                        if (!name.equals(student.getName()))
                        {
                            stuNOVO = new ImportStudentNOVO(name, idCard,
                                    exameeNo, studentNo);
                            stuNoErrorInfo.add(stuNOVO);
                            stuNoErrorList.add("导入的姓名与该考生号对应的姓名不相同");
                            fail++;
                            if (i == 1)
                            {
                                failstr = failstr + i;
                            }
                            else
                            {
                                failstr = failstr + "," + i;
                            }
                            continue;
                        }
                    }

                    // 判断导入的身份证号与该考生号对应的身份证号是否相同
                    if (StringUtils.isNotBlank(idCard))
                    {
                        if (!idCard.equals(student.getIDcard()))
                        {
                            stuNOVO = new ImportStudentNOVO(name, idCard,
                                    exameeNo, studentNo);
                            stuNoErrorInfo.add(stuNOVO);
                            stuNoErrorList.add("导入的身份证号与该考生号对应的身份证号不相同");
                            fail++;
                            if (i == 1)
                            {
                                failstr = failstr + i;
                            }
                            else
                            {
                                failstr = failstr + "," + i;
                            }
                            continue;
                        }
                    }

                    if (!(isTest))
                    {
                        student.setStudentNo(studentNo);
                        studentDao.save(student);
                    }
                }
                catch (Exception e)
                {
                    fail++;
                    if (i == 1)
                    {
                        failstr = failstr + i;
                    }
                    else
                    {
                        failstr = failstr + "," + i;
                    }
                }
            }
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        result.add(failstr);
        return result;
    }

    @Override
    protected HibernateDao<Student, Long> getEntityDao()
    {
        return studentDao;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setStudentDao(StudentDao studentDao)
    {
        this.studentDao = studentDao;
    }

    @Autowired
    public void setUserWebService(UserWebService userWebService)
    {
        this.userWebService = userWebService;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setBatchManager(BatchManager batchManager)
    {
        this.batchManager = batchManager;
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
        return studentDao.getBatchStu(collegeCode, majorCode, clazzCodeString);
    }

    /**
     * 
     * 学生信息统计
     * 
     * @since 2011-12-15
     * @author fangyong
     * @return
     */
    public List<SpecialCountVO> countStudent(String collegeCode,
            String specialCode, int year) throws Exception
    {
        List<SpecialCountVO> countVOs = Lists.newArrayList();
        SpecialCountVO vo = null;
        // 所有学院
        if (StringUtils.isBlank(collegeCode))
        {
            // 获得所有学院
            List<InstituteDTO> dtos = instituteWebService.getInstitutes();

            for (InstituteDTO dto : dtos)
            {
                // 分组获得该学院下的专业
                List<Student> students = studentDao.findStuGroupCol(dto
                        .getCode());

                int count = 0;
                int number = 0;
                if (students != null && !students.isEmpty())
                {
                    int size = students.size();
                    for (int i = 0; i < size; i++)
                    {
                        Student stu = students.get(i);
                        // 专业
                        vo = operateSpecialVO(stu.getMajorCode(), stu
                                .getMajorName(), year);
                        count += vo.getFreBeStuCount() + vo.getFreZhStuCount()
                                + vo.getFreZsbStuCount()
                                + vo.getSopBeStuCount() + vo.getSopZhStuCount()
                                + vo.getSopZsbStuCount()
                                + vo.getJunBeStuCount() + vo.getJunZhStuCount()
                                + vo.getSenBeStuCount();
                        number += vo.getTotalBenStuNumber()
                                + vo.getTotalZhStuNumber()
                                + vo.getTotalZsbStuNumber();
                        if (i == 0)
                        {
                            vo.setCollegeName(dto.getName());
                            vo.setSpecialSize(size);
                        }

                        countVOs.add(vo);
                        if (i == size - 1)
                        {
                            countVOs.get(countVOs.size() - size).setTotalCount(
                                    count);
                            countVOs.get(countVOs.size() - size)
                                    .setTotalNumber(number);
                        }
                    }
                }
            }
        }
        else
            if (StringUtils.isNotBlank(collegeCode)
                    && StringUtils.isBlank(specialCode))
            {
                // 获得当前学院
                String collegeName = instituteWebService
                        .getInstituteName(collegeCode);

                // 分组获得该学院下的专业
                List<Student> students = studentDao
                        .findStuGroupCol(collegeCode);

                int count = 0;
                int number = 0;
                if (students != null && !students.isEmpty())
                {
                    int size = students.size();
                    for (int i = 0; i < size; i++)
                    {
                        Student stu = students.get(i);
                        // 专业
                        vo = operateSpecialVO(stu.getMajorCode(), stu
                                .getMajorName(), year);

                        count += vo.getFreBeStuCount() + vo.getFreZhStuCount()
                                + vo.getFreZsbStuCount()
                                + vo.getSopBeStuCount() + vo.getSopZhStuCount()
                                + vo.getSopZsbStuCount()
                                + vo.getJunBeStuCount() + vo.getJunZhStuCount()
                                + vo.getSenBeStuCount();
                        number += vo.getTotalBenStuNumber()
                                + vo.getTotalZhStuNumber()
                                + vo.getTotalZsbStuNumber();

                        if (i == 0)
                        {
                            vo.setCollegeName(collegeName);
                            vo.setSpecialSize(size);
                        }

                        countVOs.add(vo);
                        if (i == size - 1)
                        {
                            countVOs.get(countVOs.size() - size).setTotalCount(
                                    count);
                            countVOs.get(countVOs.size() - size)
                                    .setTotalNumber(number);
                        }
                    }
                }
            }
            else
                if (StringUtils.isNotBlank(collegeCode)
                        && StringUtils.isNotBlank(specialCode))
                {
                    // 专业名称
                    String majorName = specialtyWebService
                            .getSpecialtyName(specialCode);

                    // 专业
                    vo = operateSpecialVO(specialCode, majorName, year);

                    // 获得当前学院名称
                    String collegeName = instituteWebService
                            .getInstituteName(collegeCode);
                    vo.setCollegeName(collegeName);

                    // 专业 数
                    vo.setSpecialSize(1);

                    // 院系下的学生数
                    vo.setTotalCount(vo.getFreBeStuCount()
                            + vo.getFreZhStuCount() + vo.getFreZsbStuCount()
                            + vo.getSopBeStuCount() + vo.getSopZhStuCount()
                            + vo.getSopZsbStuCount() + vo.getJunBeStuCount()
                            + vo.getJunZhStuCount() + vo.getSenBeStuCount());

                    // 预计毕业生数
                    vo.setTotalNumber(vo.getTotalBenStuNumber()
                            + vo.getTotalZsbStuNumber()
                            + vo.getTotalZhStuNumber());

                    countVOs.add(vo);
                }

        return countVOs;
    }

    // 获得学生统计VO
    private SpecialCountVO operateSpecialVO(String majorCode, String majorName,
            int year) throws Exception
    {
        SpecialCountVO svo = new SpecialCountVO();

        svo.setSpecialName(majorName);

        svo.setSpecialCode(majorCode);

        // 获得预科班级数
        long yukeCla = studentDao.countStuGroupCla(majorCode, Grade.YUKE);
        svo.setYukeClCount(yukeCla);

        // 获得预科学生数
        long yukeStu = studentDao.countStuByProperty(majorCode, Grade.YUKE);
        svo.setYukeStuCount(yukeStu);

        long freBeCla = countStuGroupCla(majorCode, Education.BENKE,
                Grade.FRESHMAN);
        svo.setFreBeClCount(freBeCla);

        long freZhCla = countStuGroupCla(majorCode, Education.DAZHUAN,
                Grade.FRESHMAN);
        svo.setFreZhClCount(freZhCla);

        long freZsbCla = countStuGroupCla(majorCode, Education.ZHUANSHENGBEN,
                Grade.FRESHMAN);
        svo.setFreZsbClCount(freZsbCla);

        long freBeStu = countStuByProperty(majorCode, Education.BENKE,
                Grade.FRESHMAN);
        svo.setFreBeStuCount(freBeStu);

        long ferZhStu = countStuByProperty(majorCode, Education.DAZHUAN,
                Grade.FRESHMAN);
        svo.setFreZhStuCount(ferZhStu);

        long freZsbStu = countStuByProperty(majorCode, Education.ZHUANSHENGBEN,
                Grade.FRESHMAN);
        svo.setFreZsbStuCount(freZsbStu);

        long sopBeCla = countStuGroupCla(majorCode, Education.BENKE,
                Grade.SOPHOMORE);
        svo.setSopBeClCount(sopBeCla);

        long sopZhCla = countStuGroupCla(majorCode, Education.DAZHUAN,
                Grade.SOPHOMORE);
        svo.setSopZhClCount(sopZhCla);

        long sopZsbCla = countStuGroupCla(majorCode, Education.ZHUANSHENGBEN,
                Grade.SOPHOMORE);
        svo.setSopZsbClCount(sopZsbCla);

        long sopBeStu = countStuByProperty(majorCode, Education.BENKE,
                Grade.SOPHOMORE);
        svo.setSopBeStuCount(sopBeStu);
        long sopZhStu = countStuByProperty(majorCode, Education.DAZHUAN,
                Grade.SOPHOMORE);
        svo.setSopZhStuCount(sopZhStu);

        long sopZsbStu = countStuByProperty(majorCode, Education.ZHUANSHENGBEN,
                Grade.SOPHOMORE);
        svo.setSopZsbStuCount(sopZsbStu);

        long junBeCla = countStuGroupCla(majorCode, Education.BENKE,
                Grade.JUNIOR);
        svo.setJunBeClCount(junBeCla);

        long junZhCla = countStuGroupCla(majorCode, Education.DAZHUAN,
                Grade.JUNIOR);
        svo.setJunZhClCount(junZhCla);

        long junBenStu = countStuByProperty(majorCode, Education.BENKE,
                Grade.JUNIOR);
        svo.setJunBeStuCount(junBenStu);

        long junZhStu = countStuByProperty(majorCode, Education.DAZHUAN,
                Grade.JUNIOR);
        svo.setJunZhStuCount(junZhStu);

        long senBeCla = countStuGroupCla(majorCode, Education.BENKE,
                Grade.SENIOR);
        svo.setSenBeClCount(senBeCla);

        long senBeStu = countStuByProperty(majorCode, Education.BENKE,
                Grade.SENIOR);

        svo.setSenBeStuCount(senBeStu);

        Date beginYear = DateUtils.getDate(String.valueOf(year), "yyyy");
        Date endYear = DateUtils.getDate(year + "-12-31", "yyyy-MM-dd");

        svo.setTotalBenStuNumber(studentDao.countGraduteStus(majorCode,
                Education.BENKE, beginYear, endYear));

        svo.setTotalZhStuNumber(studentDao.countGraduteStus(majorCode,
                Education.DAZHUAN, beginYear, endYear));

        svo.setTotalZsbStuNumber(studentDao.countGraduteStus(majorCode,
                Education.ZHUANSHENGBEN, beginYear, endYear));

        return svo;
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
        return studentDao.countStuGroupCla(majorCode, education, grade);
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
        return studentDao.countStuByProperty(majorCode, education, grade);
    }
    
    public static void main(String[] args){
    	
    	String d= "五";
    	System.out.println(d.substring(0,d.indexOf(".")));
    }

}
