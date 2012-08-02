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

import com.drcl.report.vo.RegTableVO;
import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 证书打印
 * 
 * @author qingang
 * @version 1.0
 * @since 2011-1-17
 */
public class RegPrintAction extends ActionSupport
{
    private static final long serialVersionUID = 1L;

    @Override
    public String execute() throws Exception
    {
        File reportFile = new File(ServletActionContext.getRequest()
                .getRealPath("/jasper/regtable.jasper"));

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
        RegTableVO regTableVO = (RegTableVO)request.getSession().getServletContext().getAttribute(sessionId);

        List<RegTableVO> voList = Lists.newArrayList();
        voList.add(regTableVO);
        JasperPrint jasperPrint = null;
        try
        {   
            Map<String,String> paMap = new HashMap<String,String>();
            JasperReport jasperReport = (JasperReport) JRLoader
            .loadObject(reportFile);
            jasperPrint = JasperFillManager.fillReport(jasperReport, paMap,
                    new JRBeanCollectionDataSource(voList));
            //JasperPrintManager.printReport(jasperPrint, false);
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
