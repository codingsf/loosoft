<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%= Resources.SunResource.HOME_INDEX_REGISTER%></title>
    <link href="../../style/lc.css" rel="stylesheet" type="text/css" />
    <link href="../../style/css.css" rel="stylesheet" type="text/css" />
    <link href="../../style/sub.css" rel="stylesheet" type="text/css" />
    <link href="../../style/kj.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        $(document).ready(function() {
            $(".change").click(function() {
                var id = $(this).attr('rel');
                if ($("#unessential_" + id).is(":hidden")) {
                    $("#unessential_" + id).slideDown(0);
                } else {
                    $("#unessential_" + id).slideUp(0);
                }
            });


            $(".btua").click(function() {
                var id = $(this).attr('rel');
                if (!checkinput(id))
                    return;
                $.get("/newregister/unitsave", { t: Math.random(), plantId: id, unitid: $("#unit_" + id).val(), code: $("#code_" + id).val(), password: $("#password_" + id).val(), displayname: $("#displayname_" + id).val() }, function(data, textStatus) {
                    if (data == "True"){
                        reload(id);
                        $("#cancelBtn").click();
                    }else
                        alert(data);
                });
            });

            $(".btub").click(function() {
                var id = $(this).attr('rel');
                $("#password_" + id).attr("disabled", false);
                $("#code_" + id).attr("disabled", false);
                $("#password_" + id).val('');
                $("#code_" + id).val('');
                $("#unit_" + id).val('');
                $("#displayname_" + id).val('');
            });
        });

        function reload(plantid) {
            $.get("/newregister/plantunitcontrol", { t: Math.random(), plantId: plantid }, function(data, textStatus) {
                $("#table_" + plantid).empty();
                $("#table_" + plantid).html(data);
            });
        }

        function edit(obj) {
            var plantid = $(obj).parent().find(".plantid").val();
            var id = $(obj).attr('rel');
            $("#password_" + plantid).val("000000");
            $("#code_" + plantid).val($(obj).attr('code'));
            $("#displayname_" + plantid).val($(obj).attr('displayname'));
            $("#unit_" + plantid).val(id);
            $("#password_" + plantid).attr("disabled", true);
            $("#code_" + plantid).attr("disabled", true);
            $("#unessential_" + plantid).slideDown(0);
        }
        function checkinput(plantid) {
            var success = true;
            if ($("#code_" + plantid).val() == "") {
                $("#error_code_" + plantid).html("<em><span class='error'>&nbsp;<%=Resources.SunResource.NOTICE_DEVICE_SN%></span></em>"); success = false;
            }
            if ($("#password_" + plantid).val() == "") {
                $("#error_password_" + plantid).html("<em><span class='error'>&nbsp;<%=Resources.SunResource.NOTICE_DEVICE_PASSWORD%></span></em>"); success = false;
            }
            if ($("#displayname_" + plantid).val() == "") {
                $("#error_displayname_" + plantid).html("<em><span class='error'>&nbsp;<%=Resources.SunResource.NOTICE_DEVICE_NAME%></span></em>"); success = false;
            }
            return success;
        }

        function del(obj) {
            if (confirm("<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE%>?")) {
                var plantid = $(obj).parent().find(".plantid").val();
                var unitid = $(obj).attr('rel');
                $.get("/newregister/removeunit", { t: Math.random(), plantId: plantid, unitId: unitid }, function(data, textStatus) {
                    if (data == "True")
                        reload(plantid);
                });
            }
        }
            
            
        
    </script>

</head>
<body>
    <div class="lcbox">
        <div class="lctab">
            <ul>
                  <li>1、<%=Resources.SunResource.USER_EDIT_USER_INFORMATION%> </li>
                <li>2、<%=Resources.SunResource.PLANT_INFO_TOTALl_METER%></li>
                <li class="lc_yellowbg">3、<%=Resources.SunResource.DEVICE_INFORMATION%></li>
            </ul>
        </div>
        <div class="lcabout">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="9" height="9" background="/images/tc/tc01.gif">
                    </td>
                    <td background="/images/tc/tc02.gif">
                    </td>
                    <td width="9" height="9" background="/images/tc/tc03.gif">
                    </td>
                </tr>
                <tr>
                    <td background="/images/tc/tc04.gif">
                        &nbsp;
                    </td>
                    <td bgcolor="#FFFFFF">
                        <%foreach (Plant plant in Model)
                          { %>
                        <div class="mb30">
                            <span class="lcintt02">
                                <%=plant.name %>
                            </span>
                            <table width="723" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="9" height="9" background="/images/tc/tc01.gif">
                                    </td>
                                    <td background="/images/tc/tc02.gif">
                                    </td>
                                    <td width="9" height="9" background="/images/tc/tc03.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/tc/tc04.gif">
                                        &nbsp;
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <div id="table_<%=plant.id %>">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="37%" class="tdstyle01">
                                                        <%=Resources.SunResource.DEVICE_SN%>
                                                    </td>
                                                    <td width="36%" class="tdstyle01">
                                                        <%=Resources.SunResource.PLANT_DEVICE_NAME%>
                                                    </td>
                                                    <td width="27%" class="tdstyle01">
                                                        <%=Resources.SunResource.PLANT_LIST_OPERATION%>
                                                    </td>
                                                </tr>
                                                <%foreach (PlantUnit plantUnit in plant.plantUnits)
                                                  {%>
                                                <tr id="row_<%=plantUnit.collector.id %>">
                                                    <td class="tdstyle02">
                                                        <%=plantUnit.collector.code %>
                                                    </td>
                                                    <td class="tdstyle02">
                                                        <%=plantUnit.displayname %>
                                                    </td>
                                                    <td class="tdstyle02">
                                                        <input type="hidden" name="plantid" class="plantid" value="<%=plant.id %>" />
                                                        <a href="javascript:void(0)" onclick="edit(this);" code="<%=plantUnit.collector.code %>"
                                                            displayname="<%=plantUnit.displayname %>" class="edit" rel="<%=plantUnit.id %>">
                                                            <img src="/images/lc/pencil.gif" width="16" height="16" border="0" /></a> <a href="javascript:void(0)"
                                                                rel="<%=plantUnit.collector.id %>" class="del" onclick="del(this)">
                                                                <img src="/images/lc/lc_del.gif" width="14" height="13" border="0" /></a>
                                                    </td>
                                                </tr>
                                                <%} %>
                                            </table>
                                        </div>
                                        <div class="lcadd02">
                                            <a href="javascript:void(0)" class="change" rel="<%=plant.id %>"><%=Resources.SunResource.ADD_DEVICE%></a></div>
                                        <table width="705" border="0" align="center" cellpadding="0" cellspacing="0" id="unessential_<%=plant.id %>"
                                            style="display: none">
                                            <tr>
                                                <td height="45" valign="bottom" background="/images/lc/lcbg003.jpg">
                                                    <div class="lcintt01">
                                                        <span class="f1 ml15 red"><%=Resources.SunResource.AUTH_REG_NOTE%>：* <%=Resources.SunResource.AUTH_REG_FOR_MUST_FILL_IN_THE_ITEM%></span></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td background="/images/lc/lcbg04.jpg">
                                                    <div class="lcin01 mt10">
                                                        <ul>
                                                            <li><%=Resources.SunResource.DEVICE_SN%>
                                                                <input name="unitid" type="hidden" class="lcinput02" id="unit_<%=plant.id %>" />
                                                                <input name="code" type="text" class="lcinput02" id="code_<%=plant.id %>" onblur="$('#displayname_<%=plant.id %>').val($(this).val())" />
                                                                <input name="plantid" type="hidden" class="lcinput02" value="<%=plant.id %>" id="plantid_<%=plant.id %>" />
                                                                <span class="redzi">*</span> <span style="display: block" id="error_code_<%=plant.id %>"></span>
                            </span></li>
                                                            <li><%=Resources.SunResource.DEVICE_PASSWORD%>
                                                                <input name="password" type="password" class="lcinput01" id="password_<%=plant.id %>" />
                                                                <span class="redzi">*</span><span style="display: block" id="error_password_<%=plant.id %>"></span>
                            </span></li>
                                                            <li><%=Resources.SunResource.PLANT_DEVICE_NAME%>
                                                                <input name="displayname" type="text" class="lcinput02" id="displayname_<%=plant.id %>" />
                                                                <span class="redzi">*</span> <span style="display: block" id="error_displayname_<%=plant.id %>"></span>
                            </span></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td background="/images/lc/lcbg04.jpg">
                                                    <span class="lcsub">
                                                        <input name="Submit31" type="button" class="btua" rel="<%=plant.id %>" value="<%=Resources.SunResource.MONITORITEM_SAVE%>" />
                                                        <input name="Submit32" id="cancelBtn" type="button" class="btub" value="<%=Resources.SunResource.PLANT_ADDPLANT_CANCEL%>" rel="<%=plant.id %>" />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="9" background="/images/lc/lcbg05.jpg">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td background="/images/tc/tc05.gif">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr><td width="9" height="9"><img src="/images/tc/tc06.gif" width="9" height="9" /></td><td background="/images/tc/tc07.gif"></td><td><img src="/images/tc/tc08.gif" width="9" height="9" /></td></tr>
                            </table>
                        </div>
                        <%} %>
                        <div class="ok_box0">
                            <input name="Submit2" type="submit" class="ok_greenbtu mr20" value="<%=Resources.SunResource.PREVIOUS_STEP%>" onclick="window.location.href='/newregister/addplant'" />
                            <input type="submit" name="Submit" class="ok_greenbtu" value="<%=Resources.SunResource.BUTTON_FINISHED%>" onclick="window.location.href='/user/overview'" />
                        </div>
                    </td>
                    <td background="/images/tc/tc05.gif">
                        &nbsp;
                    </td>
                </tr>
                <tr><td width="9" height="9"><img src="/images/tc/tc06.gif" width="9" height="9" /></td><td background="/images/tc/tc07.gif"></td><td><img src="/images/tc/tc08.gif" width="9" height="9" /></td></tr>
            </table>
        </div>
    </div>
</body>
</html>
