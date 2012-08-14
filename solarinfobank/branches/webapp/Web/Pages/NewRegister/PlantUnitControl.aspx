﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="37%" class="tdstyle01">
            设备序列号
        </td>
        <td width="36%" class="tdstyle01">
            设备名称
        </td>
        <td width="27%" class="tdstyle01">
            操作
        </td>
    </tr>
    <%foreach (PlantUnit plantUnit in Model.plantUnits)
      {%>
    <tr id="row_<%=plantUnit.collector.id %>">
        <td class="tdstyle02">
            <%=plantUnit.collector.code %>
        </td>
        <td class="tdstyle02">
            <%=plantUnit.displayname %>
        </td>
        <td class="tdstyle02">
            <input type="hidden" name="plantid" class="plantid" value="<%=Model.id %>" />
            <a href="javascript:void(0)" onclick="edit(this);" code="<%=plantUnit.collector.code %>" displayname="<%=plantUnit.displayname %>" class="edit" rel="<%=plantUnit.id %>">
                <img src="/images/lc/pencil.gif" width="16" height="16" border="0" /></a> <a href="javascript:void(0)"
                    rel="<%=plantUnit.collector.id %>" class="del" onclick="del(this)">
                    <img src="/images/lc/lc_del.gif" width="14" height="13" border="0" /></a>
        </td>
    </tr>
    <%} %>
</table>
