<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
<title></title>
<link href="/css/wap.css" rel="stylesheet" type="text/css" /> 
</head>


<body>
<div class="mainbox01">
<div class="top">
<div class="fl02"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_PLANT_PROFILE%></div>
<div class="fr02"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>" class="fra"><%=Resources.SunResource.MOBILE_BUTTON_BACK%> </a></div>
</div>
<div class="pfbg02">
  <div class="pf02">
  <div class="sonp01"><img src="<%=ConfigurationSettings.AppSettings["domain"] %>/ufile/small/<%=Model.onePic%>" width="58" height="50" /></div>
  <div class="sonp02">
    <div class="pfz01"> <span class="f26"><%= Model.DisplayTotalDayEnergy%>  <%=Model.TotalDayEnergyUnit%></span></div>
    <div class="f14">
      <div class="fl50"><%=Model.city %></div>
      <div class="fr50"><%=Model.country %></div>
    </div>
    <div class="f14">
      <div class="fl50"><%= Model.DisplayRevenue%> <%=Model.currencies %></div>
      <div class="fr50"><% = Model.DisplayTotalEnergy%>  <%=Model.TotalEnergyUnit%></div>
    </div>
  </div>
  </div>
</div>


<div class="pp01">
<div class="pp02">
<div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_NAME  %> :</div>
<div class="pp02_r"> <%=Html.Encode(Model.name) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_INSTALLDATE %> :</div>
  <div class="pp02_r"><%=Html.Encode(Model.installdate) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_DESIGNPOWER %> :</div>
  <div class="pp02_r"><%=Html.Encode(Model.design_power) %> kWp</div>
</div>
<div style="clear:both; height:1px;"> </div>
</div>
<div class="pp01">
<div class="pp02">
<div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_LOCATION %> :</div>
<div class="pp02_r"> <%=Html.Encode(Model.location) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_LONGITUDE %> :</div>
  <div class="pp02_r"><%=Html.Encode(Model.longitude) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_LATITUDE %> :</div>
  <div class="pp02_r"><%=Html.Encode(Model.latitude) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_MANUFACTURER %> : </div>
  <div class="pp02_r"> <%=Html.Encode(Model.manufacturer) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_MODULE_TYPE %> : </div>
  <div class="pp02_r"> <%=Html.Encode(Model.module_type) %></div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_ANGLE %> : </div>
  <div class="pp02_r"><%=Html.Encode(Model.angle) %> </div>
</div>
<div class="pp02">
  <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_TIMEZONE%> :</div>
  <div class="pp02_r"><%=Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(Model.timezone) %></div>
</div>
<div style="clear:both; height:1px;"> </div>
</div>
<div class="pp01">
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_OPERATOR %> :</div>
    <div class="pp02_r"> <%=Html.Encode(Model.operater) %></div>
  </div>
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_COUNTRY%> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.country) %></div>
  </div>
  <div class="pp02">
<div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_CITY%> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.city) %></div>
  </div>
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_STREET %> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.street) %></div>
  </div>
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_ZIPCODE%> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.postcode) %></div>
  </div>
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_PHONE%> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.phone) %></div>
  </div>
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_PROFILE_EMAIL %> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.email) %></div>
  </div>
  <div class="pp02">
    <div class="pp02_l"><%=Resources.SunResource.PLANT_ADDPLANT_REDUCTRATE%> :</div>
    <div class="pp02_r"><%=Html.Encode(Model.revenueRate) %></div>
  </div>
  <div style="clear:both; height:1px;"> </div>
</div>
<div class="pp01">
  <div class="pp02">
  <div style="line-height:28px;"><%=Resources.SunResource.PLANT_PROFILE_DESCRIPTION %> : </div>
    <div style="color:#4A4949; line-height:26px;">
    <%=Model.description != null ? Model.description.Replace("script", string.Empty) : string.Empty %>
    </div>
  </div>
  <div style="clear:both; height:1px;"> </div>
</div>
</div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
</body>
</html>
