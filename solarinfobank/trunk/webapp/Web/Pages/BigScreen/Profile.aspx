<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<div class="mainbox">
<div class="header">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="34%"><img class="logo" src="" width="225" height="46" /></td>
      <td width="66%" align="left"><label id="name"></label></td>
    </tr>
  </table>
</div>
<div class="midbox">
<div class="leftbox"><img id="imageurl" src="" width="369" height="232" />
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="ECAF0E" class="about">
    <tr>
      <td width="36%" class="pr10">投入运行日期：</td>
      <td width="64%" class="pl10"><label id="installdate"></label></td>
    </tr>
    <tr>
      <td class="pr10">设计功率：</td>
      <td class="pl10"><label id="designpower"></label></td>
    </tr>
    <tr>
      <td class="pr10">地理位置：</td>
      <td class="pl10"><label id="location"></label></td>
    </tr>
    <tr>
      <td class="pr10">业主单位：</td>
      <td class="pl10"><label id="organize"></label></td>
    </tr>
    <tr>
      <td class="pr10">逆变器数量：</td>
      <td class="pl10"><label id="invertercount"></label></td>
    </tr>
    <tr>
      <td class="pr10">逆变器类型：</td>
      <td class="pl10"><label id="invertertypestr"></label></td>
    </tr>
  </table>
</div>
<div class="rightbox">
<ul>
<li><font class="f34"><label id="dayenergy"></label></font><font class="f18"><label id="dayenergyunit"></label> </font></li>
<li><font class="f34"><label id="totalenergy"></label></font><font class="f18"><label id="totalenergyunit"></label> </font> </li>
<li><font class="f34"><label id="curpower"></label></font><font class="f18"><label id="curpowerunit"></label> </font></li>
</ul>
<div class="em"></div>
<ul>
  <li><font class="f34"><label id="cq2reduce"></label></font> <font class="f18"><label id="cq2reduceunit"></label> </font></li>
  <li><font class="f34"><label id="solarintensity"></label></font> <font class="f18"> <label id="solarintensityunit"></label> </font> </li>
  <li><font class="f34"><label id="temprature"></label></font><font class="f18"><label id="tempratureunit"></label> </font></li>
</ul>
</div>
</div>
</div>
