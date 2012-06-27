<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案详情</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<!--startprint-->
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">学生基本信息</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学号&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${studentDTO.studentNo}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		            ${studentDTO.name}
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">学院&nbsp;</td>
	          <td  width="30%">
		         ${studentDTO.collegeName}
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">性别&nbsp;</td>
	          <td  width="35%">
		          ${studentDTO.sexDesc}
	          </td>
        </tr>
        
       <tr>
	          <td height="30" width="20%" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">专业&nbsp;</td>
	          <td  width="30%" bgcolor="#F1F4F9">
		         ${studentDTO.majorName}
	          </td>
	           <td height="30" width="15%" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">出生年月&nbsp;</td>
	          <td  width="35%" bgcolor="#F1F4F9">
		          <fmt:formatDate value="${studentDTO.birthday }" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">班级&nbsp;</td>
	          <td  width="30%">
		        ${studentDTO.className }
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">身份证号&nbsp;</td>
	          <td  width="35%">
		         ${studentDTO.IDcard }
	          </td>
        </tr>
        
          
        <tr>
	          <td height="30" width="20%" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号&nbsp;</td>
	          <td  width="30%" bgcolor="#F1F4F9">
		        ${studentDTO.examineeNo }
	          </td>
	           <td height="30" width="15%" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">入学时间&nbsp;</td>
	          <td  width="35%" bgcolor="#F1F4F9">
		        <fmt:formatDate value="${studentDTO.inDate }" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">移交人&nbsp;</td>
	          <td  width="30%">
		        ${archives.transfer }
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">接收人&nbsp;</td>
	          <td  width="35%">
		        ${archives.recipient }
	          </td>
        </tr>
        
         <tr>
	          <td height="30" width="20%" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">档案状态&nbsp;</td>
	          <td  width="30%" bgcolor="#F1F4F9">
		       <c:if test="${archives eq null}">缺档</c:if>  ${archives.status }
	          </td>
	           <td height="30" width="15%" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">档案库位&nbsp;</td>
	          <td  width="35%" bgcolor="#F1F4F9">
		        ${archives.storeInfo }${archives eq null?"未入库":"" }
	          </td>
        </tr>
        
      </table></td>
    </tr>
  </table>
</div>
<br/>
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">调阅详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调阅单位&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${lendLog.organization}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调阅时间&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		            <fmt:formatDate value="${lendLog.lendDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">计划归档时间&nbsp;</td>
	          <td  width="30%">
		         <fmt:formatDate value="${lendLog.returnDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">实际归档时间&nbsp;</td>
	          <td  width="35%">
		          <fmt:formatDate value="${returnLog.returnDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
	          </td>
        </tr>
        
       <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">经办人&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${lendLog.operater }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">备注&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		          ${outLog.remark }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">扫描文件名&nbsp;</td>
	          <td  colspan="3">
		        ${lendLog.fileName }
	          </td>
        </tr>
        
        
      </table></td>
    </tr>
  </table>
</div>	
	
<br/>
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">调出详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调出单位&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${outLog.organization}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调出时间&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		          <fmt:formatDate value="${outLog.outDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">经办人&nbsp;</td>
	          <td  width="30%">
		         ${outLog.operater }
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">备注&nbsp;</td>
	          <td  width="35%">
		          ${outLog.remark }
	          </td>
        </tr>
       
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">扫描文件名&nbsp;</td>
	          <td colspan="3" bgcolor="#F1F4F9">
		        ${outLog.fileName }
	          </td>
        </tr>
        
        
      </table></td>
    </tr>
  </table>
</div>	
<!--endprint-->
<br />
<div style="text-align: center" class="mid1003_r">
  <input name="button" type="button" class="btn" value="打 印" style="border:1px solid #7E9FD0; color:#FFFFFF; background:#C4E2F9; height:22px; line-height:22px; padding:0px 5px; color:#5F7F98;"  onclick="execPrint()" /> &nbsp;&nbsp; 
  <input name="button" type="button" class="btn" value="返 回"  style="border:1px solid #7E9FD0; color:#FFFFFF; background:#C4E2F9; height:22px; line-height:22px; padding:0px 5px; color:#5F7F98;" onclick="history.back();" />
</div>
</body>
</html>