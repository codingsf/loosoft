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
package cn.loosoft.stuwork.workstudy.webservice.query;

import java.util.List;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.query.StudentJobsWebService;
import cn.loosoft.data.webservice.api.query.dto.StudentJobsDTO;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.service.job.StudentjobsManager;

import com.google.common.collect.Lists;

/**
 * 
 * 学生申请岗位的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-17
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.query.StudentJobsWebService")
public class StudentJobsWebServiceImpl implements StudentJobsWebService
{
    @Autowired
    private StudentjobsManager studentjobsManager;

    public List<StudentJobsDTO> getAllStuJobsList()
    {
        List<StudentJobs> stujobs = studentjobsManager.getAll();
        return this.convertToDTO(stujobs);
    }

    public List<StudentJobsDTO> convertToDTO(List<StudentJobs> stujobs)
    {
        StudentJobsDTO studentJobsDTO = null;

        List<StudentJobsDTO> stuJobsList = Lists.newArrayList();
        for (int i = 0; i < stujobs.size(); i++)
        {
            studentJobsDTO = new StudentJobsDTO();
            studentJobsDTO.setJobsName(stujobs.get(i).getJobsName());
            studentJobsDTO.setStudentNo(stujobs.get(i).getStudentNo());
            studentJobsDTO.setStudentName(stujobs.get(i).getStudentName());
            studentJobsDTO.setApplyReason(stujobs.get(i).getApplyReason());
            studentJobsDTO.setApplyDate(stujobs.get(i).getApplyDate());
            stuJobsList.add(studentJobsDTO);
        }
        return stuJobsList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-20
     * @see cn.loosoft.data.webservice.api.query.StudentJobsWebService#getStudentJobsByApply(java.sql.Date,
     *      java.sql.Date)
     */
    public List<StudentJobsDTO> getStudentJobsByApplyTime(String studentNo,
            String startTime, String stopTime, int pageNo)
    {
        List<StudentJobs> stuJobsList = studentjobsManager
                .getStudentJobsByApply(studentNo, startTime, stopTime, pageNo);
        return this.convertToDTO(stuJobsList);
    }

    public int getAllStudentJobsCount(String studentNo, String startTime,
            String stopTime)
    {
        // TODO Auto-generated method stub
        return studentjobsManager.getAllStudentJobsCount(studentNo, startTime,
                stopTime).size();
    }

}
