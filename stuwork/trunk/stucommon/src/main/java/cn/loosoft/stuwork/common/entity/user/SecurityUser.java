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
package cn.loosoft.stuwork.common.entity.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.common.vo.LabelValue;



/**
 * stuwork项目扩展权限用户
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-28
 */

public class SecurityUser extends User
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private String departCode;//系代码

    private String departName;//系名称

    private String collegeCode;//学院代码

    private String collegeName;//学院名称

    //班级列表
    private List<LabelValue> clazzs= new ArrayList<LabelValue>();

    public SecurityUser(String username, String password, boolean enabled, boolean accountNonExpired,
            boolean credentialsNonExpired, boolean accountNonLocked, Collection<GrantedAuthority> authorities,String name) 
    {
        super(username, password, enabled, accountNonExpired,credentialsNonExpired, accountNonLocked, authorities,name);
    }

    public SecurityUser(User user,String departCode,String departName,String collegeCode,String collegeName){
        this(user.getUsername(),user.getPassword(),user.isEnabled(),user.isAccountNonExpired(),user.isCredentialsNonExpired(),user.isAccountNonLocked(),user.getAuthorities(),user.getName());
        this.departCode = departCode;
        this.departName = departName;
        this.collegeCode = collegeCode;
        this.collegeName = collegeName;
    }

    public String getDepartCode()
    {
        return departCode;
    }

    public void setDepartCode(String departCode)
    {
        this.departCode = departCode;
    }

    public String getDepartName()
    {
        return departName;
    }

    public void setDepartName(String departName)
    {
        this.departName = departName;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }

    public List<LabelValue> getClazzs()
    {
        return clazzs;
    }

    public void setClazzs(List<LabelValue> clazzs)
    {
        this.clazzs = clazzs;
    }

}
