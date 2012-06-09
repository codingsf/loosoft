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
package cn.loosoft.stuwork.backmanage.webservice.user;

import java.util.List;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.user.UserWebService;
import cn.loosoft.data.webservice.api.user.dto.AuthorityDTO;
import cn.loosoft.data.webservice.api.user.dto.RoleDTO;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.stuwork.backmanage.entity.account.Authority;
import cn.loosoft.stuwork.backmanage.entity.account.Role;
import cn.loosoft.stuwork.backmanage.entity.account.User;
import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.service.account.AccountManager;

import com.google.common.collect.Lists;

/**
 * 用户的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-27
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.user.UserWebService")
public class UserWebServiceImpl implements UserWebService
{

    @Autowired
    private AccountManager accountManager;

    /**
     * {@inheritDoc}
     * 
     * @since 2010-8-27
     * @see cn.loosoft.data.webservice.api.user.UserWebService#getUser(java.lang.String)
     */
    public UserDTO getUser(String loginName)
    {
        User user = accountManager.getUser(loginName);

        // convert user to dto
        return this.convertToDTO(user);
    }

    /**
     * 将User对象转成成UserDTO对象
     * 
     * @since 2010-8-27
     * @author houbing.qian
     * @param user
     * @return
     */
    @Transactional(readOnly = true)
    private UserDTO convertToDTO(User user)
    {
        if (user == null)
        {
            return null;
        }
        UserDTO userDTO = new UserDTO();
        userDTO.setLoginName(user.getLoginName());
        userDTO.setName(user.getName());
        userDTO.setExamineeNo(user.getExamineeNo());
        userDTO.setCollegeCode(user.getInstituteCode());
        userDTO.setCollegeName(user.getInstituteName());
        userDTO.setMajorName(user.getSpecialtyName());
        userDTO.setClassCode(user.getClazzCode());
        userDTO.setMajorCode(user.getSpecialtyCode());
        userDTO.setDepartCode(user.getDepartmentCode());
        userDTO.setDepartName(user.getDepartmentName());
        userDTO.setPassword(user.getPassword());

        // SET ROLELIST
        List<Role> roleList = user.getRoleList();
        RoleDTO roleDTO = null;
        List<RoleDTO> roleDTOs = Lists.newArrayList();
        for (Role role : roleList)
        {
            roleDTO = new RoleDTO();
            roleDTO.setName(role.getName());
            roleDTO.setAuthNames(role.getAuthNames());
            // set authority
            AuthorityDTO authorityDTO = null;
            List<AuthorityDTO> authorityDTOs = Lists.newArrayList();
            for (Authority authority : role.getAuthorityList())
            {
                authorityDTO = new AuthorityDTO();
                authorityDTO.setPrefixedName(authority.getPrefixedName());
                authorityDTOs.add(authorityDTO);
            }
            roleDTO.setAuthorityList(authorityDTOs);

            roleDTOs.add(roleDTO);
        }

        // set clazz
        ClazzDTO clazzDTO = null;
        List<ClazzDTO> clazzDTOs = Lists.newArrayList();
        for (Clazz clazz : user.getClazzList())
        {
            clazzDTO = new ClazzDTO(clazz.getCode(), clazz.getName());
            clazzDTOs.add(clazzDTO);
        }
        userDTO.setClazzList(clazzDTOs);

        userDTO.setRoleList(roleDTOs);

        return userDTO;
    }
}
