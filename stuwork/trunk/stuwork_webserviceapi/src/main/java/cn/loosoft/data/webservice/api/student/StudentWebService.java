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
package cn.loosoft.data.webservice.api.student;

import java.util.List;

import javax.jws.WebParam;
import javax.jws.WebService;

import cn.loosoft.data.webservice.api.student.dto.StudentDTO;

/**
 * 学生webservice接口.
 * <p>
 * 使用@WebService将接口中的所有方法输出为Web Service.
 * </p>
 * <p>
 * 可用annotation对设置方法、参数和返回值在WSDL中的定义.
 * </p>
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-12
 */
@WebService
public interface StudentWebService
{
    /**
     * 
     * 根据学号获取学生对象
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @param studnetNo
     * @return
     */
    StudentDTO getStudentByStudentNo(
            @WebParam(name = "studentNo") String studnetNo);

    /**
     * 
     * 获取学生的总记录数
     * 
     * @since 2010-1-16
     * @author shanru.wu
     * @return
     */
    long countStudent(@WebParam(name = "collegeCode") String collegeCode,
            @WebParam(name = "majorCode") String majorCode,
            @WebParam(name = "classCode") String classCode,
            @WebParam(name = "studentNo") String studentNo,
            @WebParam(name = "name") String name,
            @WebParam(name = "IDcard") String IDcard,
            @WebParam(name = "period") String period,
            @WebParam(name = "examineeNo") String examineeNo,
            @WebParam(name = "inDate") String inDate,
            @WebParam(name = "finishDate") String finishDate);

    /**
     * 
     * 根据学号获取姓名 、
     * 
     * @since 2011-1-18
     * @author shanru.wu
     * @param stuId
     * @return
     */
    String getNameByStuId(@WebParam(name = "stuId") String stuId);

    /**
     * 
     * 根据身份证号获取学生对象
     * 
     * @since 2010-12-23
     * @author shanru.wu
     * @param IDcard
     * @return
     */
    StudentDTO getStudentByIDcard(@WebParam(name = "IDcard") String IDcard);

    /**
     * 
     * 根据考生号获取学生对象
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @param examineeNo
     * @return
     */
    StudentDTO getStudentByExamineeNo(
            @WebParam(name = "examineeNo") String examineeNo);

    /**
     * 
     * 根据学号列表批量获取学生列表
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @param studentNoList
     * @return
     */
    List<StudentDTO> getStudentsByStudentNos(
            @WebParam(name = "studentNoList") List<String> studentNoList);

    /**
     * 
     * 批量获取前N(10,15,20,)条学号
     * 
     * @since 2010-12-24
     * @author shanru.wu
     * @return
     */
    List<String> getStudentNosByCondition(
            @WebParam(name = "collegeCode") String collegeCode,
            @WebParam(name = "majorCode") String majorCode,
            @WebParam(name = "classCode") String classCode,
            @WebParam(name = "studentNo") String studentNo,
            @WebParam(name = "name") String name,
            @WebParam(name = "IDcard") String IDcard,
            @WebParam(name = "period") String period,
            @WebParam(name = "examineeNo") String examineeNo,
            @WebParam(name = "inDate") String inDate,
            @WebParam(name = "finishDate") String finishDate,
            @WebParam(name = "pageNo") int pageNo,
            @WebParam(name = "pageSize") int pageSize);

    /**
     * 
     * 根据查询条件批量获取学号
     * 
     * @since 2011-1-17
     * @author Administrator
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @param studentNo
     * @param name
     * @param IDcard
     * @param period
     * @param examineeNo
     * @param inDate
     * @return
     */
    List<String> getStudentNos(
            @WebParam(name = "collegeCode") String collegeCode,
            @WebParam(name = "majorCode") String majorCode,
            @WebParam(name = "classCode") String classCode,
            @WebParam(name = "studentNo") String studentNo,
            @WebParam(name = "name") String name,
            @WebParam(name = "IDcard") String IDcard,
            @WebParam(name = "period") String period,
            @WebParam(name = "examineeNo") String examineeNo,
            @WebParam(name = "inDate") String inDate,
            @WebParam(name = "finishDate") String finishDate);

    /**
     * 
     * 根据考生号列表批量获取学生列表
     * 
     * @since 2010-12-12
     * @author shanru.wu
     * @param examineeNoList
     * @return
     */
    List<StudentDTO> getStudentsByExamineeNos(
            @WebParam(name = "examineeNoList") List<String> examineeNoList);

    /**
     * 
     * 根据条件，查询对应的stu
     * 
     * @since 2011-4-19
     * @author yong.geng
     * @param collegeCode
     * @param majorCode
     * @param clazzCodeString
     * @return
     */
    public List<StudentDTO> getBatchStu(
            @WebParam(name = "collegeCode") String collegeCode,
            @WebParam(name = "majorCode") String majorCode,
            @WebParam(name = "clazzCodeString") String clazzCodeString);

    /**
     * 
     * 持久化学生
     * 
     * @since 2011-4-26
     * @author shanru.wu
     * @param clazzs
     * @return
     */
    void saveStudent(@WebParam(name = "studentDTO") StudentDTO studentDTO);

}
