//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Ufinity. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Ufinity
//
// Original author: chengpeng.zhang
//
//-------------------------------------------------------------------------
// UFINITY MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
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
package cn.loosoft.stuwork.stuinfo.web.related;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import cn.common.lib.util.json.Json2JavaUtil;
import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.stuwork.stuinfo.entity.batch.Batch;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 处理级联请求的action
 * 
 * @author chengpeng.zhang
 * @version 1.0
 * @since 2010-8-29
 * @author houbing.qian
 * @version 1.1
 */
@ParentPackage("json-default")
@Namespace("/related")
@Results( { @Result(type = "json") })
public class RelatedAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long   serialVersionUID = 1L;

    // BatchWebService batchWebService;

    BatchManager                batchManager;

    private SpecialtyWebService specialtyWebService;

    private ClazzWebService     clazzWebService;

    private String              students;

    private String              majors;               // 专业

    private String              clazzs;               // 班级

    @JSON(name = "students")
    public String getStudents()
    {
        return students;
    }

    /**
     * 
     * 取得专业列表
     * 
     * @since 2010-9-2
     * @author houbing.qian
     * @return
     */
    public String majorList()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String collegeCode = ParamUtils
                .getParameter(request, "collegeCode", "");
        List<SpecialtyDTO> specialtyDTOs = specialtyWebService
                .getSpecialtysByCollege(collegeCode);
        majors = Json2JavaUtil.JavaList2Json(specialtyDTOs);
        return SUCCESS;
    }

    /**
     * 
     * 取得班级列表
     * 
     * @since 2010-9-2
     * @author houbing.qian
     * @return
     */
    public String clazzList()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String majorCode = ParamUtils.getParameter(request, "majorCode", "");
        String studentType = ParamUtils.getParameter(request, "studentType",
                null);

        // BatchDTO batchDTO = batchWebService.getCurrentBatch();
        Batch batch = batchManager.getCurrentBatch();
        List<ClazzDTO> clazzDTOs = clazzWebService.getClazzsBySpecialty(
                majorCode, studentType, batch.getYear(), batch.getSeason());

        if (clazzDTOs != null && !clazzDTOs.isEmpty())
        {
            clazzs = Json2JavaUtil.JavaList2Json(clazzDTOs);
        }
        return SUCCESS;
    }

    @JSON(name = "majors")
    public String getMajors()
    {
        return this.majors;
    }

    @JSON(name = "clazzs")
    public String getClazzs()
    {
        return this.clazzs;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setBatchManager(BatchManager batchManager)
    {
        this.batchManager = batchManager;
    }

    // @Autowired
    // public void setBatchWebService(BatchWebService batchWebService)
    // {
    // this.batchWebService = batchWebService;
    // }

}
