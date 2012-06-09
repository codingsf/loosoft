/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.web.flow;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.jasig.cas.authentication.principal.Service;
import org.jasig.cas.web.support.ArgumentExtractor;
import org.jasig.cas.web.support.CookieRetrievingCookieGenerator;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.util.StringUtils;
import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

/**
 * Class to automatically set the paths for the CookieGenerators.
 * <p>
 * Note: This is technically not threadsafe, but because its overriding with a
 * constant value it doesn't matter.
 * <p>
 * Note: As of CAS 3.1, this is a required class that retrieves and exposes the
 * values in the two cookies for subclasses to use.
 * 
 * @author Scott Battaglia
 * @version $Revision: 19533 $ $Date: 2009-12-14 23:33:36 -0500 (Mon, 14 Dec 2009) $
 * @since 3.1
 */
public final class InitialFlowSetupAction extends AbstractAction {

	//应用端主动登录标记清楚path add by qianhb in 2010/12/03
	private String DEFAULTACTIVEADVICEPATH = "clear_active";
	
    /** CookieGenerator for the Warnings. */
    @NotNull
    private CookieRetrievingCookieGenerator warnCookieGenerator;

    /** CookieGenerator for the TicketGrantingTickets. */
    @NotNull
    private CookieRetrievingCookieGenerator ticketGrantingTicketCookieGenerator;
    
    /** CookieGenerator for the action session. */
    @NotNull
    private CookieRetrievingCookieGenerator sessionCookieGenerator;

    /** Extractors for finding the service. */
    @NotNull
    @Size(min=1)
    private List<ArgumentExtractor> argumentExtractors;

    /** Boolean to note whether we've set the values on the generators or not. */
    private boolean pathPopulated = false;

    protected Event doExecute(final RequestContext context) throws Exception {
        final HttpServletRequest request = WebUtils.getHttpServletRequest(context);
        if (!this.pathPopulated) {
            final String contextPath = context.getExternalContext().getContextPath();
            final String cookiePath = StringUtils.hasText(contextPath) ? contextPath : "/";
            logger.info("Setting path for cookies to: "
                + cookiePath);
            this.warnCookieGenerator.setCookiePath(cookiePath);
            this.ticketGrantingTicketCookieGenerator.setCookiePath(cookiePath);
            this.pathPopulated = true;
        }

        context.getFlowScope().put(
            "ticketGrantingTicketId", this.ticketGrantingTicketCookieGenerator.retrieveCookieValue(request));
        context.getFlowScope().put(
            "warnCookieValue",
            Boolean.valueOf(this.warnCookieGenerator.retrieveCookieValue(request)));

        final Service service = WebUtils.getService(this.argumentExtractors,
            context);

        if (service != null && logger.isDebugEnabled()) {
            logger.debug("Placing service in FlowScope: " + service.getId());
        }

        context.getFlowScope().put("service", service);
        
        //add by qianhb for write active login session cookie in 2010/12/03
        writeSessionCookie(request, WebUtils.getHttpServletResponse(context),service.getId());
        
        return result("success");
    }

    /**
     * 记录主动登录sessionid到cookie
     * 格式 [appservice url:sessionid,appservice url:sessionid]
     * @author houbing.qian
     * @since 1.0 2010/12/03
     * @param request
     * @param response
     */
    private void writeSessionCookie(HttpServletRequest request, HttpServletResponse response,String serviceUrl){
    	String value = sessionCookieGenerator.retrieveCookieValue(request);
    	String curSessionId = request.getParameter("sessionId");
    	if(!StringUtils.hasText(curSessionId))return;//没有sessionid，表示不是主动登录，不记录主动登录sessionid
    	String tgtcookie = this.ticketGrantingTicketCookieGenerator.retrieveCookieValue(request);
    	if(StringUtils.hasText(tgtcookie))return;//有票据则不记录主动登录sessionid，因为登录能够成功
    	String newServiceUrl = serviceUrl.substring(0,serviceUrl.lastIndexOf("/"))+"/"+DEFAULTACTIVEADVICEPATH;
    	String curCookieValue = newServiceUrl+"::"+curSessionId;
    	String newCookieValue = value==null?curCookieValue:value+","+curCookieValue;
    	sessionCookieGenerator.addCookie(response, newCookieValue);
    }
    
    public void setTicketGrantingTicketCookieGenerator(
        final CookieRetrievingCookieGenerator ticketGrantingTicketCookieGenerator) {
        this.ticketGrantingTicketCookieGenerator = ticketGrantingTicketCookieGenerator;
    }
    
    /**
    * 记录主动登录的session id
    * @author houbing.qian
    * @since 1.0 2010/12/03
    * @param sessionCookieGenerator
    */
    public void setSessionCookieGenerator(
            final CookieRetrievingCookieGenerator sessionCookieGenerator) {
            this.sessionCookieGenerator = sessionCookieGenerator;
    }

    public void setWarnCookieGenerator(final CookieRetrievingCookieGenerator warnCookieGenerator) {
        this.warnCookieGenerator = warnCookieGenerator;
    }

    public void setArgumentExtractors(
        final List<ArgumentExtractor> argumentExtractors) {
        this.argumentExtractors = argumentExtractors;
    }
}
