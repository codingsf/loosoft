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
package cn.loosoft.stuwork.backmanage.webservice.school;

import java.util.List;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.service.school.InstituteManager;

import com.google.common.collect.Lists;

/**
 * 学院的webservice实现类
 * 使用@WebService指向Interface定义类即可. 
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-21
 */
//Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.school.InstituteWebService") 
public class InstituteWebServiceImpl implements InstituteWebService
{
    @Autowired
    private InstituteManager instituteManager;

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.InstituteWebService#getInstituteName(java.lang.String)
     */
    public String getInstituteName(String code)
    {
        Institute institute = instituteManager.getByCode(code);

        return institute!=null?instituteManager.getByCode(code).getName():"";
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.InstituteWebService#getInstitutes()
     */
    public List<InstituteDTO> getInstitutes()
    {
        List<Institute> institutes = instituteManager.getAll();
        List<InstituteDTO> instituteDtos = Lists.newArrayList();
        for(Institute institute:institutes){
            instituteDtos.add(new InstituteDTO(institute.getCode(),institute.getName()));
        }
        return instituteDtos;
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.InstituteWebService#getInstituteCode(java.lang.String)
     */
    public String getInstituteCode(String name)
    {
        List<Institute> list = instituteManager.getAll();
        for(Institute obj:list){
            if(obj.getName().equals(name))
            {
                return obj.getCode();
            }
        }
        return "";
    }



}
