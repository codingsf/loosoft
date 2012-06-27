//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.arch.web.archives;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.batch.Welbatch;
import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;
import cn.loosoft.stuwork.arch.entity.outlog.OutLog;
import cn.loosoft.stuwork.arch.entity.returnlog.ReturnLog;
import cn.loosoft.stuwork.arch.entity.store.Store;
import cn.loosoft.stuwork.arch.entity.sys.Dictionary;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.batch.WelbatchManager;
import cn.loosoft.stuwork.arch.service.lendlog.LendLogManager;
import cn.loosoft.stuwork.arch.service.outlog.OutlogManager;
import cn.loosoft.stuwork.arch.service.returnlog.ReturnLogManager;
import cn.loosoft.stuwork.arch.service.store.StoreManager;
import cn.loosoft.stuwork.arch.service.sys.DictionaryManager;
import cn.loosoft.stuwork.arch.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.arch.util.Code39;
import cn.loosoft.stuwork.arch.util.EmisZipUtil;
import cn.loosoft.stuwork.arch.util.ExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelModel;
import cn.loosoft.stuwork.arch.vo.ArchivesVO;

import com.google.common.collect.Lists;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 
 * 入库管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-17
 */
@Namespace("/archives")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "archives.action", type = "redirect"),
        @Result(name = ArchivesAction.DETAIL, location = "archivesDetail.jsp"),
        @Result(name = "printImage", location = "printImage.jsp"),
        @Result(name = "import", location = "importarchives.jsp") })
public class ArchivesAction extends CrudActionSupport<Archives>
{
    private static final long                  serialVersionUID = 1L;

    private final HttpServletRequest           request          = Struts2Utils
                                                                        .getRequest();

    private final HttpServletResponse          response         = Struts2Utils
                                                                        .getResponse();

    private static final String                DETAIL           = "detail";

    private ArchivesManager                    archivesManager;                                              // 档案信息

    private DictionaryManager                  dictionaryManager;                                            // 系统字典信息

    private InstituteWebService                instituteWebService;                                          // 院系信息

    private SpecialtyWebService                specialtyWebService;                                          // 专业信息

    private WelbatchManager                    welbatchManager;                                              // 批次信息

    private ClazzWebService                    clazzWebService;                                              // 班级信息

    private StoreManager                       storeManager;                                                 // 库位信息

    private StudentWebService                  studentWebService;                                            // 学生信息

    LendLogManager                             lendLogManager;                                               // 调阅信息

    OutlogManager                              outlogManager;                                                // 调出信息

    ReturnLogManager                           returnLogManager;                                             // 归档信息

    private final cn.loosoft.stuwork.arch.Page commonPage       = new cn.loosoft.stuwork.arch.Page();

    // --页面属性-- //
    private String                             stuNoImg;

    private List<InstituteDTO>                 colleges;                                                     // 学院列表

    private List<SpecialtyDTO>                 majors;                                                       // 专业列表

    private Long                               id;

    private List<ClazzDTO>                     clazzes;                                                      // 班级列表

    public List<Store>                         areaList;                                                     // 区域列表

    private StudentDTO                         studentDTO;                                                   // 学生实体

    private List<ArchivesVO>                   archivesVOs;                                                  // 学生档案列表

    Archives                                   archives;                                                     // 学生档案

    LendLog                                    lendLog;                                                      // 档案调阅实体

    ReturnLog                                  returnLog;                                                    // 档案归档实体

    OutLog                                     outLog;                                                       // 档案调出实体

    private String                             archivesStr;                                                  // 入库材料串

    private String                             addArchives;                                                  // 页面手动新增入库材料

    private String                             stuId;                                                        // 学号

    private String                             examineeNo;                                                   // 考生号

    private String                             name;                                                         // 姓名

    private String                             period;                                                       // 届数

    private String                             IDcard;                                                       // 身份证号

    // 上传文件域对象
    private File                               upload;

    // 上传文件名
    private String                             uploadFileName;

    // 保存文件的目录路径(通过依赖注入)
    private String                             savePath;

    private String                             total            = "0";

    private String                             failnum          = "0";

    private final String                       failstr          = "";

    private List<LabelValue>                   selectPageList;

    private boolean                            importAll;                                                    // 是否能全部导入

    private String                             actionMessage;

    private String                             successActionMessage;

    private String                             errorActionMessage;

    private final String                       pageCode         = request
                                                                        .getParameter("filter_EQS_pageCode"); // 分页显示数

    String                                     date             = DateFormatUtils
                                                                        .format(
                                                                                new Date(),
                                                                                "yyyyMMddhhmmss");

    // -- ModelDriven 与 Preparable函数 --//
    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        if (null != id)
        {
            this.archives = archivesManager.get(id);

        }
        else
        {
            this.archives = new Archives();

        }
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public Archives getModel()
    {
        return archives;
    }

    // --CURD Action 函数-- //
    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    public String search()
    {
        this.studentDTO = studentWebService.getStudentByStudentNo(stuId);
        if (null == this.studentDTO)
        {
            this.studentDTO = studentWebService
                    .getStudentByExamineeNo(examineeNo);
        }
        if (null == this.studentDTO)
        {
            this.studentDTO = studentWebService.getStudentByIDcard(IDcard);
        }
        if (null != this.studentDTO)
        {
            this.archives = archivesManager.getArchives(this.studentDTO
                    .getStudentNo());
        }
        return INPUT;
    }

    /**
     * 
     * 档案详细信息
     * 
     * @since 2010-12-27
     * @author shanru.wu
     * @return
     */
    public String detail()
    {
        this.studentDTO = studentWebService.getStudentByStudentNo(stuId);
        this.archives = archivesManager.getArchives(studentDTO.getStudentNo());
        return DETAIL;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        this.archivesVOs = convertToArchivesList(getStuNos());
        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        String areaText = request.getParameter("areaText");
        String rankText = request.getParameter("rankText");
        String rowText = request.getParameter("rowText");
        String columnText = request.getParameter("columnText");

        String storeInfo = areaText + "-" + rankText + "-" + rowText + "-"
                + columnText;

        archives.setArchivesInfo(this.getArchivesStr() + this.addArchives);
        archives.setStatus("在库");
        archives.setStuId(this.stuId);
        archives.setName(this.name);
        archives.setExamineeNo(this.examineeNo);
        archives.setStoreInfo(storeInfo);
        archivesManager.save(archives);
        addActionMessage("档案入库成功");
        return RELOAD;
    }

    /**
     * 
     * 将学生、档案信息po转化成vo输出到页面
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @param studentDTOs
     * @return
     */
    public List<ArchivesVO> convertToArchivesList(List<String> stuNos)
    {
        ArchivesVO archivesVO = null;
        StudentDTO studentDTO = null;
        List<ArchivesVO> resList = Lists.newArrayList();
        if (null != stuNos && stuNos.size() > 0)
        {
            for (int i = 0; i < stuNos.size(); i++)
            {
                String studentNo = stuNos.get(i);
                Archives archives = archivesManager.getArchives(studentNo);
                if (null != archives)
                {
                    archivesVO = new ArchivesVO();
                    archivesVO.setStuId(archives.getStuId());
                    archivesVO.setName(archives.getName());
                    archivesVO.setStorageTime(archives.getStorageTime()); // 入库时间
                    archivesVO.setTransfer(archives.getTransfer());// 移交人
                    archivesVO.setRecipient(archives.getRecipient()); // 接收人
                    archivesVO.setStatus(archives.getStatus()); // 档案状态
                    archivesVO.setArchivesInfo(archives.getArchivesInfo()); // 档案库位

                    String[] temp = archives.getStoreInfo().split("-");
                    String areaText = temp[0];
                    String rankText = temp[1];
                    String rowText = temp[2];
                    String columnText = temp[3];

                    String storeInfo = areaText + "区-" + rankText + "排-"
                            + rowText + "行-" + columnText + "列";

                    archivesVO.setStoreInfo(storeInfo); // 档案材料
                    resList.add(archivesVO);
                }
                else
                {
                    studentDTO = studentWebService
                            .getStudentByStudentNo(studentNo);
                    archivesVO = new ArchivesVO();
                    archivesVO.setStuId(studentNo);
                    archivesVO.setName(studentDTO.getName());
                    archivesVO.setStorageTime(null); // 入库时间
                    archivesVO.setStatus("缺档"); // 档案状态
                    archivesVO.setTransfer("");
                    archivesVO.setRecipient("");
                    archivesVO.setArchivesInfo("无"); // 档案材料
                    archivesVO.setStoreInfo("未入库"); // 档案库位
                    resList.add(archivesVO);

                }

            }
        }
        return resList;
    }

    /**
     * 
     * 导出excel
     * 
     * @since 2011-1-10
     * @author Administrator
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {
        String collegeCode = request.getParameter("filter_EQS_collegeCode");
        String majorCode = request.getParameter("filter_EQS_majorCode");
        String classCode = request.getParameter("filter_EQS_classCode");
        List<String> stuNoList = studentWebService.getStudentNos(collegeCode,
                majorCode, classCode, stuId, name, IDcard, period, examineeNo,
                null, null);

        List<StudentDTO> studentDTOs = studentWebService
                .getStudentsByStudentNos(stuNoList);
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;考生号;性别;入库时间;档案状态;库位号;";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != studentDTOs && studentDTOs.size() > 0)
        {
            for (StudentDTO dto : studentDTOs)
            {

                ArrayList rowData = new ArrayList();
                rowData.add(dto.getStudentNo());
                rowData.add(dto.getName());
                rowData.add(dto.getExamineeNo());
                rowData.add(dto.getSexDesc());

                Archives temp = archivesManager.getArchives(dto.getStudentNo()); // 学生档案

                if (null != temp)
                {
                    rowData.add(temp.getStorageTime());
                    rowData.add(temp.getStatus());
                    rowData.add(temp.getStoreInfo());
                }
                else
                {
                    rowData.add("");
                    rowData.add("缺档");
                    rowData.add("未入库");
                }

                data.add(rowData);

            }
            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("学生档案");
            // 设置报表内容
            excel.setData(data);
            // 写入到Excel格式输出流供下载
            try
            {

                // 调用自编的下载类，实现Excel文件的下载
                ExcelDownLoad downLoad = new BaseExcelDownLoad();

                // 不生成文件，直接生成文件输出流供下载
                downLoad.downLoad("学生档案.xls", excel, response);

            }
            catch (Exception e)
            {

                e.printStackTrace();

            }
        }

        return null;
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
        List<String> successStuNos = (List<String>) request.getSession()
                .getAttribute("successStuNos");

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;性别;身份证号;考生号;学院;专业;入学年份;学历;班级;备注";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != successStuNos && successStuNos.size() > 0)
        {
            for (String stuNo : successStuNos)
            {
                StudentDTO dto = studentWebService.getStudentByStudentNo(stuNo);
                ArrayList rowData = new ArrayList();
                rowData.add(dto.getStudentNo());
                rowData.add(dto.getName());
                rowData.add(dto.getSexDesc());
                rowData.add(dto.getIDcard());
                rowData.add(dto.getExamineeNo());
                rowData.add(dto.getMajorName());
                rowData.add(dto.getCollegeName());
                rowData.add(dto.getInDate());
                rowData.add(dto.getEducation());
                rowData.add(dto.getClassName());
                rowData.add(dto.getRemarks());
                data.add(rowData);

            }
            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("导入成功学生信息");
            // 设置报表内容
            excel.setData(data);
            // 写入到Excel格式输出流供下载
            try
            {

                // 调用自编的下载类，实现Excel文件的下载
                ExcelDownLoad downLoad = new BaseExcelDownLoad();

                // 不生成文件，直接生成文件输出流供下载
                downLoad.downLoad("导入成功学生信息.xls", excel, response);

            }
            catch (Exception e)
            {

                e.printStackTrace();

            }
        }
        request.getSession().removeAttribute("successStuNos"); // 销毁Session
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

        List<String> errorStuNos = (List<String>) request.getSession()
                .getAttribute("errorStuNos");

        List<String> errorList = (List<String>) request.getSession()
                .getAttribute("errorList");

        List<List<String>> notExistInfo = (List<List<String>>) request
                .getSession().getAttribute("notExistInfo");
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;性别;身份证号;考生号;学院;专业;入学年份;学历;班级;备注;导入失败原因";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != errorStuNos && errorStuNos.size() > 0)
        {
            for (int i = 0; i < errorStuNos.size(); i++)
            {
                String stuNo = errorStuNos.get(i);
                StudentDTO dto = studentWebService.getStudentByStudentNo(stuNo);
                if (null != dto)
                {
                    ArrayList rowData = new ArrayList();
                    rowData.add(dto.getStudentNo());
                    rowData.add(dto.getName());
                    rowData.add(dto.getSexDesc());
                    rowData.add(dto.getIDcard());
                    rowData.add(dto.getExamineeNo());
                    rowData.add(dto.getMajorName());
                    rowData.add(dto.getCollegeName());
                    rowData.add(dto.getInDate());
                    rowData.add(dto.getEducation());
                    rowData.add(dto.getClassName());
                    rowData.add(dto.getRemarks());
                    rowData.add(errorList.get(i));
                    data.add(rowData);
                }
                else
                {
                    List<String> info = notExistInfo.get(i);
                    ArrayList rowData = new ArrayList();
                    rowData.add(info.get(0));
                    rowData.add(info.get(1));
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add("");
                    rowData.add(errorList.get(i));
                    data.add(rowData);

                }

            }
            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("导入失败学生信息");
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
                downLoad.downLoad("导入失败学生信息.xls", excel, response);

            }
            catch (Exception e)
            {

                e.printStackTrace();

            }
        }

        request.getSession().removeAttribute("errorStuNos");
        request.getSession().removeAttribute("errorList");
        request.getSession().removeAttribute("notExistInfo");

        return null;
    }

    /**
     * 
     * 批量导入新生学号
     * 
     * @since 2010-12-18
     * @author shanru.wu
     * @return
     */
    @Action(value = "/importarchives", params = { "savePath", "" }, results = {
            @Result(name = CrudActionSupport.SUCCESS, location = "/WEB-INF/content/archives/importarchives.jsp", type = "dispatcher"),
            @Result(name = CrudActionSupport.INPUT, location = "/WEB-INF/content/archives/importarchives.jsp", type = "dispatcher") }, interceptorRefs = {
            @InterceptorRef(value = "store", params = { "operationMode",
                    "AUTOMATIC" }),
            @InterceptorRef(value = "fileUpload", params = {
                    "allowedTypes",
                    "application/excel,application/vnd.ms-excel,application/msexcel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" }),
            @InterceptorRef(value = "paramsPrepareParamsStack") })
    public String importarchives() throws Exception
    {
        if (null != upload)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath(savePath)
                    + "\\" + uploadFileName;
            List<String> result = archivesManager.importArchives(upload,
                    dstPath);
            total = result.get(0);
            failnum = result.get(1);
        }
        return SUCCESS;
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
    public String test() throws Exception
    {
        List<String> result = Lists.newArrayList();
        List<String> successStuNos = Lists.newArrayList(); // 导入成功的学生学号
        List<String> errorStuNos = Lists.newArrayList(); // 导入失败的学生学号
        List<String> errorList = Lists.newArrayList(); // 导入的错误原因
        List<List<String>> notExistInfo = Lists.newArrayList(); // 记录导入不存在的学生信息

        if (upload != null)
        {
            // 根据服务器的文件保存地址和原文件名创建目录文件全路径
            String dstPath = ServletActionContext.getServletContext()
                    .getRealPath("template")
                    + "\\" + uploadFileName;
            result = archivesManager.judge(upload, dstPath, successStuNos,
                    errorStuNos, errorList, notExistInfo);
        }

        total = result.get(0);
        failnum = result.get(1);

        if (null != errorStuNos && errorStuNos.size() > 0)
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据错误，数据将不能全部导入');</script>");
        }
        else
        {
            Struts2Utils
                    .renderHtml("<script>alert('导入数据正确，数据将全部导入');</script>");
        }

        request.getSession().setAttribute("successStuNos", successStuNos);
        request.getSession().setAttribute("errorStuNos", errorStuNos);
        request.getSession().setAttribute("errorList", errorList);
        request.getSession().setAttribute("notExistInfo", notExistInfo);

        return "import";
    }

    // --页面属性访问函数-- //
    /**
     * 学生信息
     */
    public StudentDTO getStudentDTO()
    {
        return studentDTO;
    }

    /**
     * 档案信息
     */
    public Archives getArchives()
    {
        return archives;
    }

    /**
     * 调阅信息
     */
    public LendLog getLendLog()
    {
        this.lendLog = lendLogManager.getRecentLendLog(stuId);
        return lendLog;
    }

    /**
     * 
     * 调出信息
     */
    public OutLog getOutLog()
    {
        this.outLog = outlogManager.getOutLog(stuId);
        return outLog;
    }

    /**
     * 归档信息
     */
    public ReturnLog getReturnLog()
    {
        this.returnLog = returnLogManager.getRecentReturnLog(stuId);
        return returnLog;
    }

    public String getArchivesStr()
    {
        this.archivesStr = archivesManager.getArchivesStr() == "" ? ""
                : archivesManager.getArchivesStr();
        return archivesStr;
    }

    /**
     * 入库理由列表
     */
    public List<Dictionary> getStorageReasonList()
    {
        List<Dictionary> storageReasonList = dictionaryManager
                .getByType(Dictionary.RKLY);
        return storageReasonList;
    }

    /**
     * 
     * 学生档案列表
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @return
     */
    public List<ArchivesVO> getArchivesVOs()
    {
        return archivesVOs;
    }

    /**
     * 
     * 专业列表
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @return
     */
    public List<SpecialtyDTO> getMajors()
    {
        String collegeCode = request.getParameter("filter_EQS_collegeCode");
        majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        if (null == majors)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }
        return majors;
    }

    /**
     * 
     * 院系列表
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @return
     */
    public List<InstituteDTO> getColleges()
    {
        this.colleges = instituteWebService.getInstitutes();
        if (null == colleges)
        {
            this.colleges = new ArrayList<InstituteDTO>();
        }
        return colleges;
    }

    /**
     * 
     * 班级列表
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @return
     */
    public List<ClazzDTO> getClazzes()
    {
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        String majorCode = request.getParameter("filter_EQS_majorCode"); // 专业代码
        clazzes = clazzWebService.getClazzsBySpecialty(majorCode, "", welbatch
                .getYear(), welbatch.getSeason());
        if (null == clazzes)
        {
            this.clazzes = new ArrayList<ClazzDTO>();

        }
        return clazzes;
    }

    public String getAddArchives()
    {
        return addArchives;
    }

    /**
     * 
     * 区域列表
     * 
     * @since 2010-12-23
     * @author shanru.wu
     * @return
     */
    public List<Store> getAreaList()
    {
        this.areaList = storeManager.getAll();
        if (this.areaList == null)
        {
            this.areaList = new ArrayList<Store>();
        }
        return areaList;
    }

    /**
     * 学号列表
     * 
     * @since 2010-12-24
     * @author shanru.wu
     * @return
     * @return
     */
    public List<String> getStuNos()
    {
        String collegeCode = request.getParameter("filter_EQS_collegeCode");
        String majorCode = request.getParameter("filter_EQS_majorCode");
        String classCode = request.getParameter("filter_EQS_classCode");

        if (pageCode == "" || pageCode == null)
        {
            commonPage.setPageSize(15);
        }
        else
        {
            commonPage.setPageSize(Integer.parseInt(pageCode));
        }
        commonPage.setTotalCount(Integer.parseInt(String
                .valueOf(studentWebService.countStudent(collegeCode, majorCode,
                        classCode, stuId, name, IDcard, period, examineeNo,
                        null, null))));

        List<String> stuNos = studentWebService.getStudentNosByCondition(
                collegeCode, majorCode, classCode, stuId, name, IDcard, period,
                examineeNo, null, null, commonPage.getPageNo(), commonPage
                        .getPageSize());

        return stuNos;
    }

    /**
     * 
     * 打印条形码
     * 
     * @since 2011-1-10
     * @author Administrator
     * @return
     * @throws Exception
     */
    public String print() throws Exception
    {
        // String filePath = "d:\\StuNoImg";
        String localFilePath = PropertyUtils.getProperty(
                "outlog.outlog.file.path", RequestUtils.getRealPath(
                        ServletActionContext.getServletContext(), "template"));
        localFilePath = localFilePath + "\\" + date;
        File myFilePath = new File(localFilePath);
        if (!myFilePath.exists())
        {
            myFilePath.mkdir();
        }

        String collegeCode = request.getParameter("filter_EQS_collegeCode");
        String majorCode = request.getParameter("filter_EQS_majorCode");
        String classCode = request.getParameter("filter_EQS_classCode");
        List<String> stunoList = studentWebService.getStudentNos(collegeCode,
                majorCode, classCode, stuId, name, IDcard, period, examineeNo,
                null, null);
        List<String> imgList = Lists.newArrayList();
        Code39 code = new Code39();

        if (stunoList != null)
        {
            for (int i = 0; i < stunoList.size(); i++)
            {
                StudentDTO student = studentWebService
                        .getStudentByStudentNo(stunoList.get(i));
                code
                        .getImage("*" + student.getExamineeNo() + "*",
                                localFilePath + "\\" + student.getExamineeNo()
                                        + ".jpg");
                imgList.add(student.getExamineeNo());
            }
            CreateImg(imgList);
            stuNoImg = "生成条形码成功!<a href=\"/stuwork-archives/attachment/download.action?name="
                    + date + ".zip\">点击下载</a>";
            this.archivesVOs = convertToArchivesList(getStuNos());
            return SUCCESS;
        }
        else
        {
            return SUCCESS;
        }
    }

    /**
     * 
     * 绘制一张所有学号的图片
     * 
     * @since 2011-1-10
     * @author Administrator
     * @return
     * @throws Exception
     */
    public void CreateImg(List<String> imgList) throws Exception
    {
        String localFilePath = PropertyUtils.getProperty(
                "outlog.outlog.file.path", RequestUtils.getRealPath(
                        ServletActionContext.getServletContext(), "template"));
        localFilePath = localFilePath + "\\" + date;
        int sum = imgList.size() % 20 == 0 ? imgList.size() / 20 : imgList
                .size() / 20 + 1;// 总共多少张图片
        // int count = 0;
        for (int c = 0; c < sum; c++)
        {
            int count = 0;
            Date now = new Date();
            DateFormat dfs = DateFormat.getDateTimeInstance();
            String time = dfs.format(now);
            time = time.replace("-", "");
            time = time.replace(":", "").trim();
            File myFilePath = new File(localFilePath);
            if (!myFilePath.exists())
            {
                myFilePath.mkdir();
            }
            stuNoImg = localFilePath + "\\" + c + ".jpg";
            File myPNG = new File(stuNoImg);
            OutputStream out = new FileOutputStream(myPNG);
            BufferedImage bi = new BufferedImage(620, 700,
                    BufferedImage.TYPE_INT_RGB);
            Graphics g = bi.getGraphics();
            g.setColor(Color.WHITE);
            g.fillRect(0, 0, 620, 700);// 填充满背景色
            List<Image> ImageList = Lists.newArrayList();
            for (int i = 0; i < imgList.size(); i++)
            {
                if (count == 20)
                {
                    break;
                }
                count = count + 1;
                Image img = ImageIO.read(new File(localFilePath + "\\"
                        + imgList.get(i).toString() + ".jpg"));
                ImageList.add(img);

            }
            if (imgList.size() > 20)
            {
                for (int d = 0; d < 20; d++)
                {
                    imgList.remove(0);
                }
            }
            else
            {
                int imgCount = imgList.size();
                for (int d = 0; d < imgCount; d++)
                {
                    imgList.remove(0);
                }
            }
            int shuangxx = 0;
            int x = 28;// x轴
            int y = 10;// y轴
            for (int i = 0; i < ImageList.size(); i++)
            {

                if ((i + 1) % 2 != 0)
                {// 13

                    if (i > 0)// dan的时候
                    {
                        int danheight = y;
                        for (int a = 0; a < i / 2; a++)
                        {

                            danheight = danheight
                                    + ImageList.get(a).getHeight(null) + 20;
                        }

                        g.drawImage(ImageList.get(i), x, danheight, null);// 单张图片位置

                    }
                    else
                    {
                        g.drawImage(ImageList.get(i), x, y, null);// 图片位置
                    }

                }
                else
                {// 24
                    shuangxx = ImageList.get(i).getWidth(null) + 20 + x;
                    int shuangheight = y;
                    if (i > 2)
                    {
                        for (int a = 0; a < i / 2; a++)
                        {
                            shuangheight = shuangheight
                                    + ImageList.get(a).getHeight(null) + 20;
                        }
                        g.drawImage(ImageList.get(i), shuangxx, shuangheight,
                                null);// 双张图片位置
                    }
                    else
                    {
                        g.drawImage(ImageList.get(i), shuangxx, shuangheight,
                                null);// 双张图片位置
                    }
                }

            }
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(bi);
            while (true) // 图片生成完毕后，向下运行
            {
                if (myPNG.exists())
                {

                    break;
                }
            }
        }
        try
        {
            EmisZipUtil util = new EmisZipUtil(localFilePath + ".zip");
            // util.buf = new byte[1024*2]; //可以指定缓存
            util.put(localFilePath);
            util.close();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 届数
     */
    public String getPeriod()
    {
        return period;
    }

    /**
     * 姓名
     */
    public String getName()
    {
        return name;
    }

    /**
     * 学号
     */
    public String getStuId()
    {
        return stuId;
    }

    /**
     * 身份证号
     */
    public String getIDcard()
    {
        return IDcard;
    }

    /**
     * 考生号
     */
    public String getExamineeNo()
    {
        return examineeNo;
    }

    public boolean isImportAll()
    {
        return importAll;
    }

    public String getActionMessage()
    {
        return actionMessage;
    }

    public String getStuNoImg()
    {
        return stuNoImg;
    }

    public String getSuccessActionMessage()
    {
        return successActionMessage;
    }

    public String getErrorActionMessage()
    {
        return errorActionMessage;
    }

    public cn.loosoft.stuwork.arch.Page getCommonPage()
    {
        return commonPage;
    }

    public String getTotal()
    {
        return total;
    }

    public String getFailnum()
    {
        return failnum;
    }

    public String getFailstr()
    {
        return failstr;
    }

    /**
     * @return the selectPageList
     */
    public List<LabelValue> getSelectPageList()
    {
        selectPageList = new ArrayList<LabelValue>();
        selectPageList.add(new LabelValue("10", "10"));
        selectPageList.add(new LabelValue("15", "15"));
        selectPageList.add(new LabelValue("20", "20"));
        return selectPageList;
    }

    // --其他 Action 函数-- //

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

    @Autowired
    public void setStoreManager(StoreManager storeManager)
    {
        this.storeManager = storeManager;
    }

    @Autowired
    public void setLendLogManager(LendLogManager lendLogManager)
    {
        this.lendLogManager = lendLogManager;
    }

    @Autowired
    public void setOutlogManager(OutlogManager outlogManager)
    {
        this.outlogManager = outlogManager;
    }

    @Autowired
    public void setReturnLogManager(ReturnLogManager returnLogManager)
    {
        this.returnLogManager = returnLogManager;
    }

    @Autowired
    public void setDictionaryManager(DictionaryManager dictionaryManager)
    {
        this.dictionaryManager = dictionaryManager;
    }

    public void setUpload(File upload)
    {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName)
    {
        this.uploadFileName = uploadFileName;
    }

    public void setSavePath(String savePath)
    {
        this.savePath = savePath;
    }

    public void setAddArchives(String addArchives)
    {
        this.addArchives = addArchives;
    }

    public void setStuId(String stuId)
    {
        this.stuId = stuId;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setPeriod(String period)
    {
        this.period = period;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

}
