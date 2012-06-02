//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
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
package cn.loosoft.data.webservice.api.jobs;

import java.util.List;

import javax.jws.WebParam;
import javax.jws.WebService;

import cn.loosoft.data.webservice.api.jobs.dto.CommitmentDTO;
import cn.loosoft.data.webservice.api.jobs.dto.JobsDTO;

/**
 * 用户webservice接口.
 * <p>
 * 使用@WebService将接口中的所有方法输出为Web Service.
 * </p>
 * <p>
 * 可用annotation对设置方法、参数和返回值在WSDL中的定义.
 * </p>
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-4-17
 */
@WebService
public interface JobsWebService
{

    /**
     * 
     * 得到带分页的数据
     * 
     * @since 2011-4-17
     * @author yong.geng
     * @param pageNo
     * @return
     */
    public List<JobsDTO> getAllJobs(@WebParam(name = "pageNo")
    int pageNo);

    /**
     * 
     * 得到岗位总条数，给分页使用
     * 
     * @since 2011-4-17
     * @author yong.geng
     * @return
     */
    public int getAllJobsCount();

    /**
     * 
     * 查看单个岗位信息
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @param id
     * @return
     */
    public JobsDTO getJobById(@WebParam(name = "id")
    long id);

    /**
     * 
     * 取得应聘陈诺书
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @return
     */
    public CommitmentDTO getCommitment();

    /**
     * 
     * 保存到学生-岗位信息表
     * 
     * @since 2011-4-18
     * @author yong.geng
     * @param loginName
     * @param jobsId
     * @param applyReason
     */
    public void saveStuJobs(@WebParam(name = "loginName")
    String loginName, @WebParam(name = "jobsId")
    long jobsId, @WebParam(name = "applyReason")
    String applyReason);
}
