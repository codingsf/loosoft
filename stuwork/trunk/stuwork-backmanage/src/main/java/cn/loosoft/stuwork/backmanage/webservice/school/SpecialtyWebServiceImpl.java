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

import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.backmanage.service.school.SpecialtyManager;

import com.google.common.collect.Lists;

/**
 * 专业的webservice实现类
 * 使用@WebService指向Interface定义类即可. 
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-21
 */
//Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.school.SpecialtyWebService") 
public class SpecialtyWebServiceImpl implements SpecialtyWebService
{
    @Autowired
    private SpecialtyManager specialtyManager;

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.SpecialtyWebService#getSpecialtyName(java.lang.String)
     */
    public String getSpecialtyName(String code)
    {
        List<Specialty> specialtyList = specialtyManager.getAll();
        for(Specialty specialty:specialtyList){
            if(specialty.getCode().equals(code))
            {
                return specialty.getName();
            }
        }
        return "";
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.SpecialtyWebService#getSpecialtysByDepartment(java.lang.String)
     */
    public List<SpecialtyDTO> getSpecialtysByDepartment(String departmentCode)
    {
        List<Specialty> specialtyList = specialtyManager.getSpecialtysByDepartment(departmentCode);
        List<SpecialtyDTO> dtoList = Lists.newArrayList();
        for(Specialty specialty:specialtyList){
            SpecialtyDTO specialtyDTO = new SpecialtyDTO(specialty.getCode(),specialty.getName());
            specialtyDTO.setCollegeCode(specialty.getDepartment().getInstitute().getCode());
            specialtyDTO.setCollegeName(specialty.getDepartment().getInstitute().getName());
            specialtyDTO.setDepartCode(specialty.getDepartment().getCode());
            specialtyDTO.setDepartName(specialty.getDepartment().getName());
            dtoList.add(specialtyDTO);
        }
        return dtoList;
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-28
     * @see cn.loosoft.data.webservice.api.school.SpecialtyWebService#getSpecialtysByCollege(java.lang.String)
     */
    public List<SpecialtyDTO> getSpecialtysByCollege(String collegeCode)
    {
        List<Specialty> specialtyList = specialtyManager.getSpecialtysByCollege(collegeCode);
        List<SpecialtyDTO> dtoList = Lists.newArrayList();
        for(Specialty specialty:specialtyList){
            SpecialtyDTO specialtyDTO = new SpecialtyDTO(specialty.getCode(),specialty.getName());
            specialtyDTO.setCollegeCode(specialty.getInstitute().getCode());
            specialtyDTO.setCollegeName(specialty.getInstitute().getName());
            specialtyDTO.setDepartCode(specialty.getDepartCode());
            specialtyDTO.setDepartName(specialty.getDepartName());
            dtoList.add(specialtyDTO);
        }
        return dtoList;
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.SpecialtyWebService#getSpecialtyCode(java.lang.String)
     */
    public String getSpecialtyCode(String name)
    {
        List<Specialty> list = specialtyManager.getAll();
        for(Specialty obj:list){
            if(obj.getName().equals(name))
            {
                return obj.getCode();
            }
        }
        return "";
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-25
     * @see cn.loosoft.data.webservice.api.school.SpecialtyWebService#getSpecialtys()
     */
    public List<SpecialtyDTO> getSpecialtys()
    {
        boolean isAsc = true;
        List<Specialty> specialtyList = specialtyManager.getAll("code", isAsc);
        List<SpecialtyDTO> dtoList = Lists.newArrayList();
        for(Specialty specialty:specialtyList){
            SpecialtyDTO specialtyDTO = new SpecialtyDTO(specialty.getCode(),specialty.getName());
            specialtyDTO.setCollegeCode(specialty.getInstitute().getCode());
            specialtyDTO.setCollegeName(specialty.getInstitute().getName());
            specialtyDTO.setDepartCode(specialty.getDepartCode());
            specialtyDTO.setDepartName(specialty.getDepartName());
            dtoList.add(specialtyDTO);
        }
        return dtoList;
    }

}
