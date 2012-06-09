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

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.account.User;
import cn.loosoft.stuwork.backmanage.service.account.AccountManager;
import cn.loosoft.stuwork.backmanage.service.mail.SimpleMailService;

/**
 * 
 * Register Action
 *
 * @author            chengpeng.zhang
 * @version           1.0
 * @since             2010-5-20
 */
@Namespace("/")
@Results( { @Result(name = "success", location = "success.jsp")})
public class ForgetpasswordAction extends CrudActionSupport<Object> {
    private static final long serialVersionUID = -4272173850447233784L;
    private static Logger logger = LoggerFactory.getLogger(ForgetpasswordAction.class);
    @Autowired
    private SimpleMailService service;
    @Autowired
    private AccountManager accountManager;

    public void setAccountManager(AccountManager accountManager) {
        this.accountManager = accountManager;
    }

    public void setService(SimpleMailService service) {
        this.service = service;
    }

    @Override
    public String input() throws Exception {
        HttpServletRequest request = Struts2Utils.getRequest();
        String username = ParamUtils.getParameter(request, "username");
        Pattern pattern = Pattern.compile("\\w(\\.\\w)*@\\w(\\.\\w)+");
        User user = null;
        if(pattern.matcher(username).matches()){
            user = accountManager.findUserByEmail(username);
        }else{
            user = accountManager.findUserByLoginName(username);
        }
        if(null == user){
            request.setAttribute("username", username);
            return INPUT;
        }
        service.sendNotificationMail(user.getName(),user.getPassword(),user.getEmail());
        return "success";
    }

    /**
     * 调到忘记密码页面
     * @return
     * @throws Exception
     */
    @Override
    public String list() throws Exception {
        return INPUT;
    }

    @Override
    protected void prepareModel() throws Exception {

    }

    @Override
    public String save() throws Exception {
        return null;
    }

    public Object getModel() {
        return null;
    }
}
