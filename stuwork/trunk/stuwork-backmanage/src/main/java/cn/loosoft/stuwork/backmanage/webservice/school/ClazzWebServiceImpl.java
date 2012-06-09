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

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.jws.WebService;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.stuwork.backmanage.dao.school.SpecialtyDao;
import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.backmanage.service.school.ClazzManager;

import com.google.common.collect.Lists;

/**
 * 班级的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-21
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.school.ClazzWebService")
public class ClazzWebServiceImpl implements ClazzWebService
{
    @Autowired
    private ClazzManager clazzManager;

    @Autowired
    private SpecialtyDao specialtyDao;

    /**
     * {@inheritDoc}
     * 
     * @since 2010-8-22
     * @see cn.loosoft.data.webservice.api.school.ClazzWebService#getClazzName(java.lang.String)
     */
    public String getClazzName(String code)
    {
        List<Clazz> clazzList = clazzManager.getAll();
        for (Clazz clazz : clazzList)
        {
            if (clazz.getCode().equals(code))
            {
                return clazz.getName();
            }
        }
        return "";
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-8-22
     * @see cn.loosoft.data.webservice.api.school.ClazzWebService#getClazzsBySpecialty(java.lang.String,
     *      java.lang.String, java.lang.String)
     */
    public List<ClazzDTO> getClazzsBySpecialty(String specialtyCode,
            String type, String year, String season)
    {
        List<Clazz> clazzList = clazzManager.getClazzsBySpecialty(
                specialtyCode, type, year, season);
        List<ClazzDTO> dtoList = Lists.newArrayList();
        for (Clazz clazz : clazzList)
        {
            dtoList.add(new ClazzDTO(clazz.getCode(), clazz.getName()));
        }
        return dtoList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-8-22
     * @see cn.loosoft.data.webservice.api.school.ClazzWebService#getClazzCodeByName(java.lang.String,
     *      java.lang.String, java.lang.String)
     */
    public String getClazzCodeByName(String name, String type, String year,
            String season)
    {
        name = name.trim();
        Clazz clazz = clazzManager.getClazzByName(name, type, year, season);
        return clazz != null ? clazz.getCode() : "";
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-8-25
     * @see cn.loosoft.data.webservice.api.school.ClazzWebService#saveClazzs(java.util.List)
     */
    public String saveClazzs(List<ClazzDTO> clazzs)
    {
        if (clazzs != null && !clazzs.isEmpty())
        {

            Clazz clazz = null;
            Specialty specialty = null;
            for (ClazzDTO clazzDTO : clazzs)
            {
                // 先判断班级是否存在
                clazz = clazzManager.getByCode(clazzDTO.getCode());
                if (clazz == null || clazz.getId() == null)
                {
                    clazz = new Clazz();
                }

                if (specialty == null)
                {
                    specialty = specialtyDao.getByCode(clazzDTO.getMajorCode());
                }
                try
                {
                    BeanUtils.copyProperties(clazz, clazzDTO);
                }
                catch (IllegalAccessException e)
                {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                catch (InvocationTargetException e)
                {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

                clazz.setSpecialty(specialty);
                try
                {
                    clazzManager.save(clazz);
                }
                catch (Exception e)
                {
                    // TODO: handle exception
                }
            }
        }
        return "success";
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-8-25
     * @see cn.loosoft.data.webservice.api.school.ClazzWebService#getClazzStrBySpecialty(java.lang.String,
     *      java.lang.String, java.lang.String)
     */
    public String getClazzStrBySpecialty(String specialtyCode, String type,
            String year, String season)
    {
        List<Clazz> clazzList = clazzManager.getClazzsBySpecialty(
                specialtyCode, type, year, season);
        StringBuilder sb = new StringBuilder();
        for (Clazz clazz : clazzList)
        {
            sb.append("," + clazz.getName());
        }
        return sb.length() > 0 ? sb.substring(1) : "";
    }

}
