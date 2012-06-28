<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案详情</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

	
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">档案详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td  width="10%" height="30" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">学号</td>
	          <td width="40%" bgcolor="#F1F4F9" >${archivesDTO.stuId}</td>
		      <td  width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名&nbsp;</td>
	          <td  width="40%" bgcolor="#F1F4F9">
	          	${archivesDTO.name}
			  </td>	
        </tr>

        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">考生号</td>
	          <td  >
		         ${archivesDTO.examineeNo }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">档案信息</td>
	          <td  >
		         ${archivesDTO.archivesInfo }
	          </td>
        </tr>
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入库时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <fmt:formatDate value="${archivesDTO.storageTime }" type="date" pattern="yyyy-MM-dd"/>
	          </td>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">库位信息</td>
	          <td bgcolor="#F1F4F9" >
		        ${archivesDTO.storeInfo }
	          </td>
        </tr>

        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">接收人</td>
	          <td  >
		        ${archivesDTO.recipient }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">移交人</td>
	          <td  >
		        ${archivesDTO.transfer }
	          </td>
        </tr>
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">状态&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${archivesDTO.status }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">操作人&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${archivesDTO.operater }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">入库理由&nbsp;</td>
	          <td colspan="3">${archivesDTO.reason }</td>
        </tr>
        
       
        
      </table></td>
    </tr>
    <tr>
      <td align="center" height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
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
		        ${archivesDTO.lendOrganization}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调阅时间&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		            <fmt:formatDate value="${archivesDTO.lendDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">计划归档时间&nbsp;</td>
	          <td  width="30%">
		         <fmt:formatDate value="${archivesDTO.lendPlanDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">实际归档时间&nbsp;</td>
	          <td  width="35%">
		          <fmt:formatDate value="${archivesDTO.returnDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
	          </td>
        </tr>
        
       <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">经办人&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${archivesDTO.lendOperater }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">备注&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		          ${archivesDTO.lendRemark }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">扫描文件名&nbsp;</td>
	          <td  colspan="3">
		        ${archivesDTO.lendFileName }
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
		        ${archivesDTO.outOrganization}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调出时间&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		          <fmt:formatDate value="${archivesDTO.outDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" />
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">经办人&nbsp;</td>
	          <td  width="30%">
		         ${archivesDTO.outOperater }
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">备注&nbsp;</td>
	          <td  width="35%">
		          ${archivesDTO.outRemark }
	          </td>
        </tr>        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">扫描文件名&nbsp;</td>
	          <td colspan="3" bgcolor="#F1F4F9">
		        ${archivesDTO.outFileName}
	          </td>
        </tr>
        
        
      </table></td>
    </tr>
  </table>
</div>

</body>
</html>