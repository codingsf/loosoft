<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>宿舍床位选择</title>
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
	<script type="text/javascript">
		<!--
		   $(document).ready(function(){
				$("#assignBedToStudent").click(			
					function () {
						//取得是否自动分配寝室
						var bedID = $("#hiddenRoom").val();
						
						var zdroom = $("#lou").val()+"号楼"+$("#room").val()+"室"
						if(($("#lou").val()+$("#room").val())=="" && bedID==""){
							alert("没有指定分配的宿舍！");
							return;
						}
						
						if(($("#lou").val()+$("#room").val())!="" && bedID!=""){
							if(!confirm("您同手输和选择了宿舍，将以手工输入的为准？"))return;
						}

						$.getJSON("../room/bed-assign!handAssign.action",{"examineeNo":'${student.examineeNo}',"bedID":bedID,'zdroom':zdroom},function(data) {
							var obj = eval(data);
							
							if(obj.assignResult=='no'){
								$("#message").html("分配失败");
							}else{
								$("#message").html(obj.assignResult);
							}
						});
					}
				);
		    });
		-->
	</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>

<body>
<div class="xzwz">
  <h1>
	  ${collegeName}&nbsp;${majorName }&nbsp;${className }&nbsp;预分宿舍共${countBed }床位，已分${countBed-unassignBed}，剩余${unassignBed }<br/>
	  剩余床位如下，请选择床位所在行分配此床位给当前新生<br/>
  </h1>
</div>
<br/>
<br/>
<div style="width: 500px; text-align: center;" id="message">&nbsp;<s:actionmessage theme="custom" cssClass="STYLE1" /></div>
<br/>
<input type="hidden" id="hiddenRoom" value=""/>
<table class="tbhs" align="left">
  <tr>
    <th >宿舍楼</th>
    <th >楼层</th>
    <th >宿舍</th>
    <th >床位号</th>
  </tr>
  <s:iterator id="obj" value="roomList" status="stat">
  <s:set id="beds" scope="request" value="obj.beds"/>
  <tr>
    <td>${obj.building}&nbsp;</td>
    <td>${obj.floor}&nbsp;</td>
    <td>${obj.room}&nbsp;</td>
    <td>

    <s:radio list="beds" name="bedID" id="bedID"  listKey="value" listValue="label" theme="simple" onclick="$('#hiddenRoom').val(this.value)"></s:radio>
	</td>
   </tr>
   </s:iterator>
   <tr>
      <td colspan="4" style="text-align:center;">
       	手工输入床位信息：楼号<input name="lou" id="lou" type="text" value="" size="8"/>&nbsp;&nbsp;寝室号<input name="room" id="room" type="text" value="" size="8"/>
 	  </td>
   </tr> 
   <tr>
      <td colspan="4" style="text-align:center;">
      	<s:if test="student.roombed == null">
        <input name="submitbut" type="button" class="btn" value="分配床位给学生" id="assignBedToStudent"/>&nbsp;&nbsp;
        </s:if>
        <!-- 
        <input name="closebut" type="button" class="btn" value="关闭" onclick="$.colorbox.close()" />
        -->
 	  </td>
   </tr>
</table>
</body>
</html>