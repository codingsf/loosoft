package com.drcl.report.web;

import java.io.File;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

import org.apache.struts2.ServletActionContext;

import cn.common.lib.util.web.PropertyUtils;

import com.drcl.report.vo.NoticeCertVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 证书打印
 * 
 * @author qingang
 * @version 1.0
 * @since 2011-1-17
 */
public class NoticecertPrintAction extends ActionSupport
{
    private static final long serialVersionUID = 1L;
    String tiaomaPath = PropertyUtils.getPropertiy("tiaomaPath");

    @Override
    public String execute() throws Exception
    {
        File reportFile = new File(ServletActionContext.getRequest()
                .getRealPath("/jasper/notice.jasper"));

        HttpServletRequest request = ServletActionContext.getRequest();
        String sessionId = request.getParameter("sessionId");

        /*        if(printContent == null)
        {
            printContent = "";
        }
        else
        {
            //printContent = java.net.URLDecoder.decode(printContent, "UTF-8");
            printContent = new String(printContent.getBytes("iso-8859-1"), "UTF-8");
        }*/

        //解析内容
        List<NoticeCertVO> noticeCertvoList = (List<NoticeCertVO>)request.getSession().getServletContext().getAttribute(sessionId);
        //Json2JavaUtil.json2JavaList(printContent, NoticeCertVO.class, new String[]{}, null);

        JasperPrint jasperPrint = null;
        try
        {   
            Map<String,String> paMap = new HashMap<String,String>();
            paMap.put("BaseDir",tiaomaPath);
            JasperReport jasperReport = (JasperReport) JRLoader
            .loadObject(reportFile);
            jasperPrint = JasperFillManager.fillReport(jasperReport, paMap,
                    new JRBeanCollectionDataSource(noticeCertvoList));
        }
        catch (Exception e)
        {
            throw e;
        }
        if (null != jasperPrint)
        {
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setContentType("application/octet-stream");
            ServletOutputStream ouputStream = response.getOutputStream();
            ObjectOutputStream oos = new ObjectOutputStream(ouputStream);
            oos.writeObject(jasperPrint);
            oos.flush();
            oos.close();
            ouputStream.flush();
            ouputStream.close();
        }
        return null;
    }
}
