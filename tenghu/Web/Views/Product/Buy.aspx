<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Product>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加订单</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/css/ny.css" rel="stylesheet" type="text/css" />
     <script src="/script/jquery.js" type="text/javascript"></script>
     <script type="text/javascript">
         $().ready(function() {
             $("#category_id").change(function() {
                 $.getJSON("/product/loadmodel?id=" + $('#category_id').val(), function(data) {
                     $("#product_id").empty();
                     $("#product_id").append("<option>--请选择产品型号--</option>");
                     for (var i = 0; i < data.length; i++) {
                         $("#product_id").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
                     }
                 });
             });
         });
    
</script>
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
	  <%Html.RenderAction("header","home"); %>
	  
	  <div class="ny_banner"><img src="/img/banner/banner_4.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top"><div class="left_dh">
              <div class="left_dh01">产品展示</div>
              <div class="left_dh02">
                <ul>
           	<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
        { %>
			<li><a href="/product.aspx/list/<%=cat.id %>">+ <%=cat.name %></a></li>
			<%} %>
                </ul>
              </div>
              <div class="left_dh04"><a href="/product.aspx" class="lyn">> 最新产品</a></div>
              <div class="left_dh04"><a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
              <div class="left_dh03"></div>
            </div>
            <div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="#" class="lz">产品展示</a></div>
			<div class="rbox01">
              <div class="rbox01_ico">
                <div class="sl">产品订购 </div>
              </div>
			  <div class="rbox01_m">
                <div style=" clear:both;">
                  <p><strong>请按要求填写您的准确信息，相关人员将在半小时内与您联系。</strong> (注：带<span class="redz">*</span>号的为必填项)<br />
                  </p>
                </div>
                <form method="post" action="/product/buy" id="buy">
			    <table width="80%" border="1" cellpadding="0" cellspacing="0" bordercolor="#E8E8E8" style="border-collapse:collapse;">
                 
                  <tr>
                    <td height="30" class="txl01">区域</td>
                    <td class="txl02">
                    <%=Html.DropDownList("area",Comm.Area) %>
                       </td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">产品分类</td>
                    <td class="txl02">
                    
                   <select name="category.id" id="category_id">
                   <option value="0">--请选择产品分类--</option>
                   	<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                    { %>
			            <option value="<%=cat.id %>"><%=cat.name %></option>
			            <%} %>
			
                   </select>
                    
                 </td>
                  </tr>
                  
                  <tr>
                    <td height="30" class="txl01">产品型号</td>
                    <td class="txl02"><select name="product.id" id="product_id">
                      <option>--请选择产品型号--</option>
                    </select>
                    </td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">采购性质</td>
                    <td class="txl02">
                      公司
                        <%=Html.RadioButton("type","公司",true )%>
                        个人
                       <%=Html.RadioButton("type","个人") %></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">采购时间</td>
                    <td class="txl02">
                    
                    <%=Html.DropDownList("time",Comm.BuyTime) %>
                  
                      </td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">付款方式</td>
                    <td class="txl02">
                    <%=Html.DropDownList("payment", Comm.PayMent)%>
                    
                    </td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">您的姓名</td>
                    <td class="txl02">
                    <%=Html.TextBox("uname", null, new { @class = "txsy" })%>
                        <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">所属公司</td>
                    <td class="txl02">
                    
                    <%=Html.TextBox("company", null, new { @class = "txsy" })%>
                    
                        <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">联系电话</td>
                    <td class="txl02">
                    <%=Html.TextBox("tel", null, new { @class = "txsy" })%>
                    
                        <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td  height="30" class="txl01">E-mail</td>
                    <td class="txl02">
                    <%=Html.TextBox("email", null, new { @class = "txsy" })%>
                    
                        <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl01">联系地址</td>
                    <td class="txl02">
                    <%=Html.TextBox("address", null, new { @class = "txsy" })%>
                   
                      <span class="redz">*</span></td>
                  </tr>
                  <tr>
                    <td height="90" class="txl01">订购留言</td>
                    <td class="txl02">
                    <%=Html.TextArea("comment", null, new { @class = "txsy",rows="5" })%>
                    
                    </td>
                  </tr>
                </table>
			    <table width="80%" height="60" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="24%">&nbsp;</td>
                    <td width="15%" align="center"><input name="Submit" type="submit" class="sebu" value="提交" /></td>
                    <td width="14%" align="center"><input name="cancel" type="button" id="cancel" class="sebu" value="重置" /></td>
                    <td width="47%">&nbsp;</td>
                  </tr>
                </table>
                </form>
			    </div>
			  </div></td>
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

  <script src="/script/jquery.validate.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $().ready(function() {
            $("#cancel").click(function() {
                $("input[type='text']").each(function() {
                    $(this).val('');
                });
                $("select").each(function() {
                    $(this).get(0).selectedIndex = 0;
                });
                $("#comment").val('');

            });

            $("#buy").validate({
                rules: {
                    uname: "required",
                    tel: "required",
                    email: "required",
                    address: "required",
                    company: "required"
                },
                messages: {
                    uname: {
                        required: "请输入您的姓名"
                    },
                    tel: {
                        required: "请输入电话 "
                    },
                    email: {
                        required: "请输入邮箱"
                    },
                    address: {
                        required: "请输入地址 "
                    },
                    company: {
                        required: "请输入所属公司 "
                    }
                }
            });
        });
    
</script>