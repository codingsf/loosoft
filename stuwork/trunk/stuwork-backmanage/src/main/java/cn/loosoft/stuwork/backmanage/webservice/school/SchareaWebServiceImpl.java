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

import cn.loosoft.data.webservice.api.school.SchareaWebService;
import cn.loosoft.data.webservice.api.school.dto.SchareaDTO;
import cn.loosoft.stuwork.backmanage.entity.school.Scharea;
import cn.loosoft.stuwork.backmanage.service.school.SchareaManager;

import com.google.common.collect.Lists;

/**
 * 校区的webservice实现类
 * 使用@WebService指向Interface定义类即可. 
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-21
 */
//Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.school.SchareaWebService") 
public class SchareaWebServiceImpl implements SchareaWebService
{
    @Autowired
    private SchareaManager schareaManager;

    /**
     * 
     * 取得所有学区
     * @since  2010-8-21
     * @author houbing.qian
     * @return
     */
    public List<SchareaDTO> getSchareas(){
        List<Scharea> schareaList = schareaManager.getAll();
        List<SchareaDTO> sdtoList = Lists.newArrayList();
        for(Scharea scharea:schareaList){
            sdtoList.add(new SchareaDTO(scharea.getCode(),scharea.getName(),scharea.getAddress()));
        }
        return sdtoList;
    }

    /**
     * 
     * 根据学区代码取得名称
     * @since  2010-8-21
     * @author houbing.qian
     * @param code
     * @return
     */
    public String getSchareaName(String code){
        List<Scharea> schareaList = schareaManager.getAll();
        for(Scharea scharea:schareaList){
            if(scharea.getCode().equals(code))
            {
                return scharea.getName();
            }
        }
        return "";
    }

    /**
     * {@inheritDoc}
     * @since  2010-8-29
     * @see cn.loosoft.data.webservice.api.school.SchareaWebService#getCode(java.lang.String)
     */
    public String getCode(String name)
    {
        List<Scharea> schareaList = schareaManager.getAll();
        for(Scharea scharea:schareaList){
            if(scharea.getName().equals(name))
            {
                return scharea.getCode();
            }
        }
        return "";
    }

    public SchareaDTO getScharea(String code)
    {
        List<Scharea> schareaList = schareaManager.getAll();
        for(Scharea scharea:schareaList){
            if(scharea.getCode().equals(code))
            {
                return new SchareaDTO(code, scharea.getName(),scharea.getAddress());
            }
        }
        return null;
    }


}
