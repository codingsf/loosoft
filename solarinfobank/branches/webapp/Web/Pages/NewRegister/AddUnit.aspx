<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加单元</title>
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
                $.get("/newregister/unitsave", { t: Math.random(), plantId: id, unitid: $("#unit_" + id).val(), code: $("#code_" + id).val(), password: $("#password_" + id).val(), displayname: $("#displayname_" + id).val() }, function(data, textStatus) {
                    if (data == "True")
                        reload(id);
                    else
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

        function del(obj) {
            if (confirm("确定要删除吗 ?")) {
                var plantid = $(obj).parent().find(".plantid").val();
                var unitid = $(obj).attr('rel');
                $.get("/newregister/removeunit", { t: Math.random(), plantId: plantid, unitId: unitid }, function(data, textStatus) {
                    if (data == "True")
                        reload(plantid);
                    else
                        alert('删除出现异常');
                });
            }
        }
            
            
        
    </script>

</head>
<body>
    <div class="lcbox">
        <div class="lctab">
            <ul>
                <li>1、用户信息 </li>
                <li>2、电站信息</li>
                <li class="lc_yellowbg">3、设备信息</li>
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
                                                        设备序列号
                                                    </td>
                                                    <td width="36%" class="tdstyle01">
                                                        设备名称
                                                    </td>
                                                    <td width="27%" class="tdstyle01">
                                                        操作
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
                                            <a href="javascript:void(0)" class="change" rel="<%=plant.id %>">添加设备</a></div>
                                        <table width="705" border="0" align="center" cellpadding="0" cellspacing="0" id="unessential_<%=plant.id %>"
                                            style="display: none">
                                            <tr>
                                                <td height="45" valign="bottom" background="/images/lc/lcbg003.jpg">
                                                    <div class="lcintt01">
                                                        <span class="f1 ml15 red">注：* 为必填项</span></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td background="/images/lc/lcbg04.jpg">
                                                    <div class="lcin01 mt10">
                                                        <ul>
                                                            <li>设备序列号
                                                                <input name="unitid" type="hidden" class="lcinput02" id="unit_<%=plant.id %>" />
                                                                <input name="code" type="text" class="lcinput02" id="code_<%=plant.id %>" onblur="$('#displayname_<%=plant.id %>').val($(this).val())" />
                                                                <input name="plantid" type="hidden" class="lcinput02" value="<%=plant.id %>" id="plantid_<%=plant.id %>" />
                                                                <span class="redzi">*</span> </li>
                                                            <li>设备密码
                                                                <input name="password" type="password" class="lcinput01" id="password_<%=plant.id %>" />
                                                                <span class="redzi">*</span></li>
                                                            <li>设备名称
                                                                <input name="displayname" type="text" class="lcinput02" id="displayname_<%=plant.id %>" />
                                                                <span class="redzi">*</span> </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td background="/images/lc/lcbg04.jpg">
                                                    <span class="lcsub">
                                                        <input name="Submit31" type="button" class="btua" rel="<%=plant.id %>" value="保存" />
                                                        <input name="Submit32" type="button" class="btub" value="取消" rel="<%=plant.id %>" />
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
                                <tr>
                                    <td width="9" height="9">
                                        <img src="/images/tc/tc06.gif" width="9" height="9" />
                                    </td>
                                    <td background="/images/tc/tc07.gif">
                                    </td>
                                    <td>
                                        <img src="/images/tc/tc08.gif" width="9" height="9" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <%} %>
                        <div class="ok_box0">
                            <input name="Submit2" type="submit" class="ok_greenbtu mr20" value="上一步" onclick="window.location.href='/newregister/addplant'" />
                            <input type="submit" name="Submit" class="ok_greenbtu" value="完成" onclick="window.location.href='/user/overview'" />
                        </div>
                    </td>
                    <td background="/images/tc/tc05.gif">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td width="9" height="9">
                        <img src="/images/tc/tc06.gif" width="9" height="9" />
                    </td>
                    <td background="/images/tc/tc07.gif">
                    </td>
                    <td>
                        <img src="/images/tc/tc08.gif" width="9" height="9" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
