<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Collector>" %>
<%@ Import Namespace="System.Globalization" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script>
        function empty() {
            $(".txtbu01").each(function() {
                $(this).val("");
            });
        }
       
        function changePage(page) {
            window.location.href = '/admin/admin/' + page;
        }
        function Del(id) {
            if (confirm('<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE %>') == false)
                return;
            $.ajax({
                type: "POST",
                url: "/admin/delcollector",
                data: { id: id },
                success: function(result) {
                    if (result == "success")
                        $('#item_' + id).hide();
                    else
                        alert('<%=Resources.SunResource.USER_LOG_ERROR %>');
                }
            });
        }
</script>
    <script type="text/javascript">

        $().ready(function() {
            empty();
            $("#addForm").validate({
                errorElement: "em",
                rules: {
                    code: {
                        required: true,
                        maxlength: 20
                    },

                    password: {
                        required: true,
                        maxlength: 20
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "code") {
                        $("#error_code").text('');
                        error.appendTo("#error_code");
                    }

                    if (element.attr("name") == "password") {
                        $("#error_password").text('');
                        error.appendTo("#error_password");
                    }
                },

                messages: {
                    code: {
                    required: "<span class='error'>&nbsp;请输入编号</span>",
                        maxlength: "<span class='error'>&nbsp;请输入不超过{0}个字符</span>"
                    },
                    password: {
                    required: "<span class='error'>&nbsp;密码</span>",
                        maxlength: "<span class='error'>&nbsp;请输入不超过{0}个字符</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>
<style type="text/css">

.line_b{ border-bottom:1px solid #9EC93D;}

</style>
</head>
<link href="/style/css.css" rel="stylesheet" type="text/css" />
<link href="/style/sub.css" rel="stylesheet" type="text/css" />
<link href="/style/kj.css" rel="stylesheet" type="text/css" />
<body>
<%
   ViewData["langs"]= Cn.Loosoft.Zhisou.SunPower.Service.LanguageService.GetInstance().GetList();
 %>
<div class="mainbody">
<!--header开始-->
<%Html.RenderPartial("header"); %>

<!--结束-->

<!--main开始-->
<div class="mainbox">

<% using (Html.BeginForm("admin", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
{%>
  <div style="width:982px; margin:0px auto; padding-bottom:30px; background:url(/images/kj/02.gif);">
    <table width="982" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
      <tr>
        <td width="8" align="left"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
        <td width="964"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">

            <tr>
              <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico02.gif" width="31" height="50" /></td>
              <td width="93%" class="pv0216">添加采集器
              
             <a href="/admin/home" style="float:right; font-weight:normal; font-size:13px;">Logout</a> 
              </td>
            </tr>
            <tr>
              <td class="pv0212">&nbsp;</td>
            </tr>
        </table></td>

        <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
      </tr>
    </table>
    <div class="subrbox01">
      <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="6%" align="center"><img src="/images/sub/subico010.gif" width="18" height="19" /></td>
          <td class="f_14"><strong><%=Resources.SunResource.MONITORITEM_NOTE %>:<span class="red">*</span><%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM %></strong></td>

        </tr>
      </table>
      <div class="sb_top"></div>
      <div class="sb_mid">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="29%" height="35" class="pr_10">采集器编号:</td>
            <td width="29%"><%= Html.TextBoxFor(model => model.code, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span></td>

            <td width="42%">

                 <span id="error_code"></span>
            </td>
          </tr>
          <tr>

            <td height="35" class="pr_10">密码:</td>
            <td><%= Html.TextBoxFor(model => model.password, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span></td>
            <td><span id="error_password"></span></td>
          </tr>
          <tr>
          <td></td>
          <td height="35"><%= Html.ValidationMessage("Error", "", new { id = "errormessage", @class="redzi" })%></td>
          <td></td>
          </tr>
        </table>
      </div>
      <div class="sb_down"></div>

    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="244" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="111"><input name="Submit2" type="submit" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_SAVE %>" /></td>
              <td width="108"><input name="Submit3" type="reset" onclick="empty();" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_RESET %>" /></td>
            </tr>
        </table></td>

      </tr>
    </table>
    <div class="subrbox01">
      <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="6%" align="center"><img src="/images/sub/subico010.gif" width="18" height="19" /></td>
          <td class="f_14"><strong>采集器列表</strong></td>
        </tr>

      </table>
      <div class="sb_top"></div>
      <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                <tr>
                                    <td width="23%" align="center">
                                        <strong>

                                            采集器编号</strong>

                                    </td>
                                    <%--   <td width="18%" align="center">
                                        <strong>
                                           类型</strong>
                                    </td>--%>
                                    <td width="18%" align="center">
                                        <strong>

                                            密码</strong>

                                    </td>
                                    <td width="19%" align="center">
                                        <strong>
                                            是否启用</strong>
                                    </td>
                                    <td width="22%" align="center">
                                        <strong>

                                            操作</strong>

                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <% 
                        foreach (var item in ViewData["data"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.Collector>)
                        {
                    %>
                    <tr id="item_<%=item.id %>">
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                                <tr  >
                                    <td width="23%" height="42" align="center">
                                        <%= Html.Encode(item.code)%>
                                    </td>
                                    <%-- <td width="18%" align="center">
                                        <%= Html.Encode(item.type)%>
                                    </td>--%>
                                    <td width="18%" align="center">
                                        <%= Html.Encode(item.password)%>
                                    </td>
                                    <td width="19%" align="center">
                                        <% =Html.Encode(item.isUsed==true?"Yes":"No") %>
                                    </td>
                                    <td width="22%" align="center">
                                        &nbsp;&nbsp; 
                                                <%if (item.isUsed == true)
                                                  { %>
                                                  <img src="/images/sub/nodelete.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_NODELETE%>"  title="<%=Resources.SunResource.MONITORITEM_NODELETE%>"/>
                                                  <%}
                                                  else
                                                  { %>
                                                <a onclick="Del('<%=item.id%>')"
                                                    href="javascript:void(0);">
                                                    <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                        title="<%=Resources.SunResource.MONITORITEM_DELETE%>" /></a>
                                                  <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%}%>
                     
                </table>
            </div>
      <div class="sb_down"></div><%Html.RenderPartial("page"); %>
    </div>
    
  </div>
<%} %>
  </div>
<!--结束-->
<div style="clear:both"> </div>

<!--footer开始-->
<%Html.RenderPartial("footer"); %>
<!--结束-->
</div>
</body>
</html>
