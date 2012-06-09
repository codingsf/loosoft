/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;

import org.jasig.cas.CentralAuthenticationService;
import org.jasig.cas.web.support.CookieRetrievingCookieGenerator;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.webflow.execution.RequestContext;

import cn.common.lib.util.http.HttpClientUtil;

/**
 * Controller to delete ticket granting ticket cookie in order to log out of
 * single sign on. This controller implements the idea of the ESUP Portail's
 * Logout patch to allow for redirecting to a url on logout. It also exposes a
 * log out link to the view via the WebConstants.LOGOUT constant.
 * 
 * @author Scott Battaglia
 * @version $Revision: 19533 $ $Date: 2009-12-14 23:33:36 -0500 (Mon, 14 Dec 2009) $
 * @since 3.0
 */
public final class LogoutController extends AbstractController {

    /** The CORE to which we delegate for all CAS functionality. */
    @NotNull
    private CentralAuthenticationService centralAuthenticationService;

    /** CookieGenerator for TGT Cookie */
    @NotNull
    private CookieRetrievingCookieGenerator ticketGrantingTicketCookieGenerator;

    /** CookieGenerator for Warn Cookie */
    @NotNull
    private CookieRetrievingCookieGenerator warnCookieGenerator;

    /** CookieGenerator for the action session. */
    @NotNull
    private CookieRetrievingCookieGenerator sessionCookieGenerator;
    
    /** Logout view name. */
    @NotNull
    private String logoutView;

    /**
     * Boolean to determine if we will redirect to any url provided in the
     * service request parameter.
     */
    private boolean followServiceRedirects;
    
    public LogoutController() {
        setCacheSeconds(0);
    }

    protected ModelAndView handleRequestInternal(
        final HttpServletRequest request, final HttpServletResponse response)
        throws Exception {
        final String ticketGrantingTicketId = this.ticketGrantingTicketCookieGenerator.retrieveCookieValue(request);
        final String service = request.getParameter("service");

        if (ticketGrantingTicketId != null) {
            this.centralAuthenticationService
                .destroyTicketGrantingTicket(ticketGrantingTicketId);
            
            this.ticketGrantingTicketCookieGenerator.removeCookie(response);
            this.warnCookieGenerator.removeCookie(response);
        }

        if (this.followServiceRedirects && service != null) {
            return new ModelAndView(new RedirectView(service));
        }
        //add by qhb in 2010.12.03 for 退出后更新主动登录
        //handleActiveMake(request,response);
        return new ModelAndView(this.logoutView);
    }
    
    /**
     * 处理各个应用端主动登录标识
     * 格式 [appservice url:sessionid,appservice url:sessionid]
     * @param context
     */
    private void handleActiveMake(final HttpServletRequest request,final HttpServletResponse response){
        //通知app端清除标识
    	String cookieValue = sessionCookieGenerator.retrieveCookieValue(request);
    	if(!StringUtils.hasText(cookieValue))return;
    	
    	String[] valueArr = cookieValue.split(",");
    	for(int i=0;i<valueArr.length;i++){
    		String[] eachValue = valueArr[i].split("::");
    		String serviceUrl = eachValue[0];
    		if(StringUtils.hasText(serviceUrl)){
    			HttpClientUtil.post(serviceUrl, "sessionId="+eachValue[1], "post");
    		}
    	}
        //add by qianhb for write active login session cookie in 2010/12/03
    	//退出不用清理主动登录cookie
    	//sessionCookieGenerator.removeCookie(response);
    }

    /**
     * 清除主动登录的session idcookie
     * @author houbing.qian
     * @since 1.0 2010/12/03
     * @param sessionCookieGenerator
     */
     public void setSessionCookieGenerator(
             final CookieRetrievingCookieGenerator sessionCookieGenerator) {
             this.sessionCookieGenerator = sessionCookieGenerator;
     }
     
    public void setTicketGrantingTicketCookieGenerator(
        final CookieRetrievingCookieGenerator ticketGrantingTicketCookieGenerator) {
        this.ticketGrantingTicketCookieGenerator = ticketGrantingTicketCookieGenerator;
    }

    public void setWarnCookieGenerator(final CookieRetrievingCookieGenerator warnCookieGenerator) {
        this.warnCookieGenerator = warnCookieGenerator;
    }

    /**
     * @param centralAuthenticationService The centralAuthenticationService to
     * set.
     */
    public void setCentralAuthenticationService(
        final CentralAuthenticationService centralAuthenticationService) {
        this.centralAuthenticationService = centralAuthenticationService;
    }

    public void setFollowServiceRedirects(final boolean followServiceRedirects) {
        this.followServiceRedirects = followServiceRedirects;
    }

    public void setLogoutView(final String logoutView) {
        this.logoutView = logoutView;
    }
}
