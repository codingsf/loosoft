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
package cn.loosoft.data.webservice.api.query.dto;

import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

/**
 * Web Service传输学生申请岗位信息的DTO. Description of the class
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-4-17
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "StudentJobs")
public class StudentJobsDTO
{
    private String jobsName;   // 岗位名称

    private String studentNo; // 考生号

    private String studentName; // 学生姓名

    private String applyReason; // 申请原因

    private Date   applyDate;  // 申请日期

    public StudentJobsDTO()
    {

    }

    public StudentJobsDTO(String jobsName, String studentNo,
            String studentName, String applyReason, Date applyDate)
    {
        this.jobsName = jobsName;
        this.studentNo = studentNo;
        this.studentName = studentName;
        this.applyReason = applyReason;
        this.applyDate = applyDate;
    }

    public String getJobsName()
    {
        return jobsName;
    }

    public void setJobsName(String jobsName)
    {
        this.jobsName = jobsName;
    }

    public String getStudentNo() {
		return studentNo;
	}

	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}

	public String getStudentName()
    {
        return studentName;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getApplyReason()
    {
        return applyReason;
    }

    public void setApplyReason(String applyReason)
    {
        this.applyReason = applyReason;
    }

    public Date getApplyDate()
    {
        return applyDate;
    }

    public void setApplyDate(Date applyDate)
    {
        this.applyDate = applyDate;
    }

}
