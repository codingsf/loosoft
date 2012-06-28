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
package cn.loosoft.stuwork.workstudy.webservice.jobs;

import java.util.List;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.common.lib.util.date.DateUtils;
import cn.loosoft.data.webservice.api.jobs.JobsWebService;
import cn.loosoft.data.webservice.api.jobs.dto.CommitmentDTO;
import cn.loosoft.data.webservice.api.jobs.dto.JobsDTO;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.job.Jobs;
import cn.loosoft.stuwork.workstudy.entity.job.StudentJobs;
import cn.loosoft.stuwork.workstudy.entity.sys.Commitment;
import cn.loosoft.stuwork.workstudy.service.job.JobsManager;
import cn.loosoft.stuwork.workstudy.service.job.StudentjobsManager;
import cn.loosoft.stuwork.workstudy.service.sys.CommitmentManager;

import com.google.common.collect.Lists;

/**
 * 
 * 新闻的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-4-17
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.jobs.JobsWebService")
public class JobsWebServiceImpl implements JobsWebService
{
    @Autowired
    private JobsManager        jobsManager;

    @Autowired
    private CommitmentManager  commitmentManager;

    @Autowired
    private StudentWebService studentWebervice;
    @Autowired
    private StudentjobsManager studentjobsManager;

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-17
     * @see cn.loosoft.data.webservice.api.jobs.JobsWebService#getAllJobs()
     */
    public List<JobsDTO> getAllJobs(int pageNo)
    {
        List<Jobs> jobsList = jobsManager.getAllJobs(pageNo);
        return this.convertToDTO(jobsList);
    }

    /**
     * 把Jobs对象转换成JobsDTO对象 并返回list<JobsDTO>
     * 
     * @since 2011-4-17
     * @author yong.geng
     * @param jobsList
     * @return list<JobsDTO>
     */
    public List<JobsDTO> convertToDTO(List<Jobs> jobsList)
    {
        JobsDTO jobsDTO = null;
        List<JobsDTO> dtoList = Lists.newArrayList();
        for (int i = 0; i < jobsList.size(); i++)
        {
            jobsDTO = new JobsDTO();
            jobsDTO.setId(jobsList.get(i).getId());
            jobsDTO.setPostName(jobsList.get(i).getPostName());
            jobsDTO.setSexLimit(jobsList.get(i).getSexLimit());
            jobsDTO.setAddress(jobsList.get(i).getAddress());
            jobsDTO.setContent(jobsList.get(i).getContent());
            jobsDTO.setRequireMents(jobsList.get(i).getRequireMents());
            jobsDTO.setPubdate(jobsList.get(i).getPubdate());
            jobsDTO.setStopdate(jobsList.get(i).getStopdate());
            jobsDTO.setReqCount(jobsList.get(i).getReqCount());
            jobsDTO.setExisitCount(jobsList.get(i).getExisitCount());
            dtoList.add(jobsDTO);
        }
        return dtoList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-17
     * @see cn.loosoft.data.webservice.api.jobs.JobsWebService#getAllJobsCount()
     */
    public int getAllJobsCount()
    {
        return jobsManager.getAll().size();
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-18
     * @see cn.loosoft.data.webservice.api.jobs.JobsWebService#getJobById(long)
     */
    public JobsDTO getJobById(long id)
    {
        Jobs jobs = jobsManager.findJobsById(id);

        JobsDTO jobsDTO = new JobsDTO();
        jobsDTO.setId(jobs.getId());
        jobsDTO.setPostName(jobs.getPostName());
        jobsDTO.setSexLimit(jobs.getSexLimit());
        jobsDTO.setCompanyName(jobs.getCompany().getCompanyName());
        jobsDTO.setAddress(jobs.getAddress());
        jobsDTO.setContent(jobs.getContent());
        jobsDTO.setRequireMents(jobs.getRequireMents());
        jobsDTO.setPubdate(jobs.getPubdate());
        jobsDTO.setStopdate(jobs.getStopdate());
        jobsDTO.setReqCount(jobs.getReqCount());
        jobsDTO.setExisitCount(jobs.getExisitCount());
        return jobsDTO;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-18
     * @see cn.loosoft.data.webservice.api.jobs.JobsWebService#getCommitment()
     */
    public CommitmentDTO getCommitment()
    {
        Commitment commitment = commitmentManager.getAll().get(0);
        CommitmentDTO commitmentDTO = new CommitmentDTO();
        commitmentDTO.setContent(commitment.getContent());
        commitmentDTO.setName(commitment.getName());
        return commitmentDTO;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-18
     * @see cn.loosoft.data.webservice.api.jobs.JobsWebService#saveStuJobs(java.lang.String,
     *      long, java.lang.String)
     */
    public void saveStuJobs(String loginName, long jobsId, String applyReason)
    {
        // 这里是学生使用的，所以肯定是到backmanage去取
        StudentDTO userDTO = studentWebervice.getStudentByStudentNo(loginName);

        // 登录名就是考试号
        String studentNo = userDTO.getStudentNo();
        String studentName = userDTO.getName();
        String collegeCode = userDTO.getCollegeCode();

        Jobs jobs = jobsManager.findJobsById(jobsId);

        StudentJobs studentJobs = new StudentJobs();
        studentJobs.setJobsID((int) jobsId);
        studentJobs.setJobsName(jobs.getPostName());
        studentJobs.setStudentNo(studentNo);
        studentJobs.setStudentName(studentName);
        studentJobs.setCenterStatus(Constant.SHZ);
        studentJobs.setApplyReason(applyReason);
        studentJobs.setChose(Constant.CHOSING);
        studentJobs.setApplyDate(DateUtils.getNowTimestamp());
        studentJobs.setGroupStatus(Constant.SHZ);
        studentJobs.setCompanyID(Integer.parseInt(jobs.getCompany().getId()
                .toString()));
        studentJobs.setCollegeCode(collegeCode);
        studentjobsManager.save(studentJobs);

    }
}
