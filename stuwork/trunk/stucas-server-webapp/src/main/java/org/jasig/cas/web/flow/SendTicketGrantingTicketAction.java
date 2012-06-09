/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.web.flow;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;

import org.jasig.cas.CentralAuthenticationService;
import org.jasig.cas.util.HttpClient;
import org.jasig.cas.web.support.CookieRetrievingCookieGenerator;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.util.StringUtils;
import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

import cn.common.lib.util.http.HttpClientUtil;

/**
 * Action that handles the TicketGrantingTicket creation and destruction. If the
 * action is given a TicketGrantingTicket and one also already exists, the old
 * one is destroyed and replaced with the new one. This action always returns
 * "success".
 * 
 * @author Scott Battaglia
 * @version $Revision: 19533 $ $Date: 2009-12-14 23:33:36 -0500 (Mon, 14 Dec 2009) $
 * @since 3.0.4
 */
public final class SendTicketGrantingTicketAction extends AbstractAction {
    
    @NotNull
    private CookieRetrievingCookieGenerator ticketGrantingTicketCookieGenerator;
    
    /** CookieGenerator for the action session. */
    @NotNull
    private CookieRetrievingCookieGenerator sessionCookieGenerator;
    
    /** Instance of CentralAuthenticationService. */
    @NotNull
    private CentralAuthenticationService centralAuthenticationService;
    
    protected Event doExecute(final RequestContext context) {
        final String ticketGrantingTicketId = WebUtils.getTicketGrantingTicketId(context); 
        final String ticketGrantingTicketValueFromCookie = (String) context.getFlowScope().get("ticketGrantingTicketId");
        
        if (ticketGrantingTicketId == null) {
            return success();
        }
        
        this.ticketGrantingTicketCookieGenerator.addCookie(WebUtils.getHttpServletRequest(context), WebUtils
            .getHttpServletResponse(context), ticketGrantingTicketId);

        if (ticketGrantingTicketValueFromCookie != null && !ticketGrantingTicketId.equals(ticketGrantingTicketValueFromCookie)) {
            this.centralAuthenticationService
                .destroyTicketGrantingTicket(ticketGrantingTicketValueFromCookie);
        }
        
        //add by qianhb for handle active make in every application in 2010/12/03
        handleActiveMake(context);
        
        return success();
    }
    
    /**
     * 处理各个应用端主动登录标识
     * 格式 [appservice url:sessionid,appservice url:sessionid]
     * @param context
     */
    private void handleActiveMake(final RequestContext context){
    	HttpServletRequest request = WebUtils.getHttpServletRequest(context);
    	HttpServletResponse response = WebUtils.getHttpServletResponse(context);
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
    	sessionCookieGenerator.removeCookie(response);
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
    
    public void setTicketGrantingTicketCookieGenerator(final CookieRetrievingCookieGenerator ticketGrantingTicketCookieGenerator) {
        this.ticketGrantingTicketCookieGenerator= ticketGrantingTicketCookieGenerator;
    }
    
    public void setCentralAuthenticationService(
        final CentralAuthenticationService centralAuthenticationService) {
        this.centralAuthenticationService = centralAuthenticationService;
    }
}
