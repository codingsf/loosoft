<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	电站列表 - SolarInfoBank
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<td width="793" valign="top" background="/images/kj/kjbg01.gif">
<script>
    function changePage(page) {
        window.location.href = '/admin/plants/'+page;
    }
</script>
		<table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">电站列表</td>
                </tr>
                <tr>
                  <td>&nbsp; </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
		<div class="subrbox01">
		<div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="99%" align="left">
                            <span style=" color:Red;">标注红色的为示例电站</span>
                        </td>
                    </tr>
                </table>
                
                 <table>
                <tbody><tr>
                    <td width="94%">
                        <a href="/admin/plants_output/<%=(ViewData["page"]  as Pager).PageIndex %>" class="dbl">导出EXCEL文件 </a>
                    </td>

                </tr>
            </tbody></table>
            
            
         </div>
		<div class="sb_top"></div>
		<div class="sb_mid">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><table width="100%" height="30" border="0" cellpadding="0" cellspacing="0" class="subline02">
                <tr>
                  <td width="19%" align="center"><strong>名称</strong></td>
                  <td width="14%" align="center"><strong>国家</strong></td>
                  <td width="14%" align="center"><strong>城市</strong></td>
                  <td width="15%" align="center"><strong>电话</strong></td>
                  <td width="13%" align="center"><strong>制造商</strong></td>
                  <td width="13%" align="center"><strong>型号类型</strong></td>
                  <td width="12%" align="center"><strong>操作</strong></td>
                  </tr>
              </table></td>
            </tr>
             <%
                 int i = 1;
                 foreach (Plant plant in Model)
                 {
                     if (plant.example_plant == true)
                     {
                         i++;
                                %>
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                <tr  >
                  <td width="19%" height="42" align="center"><div style=" width:150px;  line-height:25px; color:Red; overflow:hidden;" title="<%= Html.Encode(plant.name)%> "><%= Html.Encode(plant.name)%></td>
                  <td width="14%" align="center"  height="42"><div style=" width:100px; line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.country)%>"><%= Html.Encode(plant.country)%></td>
                  <td width="14%" align="center"  height="42"><div style=" width:100px; line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.city)%>"><%= Html.Encode(plant.city)%></td>
                  <td width="15%" align="center"  height="42"><div style=" width:100px; line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.phone)%>"><%= Html.Encode(plant.phone)%></td>
                  <td width="13%" align="center"  height="42"><div style=" width:100px; line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.manufacturer)%>"><%= Html.Encode(plant.manufacturer)%></td>
                  <td width="13%" align="center"  height="42"><div style=" width:100px; line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.module_type)%>"><%= Html.Encode(plant.module_type)%></td>
                  <td width="12%" align="center"  height="42">
                  
                  
                  <a href="/admin/DelRecommend/<%=plant.id %>" onclick="return confirm('是否确定取消示例电站?')"><img src="/images/sub/noagree.gif" width="16" height="16" border="0" alt="取消示例电站" title="取消示例电站" /></a>
                  
                  
                  <%if (plant.isNewPlant.Equals(true))
                    { %>
                  <a href="/admin/delnewplant/<%=plant.id %>" onclick="return confirm('是否确定取消首页显示?')"><img src="/images/sub/qx01.gif" width="16" height="16" border="0" alt="取消首页显示" title="取消首页显示" /></a>
                  
                  <%}
                    else
                    {%>
                    <a href="/admin/newplant/<%=plant.id %>"><img src="/images/sub/qx02.gif" width="16" height="16" border="0" alt="推荐首页显示" title="推荐首页显示" /></a>
                    <%} %>
                  </td>
                  </tr>
              </table></td>
            </tr>
           
           <%
                     }
                 }%>
            
            <%
                foreach (Plant plant in Model)
                {
                        if (plant.example_plant != true)
                        {
                            i++;
                                %>
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                <tr  >
                  <td width="19%" height="42" align="center"><div style=" width:150px; height:25px; overflow:hidden;" title="<%= Html.Encode(plant.name)%> "><%= Html.Encode(plant.name)%></td>
                  <td width="14%"height="42"  align="center"><div style=" width:100px; line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.country)%>"><%= Html.Encode(plant.country)%></td>
                  <td width="14%"height="42" align="center"><div style=" width:100px;  line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.city)%>"><%= Html.Encode(plant.city)%></td>
                  <td width="15%"height="42" align="center"><div style=" width:100px;  line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.phone)%>"><%= Html.Encode(plant.phone)%></td>
                  <td width="13%"height="42" align="center"><div style=" width:100px;  line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.manufacturer)%>"><%= Html.Encode(plant.manufacturer)%></td>
                  <td width="13%"height="42" align="center"><div style=" width:100px;  line-height:25px; overflow:hidden;" title="<%= Html.Encode(plant.module_type)%>"><%= Html.Encode(plant.module_type)%></td>
                  <td width="12%" height="42"align="center">
                  
                  <a href="/admin/Recommend/<%=plant.id %>"><img src="/images/sub/agree.gif" width="16" height="16" border="0" alt="推荐为示例电站" title="推荐为示例电站" /></a>
                  
                     <%if (plant.isNewPlant.Equals(true))
                    { %>
                  <a href="/admin/delnewplant/<%=plant.id %>" onclick="return confirm('是否确定取消首页显示?')"><img src="/images/sub/qx01.gif" width="16" height="16" border="0" alt="取消首页显示" title="取消首页显示" /></a>
                  
                  <%}
                    else
                    {%>
                    <a href="/admin/newplant/<%=plant.id %>"><img src="/images/sub/qx02.gif" width="16" height="16" border="0" alt="推荐首页显示" title="推荐首页显示" /></a>
                    <%} %>
                  
                  
                  </td>
                  </tr>
              </table></td>
            </tr>
           
           <%}
                }%>
            
            
            
             <%= ViewData["error"]%>
          </table>
		</div>
		<div class="sb_down"></div> <%Html.RenderPartial("page"); %>
		</div>
		</td>

</asp:Content>
