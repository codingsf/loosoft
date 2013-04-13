<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div class="mainbox">
<div class="header">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="50%">
                    <img class="logo" src=""/>
                </td>
                <td width="50%" align="left">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="34%" colspan="2" align=center>
                    <label id="name">
                    </label>
                </td>
            </tr>
        </table>   
</div>
<div class="table" id="page_<%=ViewContext.RouteData.Values["plantid"] %>_<%=ViewContext.RouteData.Values["id"] %>_chart">

</div>
<div class="tab"><img src="/bigscreen/images/img03.png" width="127" height="33" /></div>
</div>