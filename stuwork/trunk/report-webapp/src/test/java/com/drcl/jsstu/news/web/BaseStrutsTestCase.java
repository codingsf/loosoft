//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
//
//-------------------------------------------------------------------------
// UFINITY MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
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

package com.drcl.jsstu.news.web;

import java.io.File;
import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.StrutsTestCase;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.mock.web.MockPageContext;
import org.springframework.mock.web.MockServletContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionProxy;

/**
 * 
 * Base test case for JUnit testing Struts,extend the org.apache.struts2.StrutsTestCase
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-5-24
 */
public abstract class BaseStrutsTestCase extends StrutsTestCase {
    //add MockHttpSession to ActionContext
    protected MockHttpSession httpSession;

    /**
     * get map from session
     * @since  2010-5-24
     * @author houbing.qian
     * @param httpSession
     * @return
     */
    private Map<String,Object> getSessionMap(MockHttpSession httpSession){
        Map<String,Object> sessionMap = new HashMap<String,Object>();
        
        Enumeration<String> attrEnum = httpSession.getAttributeNames();
        while(attrEnum.hasMoreElements()){
            String tmp = attrEnum.nextElement();
            sessionMap.put(tmp, httpSession.getAttribute(tmp));
        }
        return sessionMap;
    }


   /**
    * add and reset about configuration in parent Test case 
    * {@inheritDoc}
    * @since  2010-5-24
    * @author houbing.qian
    * @see org.apache.struts2.StrutsTestCase#setUp()
    */
    protected void setUp() throws Exception {
        super.setUp();
    }
    
    @Override
    protected ActionProxy getActionProxy(String uri) {
        ActionProxy proxy = super.getActionProxy(uri);
        //add session to ActionContext
        ActionContext.getContext().setSession(getSessionMap(httpSession));
        return proxy;
    }
    
    @Override
    protected void initServletMockObjects() {
        System.out.println(resourceLoader.getClassLoader().getResource(""));
        String webappPath = getResourceUrlPath(resourceLoader.getClassLoader().getResource(""));
        //modify new MockServletContext(resourceLoader) to new MockServletContext(webappPath,resourceLoader) to pointed webapp position
        servletContext = new MockServletContext(webappPath,resourceLoader);        
        response = new MockHttpServletResponse();
        request = new MockHttpServletRequest(servletContext);
        //add session mock for add to actionContext
        httpSession = (MockHttpSession)request.getSession();
        pageContext = new MockPageContext(servletContext, request, response);
    }
    
    /**
     * 
     * get web-inf root directory,this depend to based maven default layout,eg
     * src->
     *      main->
     *          webapp->
     *              WEB-INF
     * target->
     *  
     * @since  2010-5-24
     * @author qianhoubing
     * @param curClassPath
     * @return
     */
    private String getResourceUrlPath(URL curClassPath){
        if(curClassPath == null)return "";
        File file = new File(curClassPath.getPath());
        if(file.getParentFile() ==null)return "";
        if(file.getParentFile().getParentFile() == null)return "";
        String webappPath =  file.getParentFile().getParentFile().getPath();
        return "file:"+webappPath+"\\src\\main\\webapp";
    }

}
