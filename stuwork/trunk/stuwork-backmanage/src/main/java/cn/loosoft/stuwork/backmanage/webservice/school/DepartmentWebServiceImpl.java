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

import cn.loosoft.data.webservice.api.school.DepartmentWebService;
import cn.loosoft.data.webservice.api.school.dto.DepartmentDTO;
import cn.loosoft.stuwork.backmanage.entity.school.Department;
import cn.loosoft.stuwork.backmanage.service.school.DepartmentManager;

import com.google.common.collect.Lists;

/**
 * 系的webservice实现类
 * 使用@WebService指向Interface定义类即可. 
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-21
 */
//Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.school.DepartmentWebService") 
public class DepartmentWebServiceImpl implements DepartmentWebService
{
    @Autowired
    private DepartmentManager departmentManager;

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.DepartmentWebService#getDepartmentsByInstitute(java.lang.String)
     */
    public List<DepartmentDTO> getDepartmentsByInstitute(String instituteCode)
    {
        List<Department> departmentList = departmentManager.getDepartmentsByInstitute(instituteCode);
        List<DepartmentDTO> dtoList = Lists.newArrayList();
        for(Department department:departmentList){
            dtoList.add(new DepartmentDTO(department.getCode(),department.getName()));
        }
        return dtoList;
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.DepartmentWebService#getDepartmentName(java.lang.String)
     */
    public String getDepartmentName(String code){
        List<Department> departmentList = departmentManager.getAll();
        for(Department department:departmentList){
            if(department.getCode().equals(code))
            {
                return department.getName();
            }
        }
        return "";
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-22
     * @see cn.loosoft.data.webservice.api.school.DepartmentWebService#getDepartmentCode(java.lang.String)
     */
    public String getDepartmentCode(String name)
    {
        List<Department> departmentList = departmentManager.getAll();
        for(Department department:departmentList){
            if(department.getName().equals(name))
            {
                return department.getCode();
            }
        }
        return "";
    }
}
