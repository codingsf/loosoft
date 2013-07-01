<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Inside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.PLANT_EDIT_EDIT_PLANT  %> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="/style/colorbox.css" rel="stylesheet" type="text/css" />

    <script src="/script/countrycity.js" type="text/javascript"></script>

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#s1").change(function() {

                if ($("#s1").val() == "Other") {
                    $("#s1").css("width", "60px");
                    $("#country").show();
                    $("#city").show();
                    $("#s2").hide();
                    $("#country").attr("value", '');
                    $("#city").attr("value", '');
                }
                else {
                    $("#s1").css("width", "180px");
                    $("#country").hide();
                    $("#city").hide();
                    $("#s2").show();
                    $("#country").attr("value", $("#s1").val());
                    $("#city").attr("value", $("#s2").val());
                }
            });
            $("#s2").change(function() {
                $("#country").attr("value", $("#s1").val());
                $("#city").attr("value", $("#s2").val());
            });
            $("#plantform").validate({
                errorElement: "em",
                rules: {
                    name: {
                        required: true
                    },
                    longitude: {
                        number: true
                    },
                    latitude: {
                        number: true
                    },
                    design_power: {
                        number: true
                    },
                    email: {
                        email: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "name") {
                        $("#error_name").text('');
                        error.appendTo("#error_name");
                    }
                    if (element.attr("name") == "longitude") {
                        $("#error_longitude").text('');
                        error.appendTo("#error_longitude");
                    }
                    if (element.attr("name") == "latitude") {
                        $("#error_latitude").text('');
                        error.appendTo("#error_latitude");
                    }
                    if (element.attr("name") == "design_power") {
                        $("#error_design_power").text('');
                        error.appendTo("#error_design_power");
                    }
                    if (element.attr("name") == "email") {
                        $("#error_email").text('');
                        error.appendTo("#error_email");
                    }
                },

                messages: {
                    name: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_EDIT_PLANTNAME_REQUIRED  %></span>"
                    },
                    longitude: {
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>"
                    },
                    latitude: {
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>"
                    },
                    design_power: {
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>"
                    },
                    email: {
                        email: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_EDIT_EMAIL_EMAIL  %></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <script src="../../Content/swfupload.js" type="text/javascript"></script>

    <script type="text/javascript">
        var swfu;
        window.onload = function() {
            swfu = new SWFUpload({
                // Backend Settings
                upload_url: "../../Content/Ashx/Upload.ashx",
                post_params: {
                //                    "ASPSESSID": "<%=Session.SessionID %>"
            },

            // File Upload Settings
            file_size_limit: "5 MB",
            file_types: "*.jpg;*.png;*.gif;*.bmp;*.jpeg",
            file_types_description: "JPG Images",

            // Event Handler Settings
            file_dialog_complete_handler: function(numFilesSelected, numFilesQueued) { if (numFilesQueued > 0) { $("#crosspic").show(); this.startUpload(); } },
            upload_success_handler: function(file, responseText) {
                document.getElementById("uploadFilePath").value = file.name;
                document.getElementById("pic").value = document.getElementById("pic").value + "," + responseText;
                ApplendPicContainer(responseText);
                $("#crosspic").hide();
            },

            // Button settings
            //button_image_url: "../../Content/images/XPButtonNoText_160x22.png",
            button_placeholder_id: "spanButtonPlaceholder",
            button_width: 70,
            button_height: 25,
            button_text: '<a href=\"#\" class=\"green\" style=\"text-decoration:underline;cursor:pointor;\">Upload</a>',
            button_text_style: 'cursor:pointor;',
            //button_text_class: 'green',            
            button_text_top_padding: 7,
            button_text_left_padding: 5,

            // Flash Settings
            flash_url: "../../Content/Swf/swfupload.swf", // Relative to this file

            // Debug Settings
            debug: false
        });
    }

    //追加电站图片到容器
    function ApplendPicContainer(picname) {
        var GetRandomn = 1;
        //获取随机范围内数值的函数
        function GetRandom(n) { GetRandomn = Math.floor(Math.random() * n + 1) }
        //开始调用，获得一个1-100的随机数
        GetRandom("100");
        var plantId = $("#id").val();
        var appendHtml = "<div class='upload_pic' id='uploadpic_" + picname + "'>" +
        "<div class='upload_picimg'>" +
            "<img style='width: 84px; height: 73px;' src='/ufile/" + picname + "' /></div>" +
            "<div class='upload_piczi'>" +
                "<a id='showlargepic_" + GetRandomn + "' href='javascript:void(0)' onclick=\"parent.previewImage('/ufile/" + picname + "')\"><%=Resources.SunResource.MONITORITEM_BIG %></a> | <a href='javascript:void()' onclick=\"deletePic('" + picname + "')\"><%=Resources.SunResource.MONITORITEM_DELETE %></a>" +
            "</div>" +
        "</div>";
        $("#picContainer").append(appendHtml);
    }

    function deletePic(picname) {
        if (!confirm('<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE%>')) return;

        document.getElementById("uploadpic_" + picname).style.display = "none";
        var curPics = "," + document.getElementById("pic").value + ",";
        var searchValue = "," + picname + ",";
        var startIndex = curPics.indexOf(searchValue);
        if (startIndex > -1) {
            var beforeStr = curPics.substring(0, startIndex);
            var endStr = curPics.substring(startIndex + searchValue.length);
            document.getElementById("pic").value = beforeStr.substring(2) + endStr.substring(1, endStr.length - 1);
        }
    }
    function showBigPic(name, id) {
        $("#showlargepic_" + id).attr("href", "/ufile/" + name)
        $("#showlargepic_" + id).colorbox();
    }
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <form id="plantform" action="/user/save" enctype="multipart/form-data" method="post" target="_parent">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif"/>
                            </td>
                            <td class="pv0216">
                                <%=Resources.SunResource.PLANT_EDIT_EDIT_PLANT  %>
                            </td>
                            <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                        </tr>
                        <tr>
                            <td width="75%">
                                <%=Resources.SunResource.PLANT_EDIT_EDIT_PLANT_DETAIL  %>&nbsp;
                            </td>
                            <td width="18%"></td>
                        </tr>
                    </table>
                </td>
                <td width="6" align="right">
                    <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                </td>
            </tr>
        </table>
        <div class="subrbox01">
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="94%" class="f_14">
                            <strong><%=Resources.SunResource.PLANT_EDIT_EDIT_PLANT  %></strong>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                    <%=Resources.SunResource.MONITORITEM_NOTE  %>:* <%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM  %></div>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                    <tr>
                        <td width="15%" height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_NAME  %>:
                        </td>
                        <td style="width: 32%">
                            <%=Html.HiddenFor(Model=>Model.id) %>
                            <%=Html.HiddenFor(Model => Model.userID, new { @class="txtbu01" })%>
                            <%= Html.TextBoxFor(model => model.name, new { @class = "txtbu01" })%>
                            <span class="red" style="color: Red;">*</span>
                        </td>
                        <td colspan="2" rowspan="37" valign="top" class="pl20">                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                      
                                                                                                                                                                                                                        
                        <span id="Span3"></span>                                                                                                
                        <span id="Span4"></span>                                                                                                
                        <span id="Span5"></span>                                                                                                
                        <span id="Span6"></span>                                                                                                
                        <span id="Span7"></span>                                                                                                
                        <span id="Span8"></span>                                                                                                
                        <span id="Span9"></span>                                                                                                
                        <span id="Span10"></span>                                                                                                
                        <span id="Span11"></span>                                                                                                
                        <span id="Span12"></span>                                                
                        <span id="Span13"></span>
                        <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="40">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="50px" align="center">
                                        <strong><%=Resources.SunResource.MONITORITEM_ADD  %></strong>
                                    </td>
                                    <td width="100px">
                                        <%= Html.HiddenFor(model => model.pic) %>
                                        <div >
                                            <input type="text" id="uploadFilePath" class="txtbu01" /></div>
                                    </td>
                                    <td style="width: 100px;">
                                        <div id="crosspic" style="display: none">
                                            <table width="100" border="0" align="left" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="43" align="left">
                                                        <img src="/images/sub/loading_detail.gif" width="32" height="32" />
                                                    </td>
                                                    <td width="100" class="lbl">
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    <div style="float: left" id="spanButtonPlaceholder">
                                        </div>
                                        </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="picContainer">
                                <% if (ViewData["pic"] != null)
                                   {
                                       int i = 0;
                                       foreach (string pic in ViewData["pic"] as string[])
                                       {
                                           i++;
                                           if (pic != "")
                                           {
                                %>
                                <div class="upload_pic" id="uploadpic_<%=pic %>">
                                    <div class="upload_picimg">
                                        <img style="width: 84px; height: 73px;" src="/ufile/<%=pic %>" /></div>
                                    <div class="upload_piczi">
                                        <a id="showlargepic_<%=  i=i++ %>" href="javascript:void(0)" onclick="parent.previewImage('/ufile/<%=pic %>')"><%=Resources.SunResource.MONITORITEM_BIG %></a>
                                        | <a href="javascript:void()" onclick="deletePic('<%=pic %>')"><%=Resources.SunResource.MONITORITEM_DELETE %></a></div>
                                </div>
                                <%}
                                       }
                                   }%>
                            </div>
                        </td>
                    </tr>
                </table></td>

                    </tr>
                    <tr>
                        <td height="20">
                            <span class="red" id="Span1"></span>
                        </td>
                        <td valign="top" class="llgr" style="width: 30%">
                            <span class="red" id="error_name"></span>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_INSTALLDATE %>:
                        </td>
                        <td style="width: 30%">
                            <%=Html.TextBox("installdate", this.Model.installdate.ToString("yyyy-MM-dd"), new { onclick = "WdatePicker()", @ReadOnly = "true", @class="txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_DESIGNPOWER %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.design_power, new { @class = "txtbu01", @style = "width:150px" })%>
                            <span class="f11">kWp</span>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        <span id="error_design_power"></span>
                        </td> 
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_LOCATION %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.location, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_LONGITUDE %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.longitude, new { @class = "txtbu01" })%>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        <span class="red" id="error_longitude"></span>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_LATITUDE %>:&nbsp;
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.latitude, new { @class = "txtbu01" })%>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        <span class="red" id="error_latitude"></span>  
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_MANUFACTURER %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.manufacturer, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_MODULE_TYPE %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.module_type, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_ANGLE%>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.angle, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_TIMEZONE %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.timezone, new { @class = "txtbu01" })%>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_OPERATOR %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.operater, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_COUNTRY %>:
                        </td>
                        <td style="width: 30%">
                            <input type="hidden" value="<%=this.Model.country %>" id="cy" name="cy" />
                            <select id="s1" class="txtbu01" style="width: 181px; float:left; height:23px;">
                                <option><%=Resources.SunResource.PLANT_PROFILE_COUNTRY %></option>
                            </select><input id="country" name="country" type="text" style="display:none; width:120px; float:left;" class="txtbu01" value="<%=this.Model.country %>"/>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_CITY %>:
                        </td>
                        <td style="width: 30%">
                            <select id="s2" class="txtbu01" style="width: 181px">
                                <option><%=Resources.SunResource.PLANT_PROFILE_CITY %></option>
                            </select><input id="city" name="city" type="text" style="display:none; float:left;" class="txtbu01" value="<%=this.Model.city %>"/>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%"> 
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_STREET %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.street, new { @class = "txtbu01" })%>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td style="width: 30%">
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_ZIPCODE %>:
                            <td style="width: 30%">
                                <%= Html.TextBoxFor(model => model.postcode, new { @class = "txtbu01" })%>
                            </td>
                            
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        
                    </tr>             
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_PHONE %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.phone, new { @class = "txtbu01" })%>
                        </td>
                        <%--</td>--%>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        
                    </tr>
                    
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_EMAIL %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01" })%>
                        </td>
                        
                        <input type="hidden" value="<%=this.Model.city %>" id="Hidden3" name="cty" />
                        <%--</td>--%>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        <span class="red" id="error_email"></span>
                        </td>
                        
                    </tr>
                    <tr>
                        <td height="20" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_DIRECTION %>:
                        </td>
                        <td style="width: 30%">
                            <%= Html.TextBoxFor(model => model.direction, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                    </tr>
                    <tr>
                           <td height="20">
                            <%=Resources.SunResource.PLANT_ADDPLANT_VIDEO_MONITOR %>:
                        </td>
                        <td style="width: 30%">
                            <%=Html.DropDownListFor(model => model.VideoMonitorEnable, new List<SelectListItem>(){
                            new SelectListItem(){ Text= Resources.SunResource.PLANT_EDIT_ENABLE, Value="0"},
                            new SelectListItem(){ Text= Resources.SunResource.PLANT_EDIT_DISABLE, Value="0"}

                            }, new { @class = "txtbu01",style="width:181px;" })%>
                        </td>
                        </tr>
                             <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            &nbsp;
                        </td>
                        <td valign="top" style="width: 30%">
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td valign="top">
                            <span id="Span2"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="pl20">
                            <%=Resources.SunResource.PLANT_PROFILE_DESCRIPTION %> :
                        </td>
                        <td colspan="3" valign="top">
                            <%= Html.HiddenFor(model => model.description) %>
                            <FCKeditorV2:FCKeditor ID="description" runat="server" Width="600" Height="300">
                            </FCKeditorV2:FCKeditor>
                        </td>
                    </tr>
                    <tr>
                        <td height="18">
                            &nbsp;
                        </td>
                        <td colspan="3">
                        </td>
                    </tr>
                </table>
                <div class="subline01">
                </div>
                
            </div>
            <div class="sb_down">
            </div>
        </div>
        <div>
            <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <input name="Submit" type="submit" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_SAVE %>" />
                    </td>
                    <td>
                        <input onclick="window.location='/user/allplants/<%=this.Model.id %>'" name="Submit2"
                            type="button" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_CANEL %>" />
                    </td>
                </tr>
            </table>

            <script>
                $('#ctl00_MainContent_description').val($('#description').val());
            </script>

            <script>                setup();</script>

        </div>
        </form>
    </td>

    <script>
        var count = $("#s1 option").length;
        for (var i = 0; i < count; i++) {
            if ($("#s1 ").get(0).options[i].value == $("#cy").val()) {
                $("#s1 ").get(0).options[i].selected = true;
                change(1);
                break;
            }
        }
        count = $("#s2 option").length;
        for (var i = 0; i < count; i++) {
            if ($("#s2 ").get(0).options[i].value == $("#cty").val()) {
                $("#s2 ").get(0).options[i].selected = true;
                break;
            }
        }
                                   
    </script>
</asp:Content>