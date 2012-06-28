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
package cn.loosoft.stuwork.stuinfo.webservice.student;

import java.util.List;

import javax.jws.WebService;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.common.lib.util.web.PropertyUtils;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.stuwork.stuinfo.dao.student.StudentDao;
import cn.loosoft.stuwork.stuinfo.entity.student.Student;
import cn.loosoft.stuwork.stuinfo.service.student.StudentManager;
import cn.loosoft.stuwork.stuinfo.web.attachment.UploadPath;

import com.google.common.collect.Lists;

/**
 * 学生的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-12
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.student.StudentWebService")
public class StudentWebServiceImpl implements StudentWebService
{
    StudentManager studentManager; // 学生信息

    StudentDao     studentDao;

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-12-22
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#getStudentByExamineeNo
     *      (java.lang.String)
     */
    public StudentDTO getStudentByExamineeNo(String examineeNo)
    {

        StudentDTO studentDTO = null;
        if (examineeNo != null && StringUtils.isNotEmpty(examineeNo))
        {
            Student student = studentManager.getByExamineeNo(examineeNo);
            if (student != null)
            {
                studentDTO = new StudentDTO(student.getId(), student
                        .getStudentNo(), student.getName(), student.getSex(),
                        student.getExamineeNo(), student.getPinyin(), student
                                .getFormer(), student.getIDcard(), student
                                .getAccount(), student.getCollegeCode(),
                        student.getCollegeName(), student.getMajorCode(),
                        student.getMajorName(), student.getClassCode(), student
                                .getClassName(), student.getRoombed(), student
                                .getNationDesc(), student.getBirthPlace(),
                        student.getPoliticsFaceDesc(), student.getLength(),
                        student.getCultureWay(), student.getEducationDesc(),
                        student.getDegreeDesc(), student.getInDate(), student
                                .getFinishDate(), student.getHierophant(),
                        student.getPhone(), student.getCardNum(), student
                                .getEdudirection(), student.getTestaddr(),
                        student.getFatherName(), student.getMotherName(),
                        student.getAddress(), student.getFamilyCode(), student
                                .getHomePhone(), student.getBlood(), student
                                .getHealthInfo(), student.getMarryInfo(),
                        student.getPsyInfo(), student.getCountry(), student
                                .getReligion(), student.getBankName(), student
                                .getBankAccount(), student.getOnlineWeb(),
                        student.getEmail(), student.getSpecialty(), student
                                .getRemarks(), student.isAutonomy(), student
                                .getBirthday(), student.getPeriod(),
                        PropertyUtils.getProperty("stuinfo.webapp.url", "")
                                + UploadPath.PICTUREPATH
                                + UploadPath.STUDENTPIC + student.getImg(),
                        student.getCounselor(), student.getCounselorPhone(),
                        student.getHeadTeacher(),
                        student.getHeadTeacherPhone(), student.getYear(),
                        student.getSeason(), student.getGraduateSchool(),
                        student.getPassword(), student.getType(), student
                                .isGraduated(), student.isInSchool(), student
                                .getNotSchoolReason(), student.isReged(),
                        student.isDeleted(), student.getGrade());
                return studentDTO;
            }
        }

        return studentDTO;
    }

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-12-22
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#getStudentByStudentNo
     *      (java.lang.String)
     */
    public StudentDTO getStudentByStudentNo(String studentNo)
    {

        StudentDTO studentDTO = null;
        if (null != studentNo && StringUtils.isNotEmpty(studentNo))
        {
            Student student = studentManager.getByStudentNo(studentNo);
            if (null != student)
            {

                studentDTO = new StudentDTO(student.getId(), student
                        .getStudentNo(), student.getName(), student.getSex(),
                        student.getExamineeNo(), student.getPinyin(), student
                                .getFormer(), student.getIDcard(), student
                                .getAccount(), student.getCollegeCode(),
                        student.getCollegeName(), student.getMajorCode(),
                        student.getMajorName(), student.getClassCode(), student
                                .getClassName(), student.getRoombed(), student
                                .getNationDesc(), student.getBirthPlace(),
                        student.getPoliticsFaceDesc(), student.getLength(),
                        student.getCultureWay(), student.getEducationDesc(),
                        student.getEducationDesc(), student.getInDate(),
                        student.getFinishDate(), student.getHierophant(),
                        student.getPhone(), student.getCardNum(), student
                                .getEdudirection(), student.getTestaddr(),
                        student.getFatherName(), student.getMotherName(),
                        student.getAddress(), student.getFamilyCode(), student
                                .getHomePhone(), student.getBlood(), student
                                .getHealthInfo(), student.getMarryInfo(),
                        student.getPsyInfo(), student.getCountry(), student
                                .getReligion(), student.getBankName(), student
                                .getBankAccount(), student.getOnlineWeb(),
                        student.getEmail(), student.getSpecialty(), student
                                .getRemarks(), student.isAutonomy(), student
                                .getBirthday(), student.getPeriod(), student
                                .getPhoto(), student.getCounselor(), student
                                .getCounselorPhone(), student.getHeadTeacher(),
                        student.getHeadTeacherPhone(), student.getYear(),
                        student.getSeason(), student.getGraduateSchool(),
                        student.getPassword(), student.getType(), student
                                .isGraduated(), student.isInSchool(), student
                                .getNotSchoolReason(), student.isReged(),
                        student.isDeleted(), student.getGrade());
                return studentDTO;

            }

        }

        return studentDTO;
    }

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-12-23
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#getStudentByIDcard
     *      (java.lang.String)
     */
    public StudentDTO getStudentByIDcard(String IDcard)
    {

        StudentDTO studentDTO = null;

        if (null != IDcard && StringUtils.isNotEmpty(IDcard))
        {

            Student student = studentManager.getByIDcard(IDcard);
            if (null != student)
            {

                studentDTO = new StudentDTO(student.getId(), student
                        .getStudentNo(), student.getName(), student.getSex(),
                        student.getExamineeNo(), student.getPinyin(), student
                                .getFormer(), student.getIDcard(), student
                                .getAccount(), student.getCollegeCode(),
                        student.getCollegeName(), student.getMajorCode(),
                        student.getMajorName(), student.getClassCode(), student
                                .getClassName(), student.getRoombed(), student
                                .getNationDesc(), student.getBirthPlace(),
                        student.getPoliticsFaceDesc(), student.getLength(),
                        student.getCultureWay(), student.getEducationDesc(),
                        student.getDegreeDesc(), student.getInDate(), student
                                .getFinishDate(), student.getHierophant(),
                        student.getPhone(), student.getCardNum(), student
                                .getEdudirection(), student.getTestaddr(),
                        student.getFatherName(), student.getMotherName(),
                        student.getAddress(), student.getFamilyCode(), student
                                .getHomePhone(), student.getBlood(), student
                                .getHealthInfo(), student.getMarryInfo(),
                        student.getPsyInfo(), student.getCountry(), student
                                .getReligion(), student.getBankName(), student
                                .getBankAccount(), student.getOnlineWeb(),
                        student.getEmail(), student.getSpecialty(), student
                                .getRemarks(), student.isAutonomy(), student
                                .getBirthday(), student.getPeriod(),
                        PropertyUtils.getProperty("stuinfo.webapp.url", "")
                                + UploadPath.PICTUREPATH
                                + UploadPath.STUDENTPIC + student.getImg(),
                        student.getCounselor(), student.getCounselorPhone(),
                        student.getHeadTeacher(),
                        student.getHeadTeacherPhone(), student.getYear(),
                        student.getSeason(), student.getGraduateSchool(),
                        student.getPassword(), student.getType(), student
                                .isGraduated(), student.isInSchool(), student
                                .getNotSchoolReason(), student.isReged(),
                        student.isDeleted(), student.getGrade());
                return studentDTO;

            }
        }
        return studentDTO;
    }

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-12-22
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#getStudentsByExamineeNo
     *      (java.util.List)
     */
    public List<StudentDTO> getStudentsByExamineeNos(List<String> examineeNoList)
    {
        List<StudentDTO> studentDTOs = Lists.newArrayList();

        if (null != examineeNoList && examineeNoList.size() > 0)
        {
            for (String examineeNo : examineeNoList)
            {
                Student student = studentDao.findUniqueBy("examineeNo",
                        examineeNo);
                if (student != null)
                {
                    studentDTOs.add(new StudentDTO(student.getId(), student
                            .getStudentNo(), student.getName(), student
                            .getSex(), student.getExamineeNo(), student
                            .getPinyin(), student.getFormer(), student
                            .getIDcard(), student.getAccount(), student
                            .getCollegeCode(), student.getCollegeName(),
                            student.getMajorCode(), student.getMajorName(),
                            student.getClassCode(), student.getClassName(),
                            student.getRoombed(), student.getNationDesc(),
                            student.getBirthPlace(), student
                                    .getPoliticsFaceDesc(),
                            student.getLength(), student.getCultureWay(),
                            student.getEducationDesc(),
                            student.getDegreeDesc(), student.getInDate(),
                            student.getFinishDate(), student.getHierophant(),
                            student.getPhone(), student.getCardNum(), student
                                    .getEdudirection(), student.getTestaddr(),
                            student.getFatherName(), student.getMotherName(),
                            student.getAddress(), student.getFamilyCode(),
                            student.getHomePhone(), student.getBlood(), student
                                    .getHealthInfo(), student.getMarryInfo(),
                            student.getPsyInfo(), student.getCountry(), student
                                    .getReligion(), student.getBankName(),
                            student.getBankAccount(), student.getOnlineWeb(),
                            student.getEmail(), student.getSpecialty(), student
                                    .getRemarks(), student.isAutonomy(),
                            student.getBirthday(), student.getPeriod(),
                            PropertyUtils.getProperty("stuinfo.webapp.url", "")
                                    + UploadPath.PICTUREPATH
                                    + UploadPath.STUDENTPIC + student.getImg(),
                            student.getCounselor(),
                            student.getCounselorPhone(), student
                                    .getHeadTeacher(), student
                                    .getHeadTeacherPhone(), student.getYear(),
                            student.getSeason(), student.getGraduateSchool(),
                            student.getPassword(), student.getType(), student
                                    .isGraduated(), student.isInSchool(),
                            student.getNotSchoolReason(), student.isReged(),
                            student.isDeleted(), student.getGrade()));
                }
            }
        }

        return studentDTOs;
    }

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-12-22
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#getStudentsByStudentNo
     *      (java.util.List)
     */
    public List<StudentDTO> getStudentsByStudentNos(List<String> studentNoList)
    {
        List<StudentDTO> studentDTOs = Lists.newArrayList();

        if (null != studentNoList && studentNoList.size() > 0)
        {
            for (String studentNo : studentNoList)
            {
                Student student = studentManager.getByStudentNo(studentNo);
                if (student != null)
                {
                    studentDTOs.add(new StudentDTO(student.getId(), student
                            .getStudentNo(), student.getName(), student
                            .getSex(), student.getExamineeNo(), student
                            .getPinyin(), student.getFormer(), student
                            .getIDcard(), student.getAccount(), student
                            .getCollegeCode(), student.getCollegeName(),
                            student.getMajorCode(), student.getMajorName(),
                            student.getClassCode(), student.getClassName(),
                            student.getRoombed(), student.getNationDesc(),
                            student.getBirthPlace(), student
                                    .getPoliticsFaceDesc(),
                            student.getLength(), student.getCultureWay(),
                            student.getEducationDesc(),
                            student.getDegreeDesc(), student.getInDate(),
                            student.getFinishDate(), student.getHierophant(),
                            student.getPhone(), student.getCardNum(), student
                                    .getEdudirection(), student.getTestaddr(),
                            student.getFatherName(), student.getMotherName(),
                            student.getAddress(), student.getFamilyCode(),
                            student.getHomePhone(), student.getBlood(), student
                                    .getHealthInfo(), student.getMarryInfo(),
                            student.getPsyInfo(), student.getCountry(), student
                                    .getReligion(), student.getBankName(),
                            student.getBankAccount(), student.getOnlineWeb(),
                            student.getEmail(), student.getSpecialty(), student
                                    .getRemarks(), student.isAutonomy(),
                            student.getBirthday(), student.getPeriod(),
                            PropertyUtils.getProperty("stuinfo.webapp.url", "")
                                    + UploadPath.PICTUREPATH
                                    + UploadPath.STUDENTPIC + student.getImg(),
                            student.getCounselor(),
                            student.getCounselorPhone(), student
                                    .getHeadTeacher(), student
                                    .getHeadTeacherPhone(), student.getYear(),
                            student.getSeason(), student.getGraduateSchool(),
                            student.getPassword(), student.getType(), student
                                    .isGraduated(), student.isInSchool(),
                            student.getNotSchoolReason(), student.isReged(),
                            student.isDeleted(), student.getGrade()));
                }
            }
        }
        return studentDTOs;
    }

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-12-24
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#
     *      getStudentNosByCondition
     *      (java.lang.String,java.lang.String,java.lang.
     *      String,java.lang.String,java.lang.String)
     */
    public List<String> getStudentNosByCondition(String collegeCode,
            String majorCode, String classCode, String studentNo, String name,
            String IDcard, String period, String examineeNo, String inDate,
            String finishDate, int pageNo, int pageSize)
    {
        return studentManager.getStudentNosByCondition(collegeCode, majorCode,
                classCode, studentNo, name, IDcard, period, examineeNo, inDate,
                finishDate, pageNo, pageSize);
    }

    public List<String> getStudentNos(String collegeCode, String majorCode,
            String classCode, String studentNo, String name, String IDcard,
            String period, String examineeNo, String inDate, String finishDate)
    {

        return studentManager.getStudentNosByCondition(collegeCode, majorCode,
                classCode, studentNo, name, IDcard, period, examineeNo, inDate,
                finishDate);
    }

    public long countStudent(String collegeCode, String majorCode,
            String classCode, String studentNo, String name, String IDcard,
            String period, String examineeNo, String inDate, String finishDate)
    {
        return studentManager
                .countStudent(collegeCode, majorCode, classCode, studentNo,
                        name, IDcard, period, examineeNo, inDate, finishDate);
    }

    /**
     * {@inheritDoc}
     * 
     * @author shanru.wu
     * @since 2010-1-18
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#
     *      getNameByStuId (java.lang.String)
     */
    public String getNameByStuId(String stuId)
    {
        Student student = studentManager.getByStudentNo(stuId);
        if (null != student)
        {
            return student.getName();
        }
        return null;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setStudentDao(StudentDao studentDao)
    {
        this.studentDao = studentDao;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-19
     * @see cn.loosoft.data.webservice.api.student.StudentWebService#getBatchStu(java.lang.String,
     *      java.lang.String, java.lang.String)
     */
    public List<StudentDTO> getBatchStu(String collegeCode, String majorCode,
            String clazzCodeString)
    {
        List<Student> studentList = studentManager.getBatchStu(collegeCode,
                majorCode, clazzCodeString);
        return this.convertToDTO(studentList);
    }

    /**
     * 把Student对象转换成StudentDTO对象 并返回list<JobsDTO>
     * 
     * @since 2011-4-19
     * @author yong.geng
     * @param jobsList
     * @return list<JobsDTO>
     */
    public List<StudentDTO> convertToDTO(List<Student> studentList)
    {
        StudentDTO studentDTO = null;
        List<StudentDTO> dtoList = Lists.newArrayList();
        for (int i = 0; i < studentList.size(); i++)
        {
            studentDTO = new StudentDTO();
            studentDTO.setStudentNo(studentList.get(i).getStudentNo());
            studentDTO.setExamineeNo(studentList.get(i).getExamineeNo());
            studentDTO.setName(studentList.get(i).getName());
            studentDTO.setEmail(studentList.get(i).getEmail());
            studentDTO.setCollegeCode(studentList.get(i).getCollegeCode());
            studentDTO.setMajorCode(studentList.get(i).getMajorCode());
            studentDTO.setClassCode(studentList.get(i).getClassCode());
            studentDTO.setClassName(studentList.get(i).getClassName());
            dtoList.add(studentDTO);
        }
        return dtoList;
    }

    public void saveStudent(StudentDTO studentDTO)
    {
        Student student = new Student();

        try
        {
            ConvertUtils
                    .register(new DateConverter(null), java.util.Date.class);
            BeanUtils.copyProperties(student, studentDTO);
            studentManager.save(student);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

}
