<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ page import="net.sf.jasperreports.engine.export.*" %>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*" %>
<%@ page import="java.io.*" %>

<%@ page import="com.drcl.report.vo.*" %>

<%@page import="cn.common.lib.util.web.PropertyUtils"%><html>
  <head>
    <title>注册表打印</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <script>
  	function print(){ 
		var url = "../regtableprint.action?sessionId=${sessionId}"; 
		//document.write('<OBJECT WIDTH = "0" HEIGHT = "0" classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" codebase="http://java.sun.com/update/1.6.0/jinstall-6u14-windows-i586.cab#Version=6,0,0,8">');
		//document.write('<PARAM name="java_code" value="JRPrinterApplet.class"><PARAM name="java_codebase" value="applets"><PARAM name="java_archive" value="JRPrinterApplet.jar,jasperreports-3.5.2-applet.jar,commons-logging-1.0.2.jar,commons-collections-2.1.jar"><PARAM name="type" value="application/x-java-applet;version=1.6"><PARAM name="java_type" value="application/x-java-applet;version=1.2.2"><PARAM name="scriptable" value="false">');
		//document.write('<PARAM name="REPORT_URL" value="'+url+'">');
		//document.write('<COMMENT><EMBED type="application/x-java-applet;version=1.6" pluginspage="http://java.sun.com/products/plugin/" java_code="JRPrinterApplet.class" java_codebase="applets" java_archive="jasperreports-3.5.2-applet.jar,commons-logging-1.0.2.jar,commons-collections-2.1.jar" java_type="application/x-java-applet;version=1.2.2" scriptable="false" REPORT_URL="'+url+'"/>');
		//document.write('<NOEMBED></NOEMBED></COMMENT></OBJECT>');
		document.getElementById("printF").src="printApplet.jsp?sessionId=${sessionId}";
		//window.setTimeout("closeWin()",5000);
	}

	function closeWin(){
		window.close();
	}
  </script>
<body>
<center>
<p style=" line-height: 40px;  font-weight:lighter; "></p> 
<input type="button" value="打印" name="button1" onclick="print();">&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="关闭" name="button1" onclick="closeWin();">

</center>
<%
	File reportFile = new File(application.getRealPath("/jasper/regtable.jasper"));
    if (!reportFile.exists()){
		throw new JRRuntimeException("File WebappReport.jasper not found. The report design must be compiled first.");
	}
	JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
	List<RegTableVO> certList = (List<RegTableVO>)request.getAttribute("datas");
	Map<String,String> paMap = new HashMap<String,String>();
	JasperPrint jasperPrint = 
		JasperFillManager.fillReport(
			jasperReport, 
			paMap, 
			new net.sf.jasperreports.engine.data.JRBeanCollectionDataSource(certList)
			);
				
	JRHtmlExporter exporter = new JRHtmlExporter();

	session.setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
	exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
	exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "./image?image=");
	
	exporter.exportReport();
%>
<iframe id="printF"></iframe>
</body>
</html>
