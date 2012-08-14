<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>

<%@ Import Namespace=" Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加电站</title>
    <link href="../../style/lc.css" rel="stylesheet" type="text/css" />
    <link href="../../style/css.css" rel="stylesheet" type="text/css" />
    <link href="../../style/sub.css" rel="stylesheet" type="text/css" />
    <link href="../../style/kj.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    <link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">

        function hideunessentialall() {
            if (window.frames.length == 2) return;
            for (var x = 0; x < window.frames.length; x++) {
                if (typeof (eval(window.frames[x].hideunessential)) == "function") {
                    window.frames[x].hideunessential();
                }
            }
        }


        var canSubmit = false; //是否提交
        function clearcontrol(ctrl) {
            if ($("#ifrm" + ctrl).get(0) == undefined)
                alert("默认不能被删除.");
                $("#ifrm" + ctrl).remove();
        }
        // 批量提交
        function batchsubmit() {
            //$.colorbox({ href: "/images/ajax_loading.gif", transition: "fade", bgOpacity: 0 ,});
            //return;
            var x = 0;
            var frmcount = 0;
            var validatecount = 0;
            //首先判断是否所有的iframe输入都验证通过 为了避免有的验证通过而有的未通过
            //保证所有都通过的情况下一起提交
            for (; x < window.frames.length; x++) {
                if (typeof (eval(window.frames[x].execute)) == "function") {
                    frmcount++;
                    if (window.frames[x].execute(canSubmit))
                        validatecount++;
                }
            }
            canSubmit = false;
            if (validatecount == frmcount) {
                canSubmit = true; x = 0;
                for (; x < window.frames.length; x++) {
                    if (typeof (eval(window.frames[x].execute)) == "function") {
                        window.frames[x].execute(canSubmit);
                    }
                }
            }
            setInterval("checkresult()", 500);
            iframeauto();
        }


        function checkresult() {
            if (canSubmit == false)
                return;
            var x = 0;
            var frmcount = 0;
            var validatecount = 0;
            for (; x < window.frames.length; x++) {
                if (typeof (eval(window.frames[x].checkid)) == "function") {
                    frmcount++;
                    if (window.frames[x].checkid())
                        validatecount++;
                }
            }
            if (validatecount == frmcount)
                window.location.href = '/newregister/addunit';

        }

        function previewImage(picname) {
            $.colorbox({ href: picname });
        }

        function iframeauto() {
            $("iframe").each(function() {
                var iframeid = $(this).get(0); //iframe id
                if (document.getElementById) {
                    if (iframeid && !window.opera) {
                        if (iframeid.contentDocument && iframeid.contentDocument.body.offsetHeight) {
                            iframeid.height = iframeid.contentDocument.body.offsetHeight + 15;
                        } else if (iframeid.Document && iframeid.Document.body.scrollHeight) {
                            iframeid.height = iframeid.Document.body.scrollHeight + 15;
                        }
                    }
                }
            });
        }
        var controlid = 1;
        $().ready(function() {
            $("#addplant").click(function() {
                controlid++;
                $('#plant_container').append('<iframe scrolling="no"  id="ifrm' + controlid + '" frameborder="0" width="100%" src="/newregister/addplantcontrol/?menu=' + controlid + '"></iframe>');
                iframeauto();
            });
            iframeauto();
        });
    </script>

</head>
<body>
    <div class="lcbox">
        <div class="lctab">
            <ul>
                <li>1、用户信息 </li>
                <li class="lc_yellowbg">2、电站信息</li>
                <li>3、设备信息</li>
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
                        <div id="plant_container">
                            <%if (Model.Count > 0)
                              {
                                  for (int x = 0; x < Model.Count; x++)
                                  { %>
                            <iframe scrolling="no" id="ifrm<%=x %>" frameborder="0" width="100%" height="auto"
                                src="/newregister/addplantcontrol?menu=<%=x %>&plantid=<%=Model[x].id %>"></iframe>
                            <%}
                              }
                              else
                              { %>
                            <iframe scrolling="no" id="ifrm0" frameborder="0" width="100%" height="auto" src="/newregister/addplantcontrol?menu=1">
                            </iframe>
                            <%} %>
                        </div>
                        <div class="lcadd01">
                            <a href="javascript:void(0)" id="addplant">添加电站</a></div>
                        <div class="ok_box0">
                            <input type="submit" name="Submit2" class="ok_greenbtu mr20" value="上一步" onclick="window.location.href='/newregister/register'" />
                            <input type="button" onclick="batchsubmit();" name="Submit" class="ok_greenbtu" value="下一步" />
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
