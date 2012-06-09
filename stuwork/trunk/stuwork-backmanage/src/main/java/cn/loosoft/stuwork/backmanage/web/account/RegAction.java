//-------------------------------------------------------------------------
// Copyright (c) 2009-2012 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
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
package cn.loosoft.stuwork.backmanage.web.account;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.account.User;
import cn.loosoft.stuwork.backmanage.service.account.AccountManager;

/**
 * 
 * Register Action
 *
 * @author            chengpeng.zhang
 * @version           1.0
 * @since             2010-5-20
 */
@Namespace("/")
public class RegAction extends CrudActionSupport<User> {
    private static final long serialVersionUID = -4272173850447233784L;

    private static Logger logger = LoggerFactory.getLogger(RegAction.class);

    //-- 页面属性 --//
    private Long id;
    private User entity;
    @Autowired
    private AccountManager accountManager;
    @Autowired
    private UserDetailsService userDetailsService;

    public void setId(Long id) {
        this.id = id;
    }

    public void setEntity(User entity) {
        this.entity = entity;
    }

    public void setAccountManager(AccountManager accountManager) {
        this.accountManager = accountManager;
    }

    @Override
    public String input() throws Exception {
        return null;
    }

    @Override
    public String list() throws Exception {
        return "";
    }

    @Override
    protected void prepareModel() throws Exception {
        if (id != null) {
            entity = accountManager.getUser(id);
        } else {
            entity = new User();
        }
    }

    @Override
    /**
     * 注册成功后，自动登录
     */
    public String save() throws Exception {
        try{
            entity.setCreateDate(new Date());
            entity.getRoleList().add(accountManager.getRole(2L));//固定id 为2
            accountManager.saveUser(entity);
            //自动登录
            String loginName = entity.getLoginName();
            if(!StringUtils.isEmpty(loginName)){		
                //对评论用户进行自动登录
                UserDetails userDetails = userDetailsService.loadUserByUsername(loginName);
                if (userDetails == null) {
                    throw new RuntimeException("用户" + loginName + "不存在");
                }
                SpringSecurityUtils.saveUserDetailsToContext(userDetails, Struts2Utils.getRequest());
            }
            HttpServletResponse response = ServletActionContext.getResponse();
            response.sendRedirect("");
            return null;
        }catch(Exception e){
            logger.debug(e.getMessage());
            return INPUT;
        }
    }

    public User getModel() {
        return this.entity;
    }
}
