<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" uri="http://www.common.lib/tags/util" %>
<%--
    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	request.setAttribute("curHost",RequestUtils.getWebURL(request));
	String service = ParamUtils.getParameter(request,"service");
	request.setAttribute("service",service);
	String JSESSIONID = request.getSession().getId();
	request.setAttribute("JSESSIONID",JSESSIONID);
	
%>
<%@page import="cn.common.lib.util.web.RequestUtils"%>
<%@page import="cn.common.lib.util.web.ParamUtils"%>
        
<%@page import="org.apache.commons.lang.StringUtils"%><script type="text/javascript">
        window.onload=function(){
			document.getElementById("username").focus();
        }

        //验证用户密码必填        
        function submitForm(formObj){
            var username = formObj.elements["username"].value;
            if(username.length==0){
                alert("请输入用户名！")
                formObj.elements["username"].focus();
                return false;
            }

            var password = formObj.elements["password"].value;
            if(password==0){
                alert("请输入密码！")
                formObj.elements["password"].focus();
                return false;
            }
			return true;
        }
        </script>
		<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" action="${curHost}/ilogin?service=${service}" htmlEscape="true" onsubmit="return submitForm(this);">
		<div class="loginbar mb10">
			<ul>
			 <li class="login_name">
			 <span class="label_2 ll">
			  用户名
			 </span>
			 <input class="input ll" type="text" value="" name="username" id="username" tabindex="1"/>
			 <span class="ll ml5">
			 <input class=“noborder” type="checkbox" name="rememberMe" id="rememberMe" tabindex="3" style="width:13px;height:13px;margin-right:5px;"/>记住我
			 </span>
			 </li>
			 <li class="login_name">
			 <span class="label_2 ll">
				 密 码
			 </span>
			 <input class="input ll" type="password" value="" name="password" tabindex="2" />
			 <input type="hidden" name="jsessionid" value="${JSESSIONID}" />
			 <input type="hidden" name="lt" value="${flowExecutionKey}" />
			 <input type="hidden" name="_eventId" value="submit" />
		            <span class="login_an">
		            <input type="submit" />
		            </span>
		            </li>
		           </ul>
		           <div class="reg_buttom">
		           <div class="reg_an">
		           <input type="button" onclick="window.location.href='<common:prop name="reg.url" propfilename=""/>'"/>
			</div>
			<a class="lh270 ml20 ll" href="<common:prop name="findpassword.url" propfilename=""/>">忘记密码?</a>
			</div>
			</div>		
		</form:form>