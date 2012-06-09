package cn.loosoft.stuwork.backmanage.web.school;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.service.school.ClazzManager;
import cn.loosoft.stuwork.backmanage.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelDownLoad;
import cn.loosoft.stuwork.backmanage.util.ExcelModel;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 班级管理Action.
 * 
 * @author houbing.qian
 * @author shanru.wu
 * @version 1.0
 * @version 1.1
 * @since 2010-8-21
 * @since 2011-3-17
 */
@Namespace("/school")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "clazz.action", type = "redirect"),
        @Result(name = "import", location = "imporclazz.jsp") })
public class ImportclazzAction extends ActionSupport
{

    private static final long         serialVersionUID = 1L;

    private final HttpServletRequest  request          = Struts2Utils
                                                               .getRequest();

    private final HttpServletResponse response         = Struts2Utils
                                                               .getResponse();

    private int                       total            = 0;

    private int                       failnum          = 0;

    @Autowired
    private ClazzManager              clazzManager;

    // 上传文件域对象
    private File                      upload;

    // 上传文件名
    private String                    uploadFileName;

    private String                    flag;

    @Override
    public String execute() throws Exception
    {
        return "importclazz";
    }

    public String importcla() throws Exception
    {
        this.test();
        return "importclazz";
    }

    /**
     * 
     * 测试档案数据是否能够全部导入
     * 
     * @since 2011-1-17
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String test()
    {
        Lists.newArrayList();
        List<String[]> successClazz = Lists.newArrayList(); // 导入成功的学生学号
        List<String[]> errorClazz = Lists.newArrayList(); // 导入失败的学生学号

        if (upload != null)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath("template")
                    + "\\" + uploadFileName;
            clazzManager.judge(upload, dstPath, successClazz, errorClazz, flag);
        }

        if (null != errorClazz && errorClazz.size() > 0)
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据错误，数据将不能全部导入');</script>");
        }
        else
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据正确，数据将全部导入');</script>");
        }

        failnum = errorClazz == null ? 0 : errorClazz.size();
        total = failnum + (successClazz == null ? 0 : successClazz.size());

        request.getSession().setAttribute("errorClazz", errorClazz);
        request.getSession().setAttribute("successClazz", successClazz);

        return "importclazz";
    }

    /**
     * 
     * 导出成功学生信息
     * 
     * @since 2011-1-10
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printSuccessInfo() throws Exception
    {
        List<String[]> successClazz = (List<String[]>) request.getSession()
                .getAttribute("successClazz");

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "入学年份;季节;专业编号;班级名称";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != successClazz && successClazz.size() > 0)
        {
            for (int i = 0; i < successClazz.size(); i++)
            {
                String[] arr = successClazz.get(i);

                ArrayList rowData = new ArrayList();
                rowData.add(arr[0]);
                rowData.add(arr[1]);
                rowData.add(arr[2]);
                rowData.add(arr[3]);
                rowData.add(arr[4]);
                data.add(rowData);
            }
        }
        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("导入成功班级信息");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {
            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("导入成功班级信息.xls", excel, response);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        request.getSession().removeAttribute("successClazz"); // 销毁Session
        return null;

    }

    /**
     * 
     * 导出失败学生信息
     * 
     * @since 2011-1-10
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printErrorInfo() throws Exception
    {
        List<String[]> errorClazz = (List<String[]>) request.getSession()
                .getAttribute("errorClazz");

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "入学年份;季节;专业编号;班级名称;导入失败原因";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();
        if (null != errorClazz && errorClazz.size() > 0)
        {
            for (int i = 0; i < errorClazz.size(); i++)
            {
                String[] arr = errorClazz.get(i);

                ArrayList rowData = new ArrayList();
                rowData.add(arr[0]);
                rowData.add(arr[1]);
                rowData.add(arr[2]);
                rowData.add(arr[3]);
                rowData.add(arr[4]);
                data.add(rowData);
            }

            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("导入失败班级信息");
            // 设置报表内容
            excel.setData(data);
            // ExcelOperator excelOperator = new ExcelOperator();
            // excelOperator.WriteExcel(excel);
            // 写入到Excel格式输出流供下载
            try
            {
                // 调用自编的下载类，实现Excel文件的下载
                ExcelDownLoad downLoad = new BaseExcelDownLoad();

                // 不生成文件，直接生成文件输出流供下载
                downLoad.downLoad("导入失败班级信息.xls", excel, response);
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
        request.getSession().removeAttribute("errorClazz");
        return null;
    }

    public void setUpload(File upload)
    {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName)
    {
        this.uploadFileName = uploadFileName;
    }

    public int getTotal()
    {
        return total;
    }

    public int getFailnum()
    {
        return failnum;
    }

    public void setFlag(String flag)
    {
        this.flag = flag;
    }

}