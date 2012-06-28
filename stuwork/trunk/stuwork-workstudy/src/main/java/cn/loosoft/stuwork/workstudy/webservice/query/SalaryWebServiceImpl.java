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

import cn.loosoft.data.webservice.api.query.SalaryWebService;
import cn.loosoft.data.webservice.api.query.dto.SalaryDTO;
import cn.loosoft.stuwork.workstudy.entity.salary.Salary;
import cn.loosoft.stuwork.workstudy.service.salary.SalaryManager;

import com.google.common.collect.Lists;

//Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.query.SalaryWebService")
public class SalaryWebServiceImpl implements SalaryWebService
{
    @Autowired
    private SalaryManager salaryManager;

    /**
     * 根据考生号查询学生工资信息，并分页 Description of this Method
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param studentNo
     * @param pageNo
     * @return
     */
    public List<SalaryDTO> getSalaryByExamineeNo(String studentNo, int pageNo)
    {
        List<Salary> salaryList = salaryManager.getSalaryByStudentNo(
        		studentNo, pageNo);
        return convertToDTO(salaryList);
    }

    /**
     * 把Salary对象转换成SalaryDTO对象 并返回list<SalaryDTO>
     * 
     * @since 2011-4-18
     * @author bing.hu
     * @param salaryList
     * @return
     */
    public List<SalaryDTO> convertToDTO(List<Salary> salaryList)
    {
        SalaryDTO salaryDTO = null;
        List<SalaryDTO> salaryDTOList = Lists.newArrayList();
        for (int i = 0; i < salaryList.size(); i++)
        {
            salaryDTO = new SalaryDTO();
            salaryDTO.setId(salaryList.get(i).getId());
            salaryDTO.setStudentName(salaryList.get(i).getStudentName());
            salaryDTO.setStudentNo(salaryList.get(i).getStudentNo());
            salaryDTO.setPostName(salaryList.get(i).getPostName());
            salaryDTO.setCompanyName(salaryList.get(i).getCompanyName());
            salaryDTO.setWorkStartTime(salaryList.get(i).getWorkStartTime());
            salaryDTO.setWorkStopTime(salaryList.get(i).getWorkStopTime());
            salaryDTO.setWorkTime(salaryList.get(i).getWorkTime());
            salaryDTO.setStandard(salaryList.get(i).getStandard());
            salaryDTO.setAmount(salaryList.get(i).getAmount());
            salaryDTOList.add(salaryDTO);

        }
        return salaryDTOList;

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-19
     * @see cn.loosoft.data.webservice.api.query.SalaryWebService#getAllSalaryCount(java.lang.String)
     */
    public int getAllSalaryCount(String studentNo)
    {
        // TODO Auto-generated method stub
        return salaryManager.getByStudentNo(studentNo).size();
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-19
     * @see cn.loosoft.data.webservice.api.query.SalaryWebService#getSalaryById(java.lang.Long)
     */
    public SalaryDTO getSalaryById(Long id)
    {
        SalaryDTO salaryDTO = null;
        if (id != null)
        {
            Salary salary = salaryManager.getSalaryById(id);
            if (salary != null)
            {
                salaryDTO = new SalaryDTO(salary.getId(), salary.getPostName(),
                        salary.getCompanyName(), salary.getStudentNo(), salary
                                .getStudentName(), salary.getStandard(), salary
                                .getWorkStartTime(), salary.getWorkStopTime(),
                        salary.getCreateDate(), salary.getWorkTime(), salary
                                .getAmount(), salary.getGroupStatus(), salary
                                .getCenterStatus(), salary
                                .getGroupNoPassReason(), salary
                                .getCenterNoPassReason(), salary.getBankName(),
                        salary.getBankAccount(), salary.getComments(), salary
                                .getRemark());

                return salaryDTO;
            }
        }
        return salaryDTO;
    }
}
