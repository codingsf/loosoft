<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.Tenghu.Domain.Job>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Model.name %>-人才招聘</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="main">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="/img/bg01.png" width="1004" height="14" /></td>
    </tr>
    <tr>
      <td background="/img/bg02.png">
	  <div class="mainbody">
	  <% Html.RenderAction("header","home"); %>
	  <div class="ny_banner"><img src="/img/banner/banner_27.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top">
			<div class="left_dh">
			<div class="left_dh01">联系我们</div>
			<div class="left_dh02">
			<ul id="lmenu">
			<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                { %>
			<li><a href="<%=cat.url %>">+ <%=cat.name %></a></li>
			<%} %>
            </ul>
</div>
			
			<div class="left_dh04"><a href="/product" class="lyn">> 最新产品</a></div>
			<div class="left_dh04"><a href="/service/network" class="lyn">> 售后服务网点</a></div>
			<div class="left_dh03"></div>
			  </div>
			<div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; 
			<a href="/" class="lz">首页</a> &gt; <a href="/contact" class="lz">联系我们</a> &gt;  <a href="/contact/job" class="lz">人才招聘</a> &gt; <%=Model.name %> </div>
			<div class="rbox01">
			<div class="rbox01_ico">
			<div class="sl">职位说明</div>
			</div>
			<div class="rbox01_m">
			  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#E8E8E8" style="border-collapse:collapse;">
                <tr>
                  <td height="30" class="txl01">职位名称</td>
                  <td class="txl02"><%=Model.name %></td>
                  <td height="30" class="txl01">工作年限</td>
                  <td class="txl02"><%=Model.jyan %></td>
                  <td class="txl01">专业限制</td>
                  <td class="txl02"><%=Model.zhuanye %></td>
                </tr>
                <tr>
                  <td height="30" class="txl01">招聘人数</td>
                  <td class="txl02"><%=Model.renshu %>人</td>
                  <td class="txl01">学历要求 </td>
                  <td class="txl02"><%=Model.xueli %></td>
                 <td class="txl01">薪水 </td>
                  <td class="txl02"><%=Model.xshui %></td>
                </tr>
                
              </table>
			</div>
			<div style=" clear:both;">
              <p><strong>工作描述：</strong></p>
            <%=Model.descr %>
			</div>
			</div>
			<%--<div class="rbox01">
              <div class="rbox01_ico">
                <div class="sl">在线投简历 </div>
                </div>
              <div class="rbox01_m">
			    <div style=" clear:both;">
			    <p><strong>请填写您的简历并提交</strong> (注：带<span class="redz">*</span>号的为必填项)<br />
			      </p>
			    </div>
			    <table width="80%" border="1" cellpadding="0" cellspacing="0" bordercolor="#E8E8E8" style="border-collapse:collapse;">
                   				  <tr>
                    <td width="24%" height="30" class="txl01">姓名</td>
                    <td width="76%" class="txl02"><input name="textfield2" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                                   <tr>
                    <td height="30" class="txl01">性别</td>
                    <td class="txl02"><input name="textfield22" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">应聘岗位</td>
                    <td class="txl02"><input name="textfield23" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">出生年月</td>
                    <td class="txl02"><input name="textfield24" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">户籍</td>
                    <td class="txl02"><input name="textfield25" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">现住地址</td>
                    <td class="txl02"><input name="textfield26" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">电话</td>
                    <td class="txl02"><input name="textfield27" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">邮箱</td>
                    <td class="txl02"><input name="textfield28" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">学历</td>
                    <td class="txl02"><input name="textfield29" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">毕业院校</td>
                    <td class="txl02"><input name="textfield210" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">专业</td>
                    <td class="txl02"><input name="textfield211" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">工作年限</td>
                    <td class="txl02"><input name="textfield212" type="text" class="txsy" />
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="90" class="txl01">自我评价</td>
                    <td class="txl02"><textarea name="textfield213" rows="5" class="txsy"></textarea>
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="90" class="txl01">工作经历</td>
                    <td class="txl02"><textarea name="textarea" rows="5" class="txsy"></textarea>
                      <span class="redz">*</span></td>
                  </tr>
                </table>
			    <table width="80%" height="60" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="24%">&nbsp;</td>
                    <td width="15%" align="center"><input name="Submit" type="submit" class="sebu" value="发送" /></td>
                    <td width="14%" align="center"><input name="Submit2" type="submit" class="sebu" value="重置" /></td>
                    <td width="47%">&nbsp;</td>
                  </tr>
                </table>
			  </div>
			</div>--%>
			</td>
          </tr>
          <tr>
            <td valign="bottom">
			<div class="ny_top"><a href="#"><img src="/img/ny/click_up.jpg" width="40" height="15" border="0" /></a></div>
			</td>
          </tr>
        </table>
	  </div>
	  <%Html.RenderPartial("footer"); %>
	
	  </div>
	  </td>
    </tr>
    <tr>
      <td><img src="/img/bg03.png" width="1004" height="12" /></td>
    </tr>
  </table>
</div>

</body>
</html>
