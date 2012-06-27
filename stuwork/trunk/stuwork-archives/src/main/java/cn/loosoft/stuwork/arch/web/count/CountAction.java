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
package cn.loosoft.stuwork.arch.web.count;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

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
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.batch.WelbatchManager;
import cn.loosoft.stuwork.arch.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelModel;
import cn.loosoft.stuwork.arch.vo.ArchivesVO;
import cn.loosoft.stuwork.common.ArchiveType;

import com.google.common.collect.Lists;

/**
 * 
 * 档案统计管理Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/count")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "count.action", type = "redirect") })
public class CountAction extends CrudActionSupport<Archives>
{

    /**
     * serialVersionUID long
     */
    private static final long                  serialVersionUID = 1L;

    private ArchivesManager                    archivesManager;                                                 // 入库管理

    private WelbatchManager                    welbatchManager;                                                 // 批次信息

    private Archives                           stuArchives;                                                     // 入库实体

    private final HttpServletRequest           request          = Struts2Utils
                                                                        .getRequest();

    private final HttpServletResponse          response         = Struts2Utils
                                                                        .getResponse();

    @Autowired
    private InstituteWebService                instituteWebService;                                             // 院系

    @Autowired
    private SpecialtyWebService                specialtyWebService;                                             // 专业

    @Autowired
    private ClazzWebService                    clazzWebService;                                                 // 班级信息

    private List<SpecialtyDTO>                 majors;                                                          // 专业列表

    private List<ClazzDTO>                     clazzes;                                                         // 班级

    private final String                       collegeCode      = request
                                                                        .getParameter("filter_EQS_collegeCode"); // 院系代码

    private final String                       majorCode        = request
                                                                        .getParameter("filter_EQS_majorCode");  // 专业代码

    private List<StudentDTO>                   studentDTOs;                                                     // 学生列表

    private List<ArchivesVO>                   archivesVOs;                                                     // 学生档案列表

    private List<LabelValue>                   archiveType;

    @Autowired
    private StudentWebService                  studentWebService;

    private final List<ArchivesVO>             tempList         = Lists
                                                                        .newArrayList();

    private final cn.loosoft.stuwork.arch.Page commonPage       = new cn.loosoft.stuwork.arch.Page();

    private List<String>                       stunoList;

    private final String                       pageCode         = request
                                                                        .getParameter("filter_EQS_pageCode");   // 分页显示数

    private List<LabelValue>                   selectPageList;

    private String                             actionMessage;                                                   // 提示信息

    /**
     * @return the actionMessage
     */
    public String getActionMessage()
    {
        return actionMessage;
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

    /**
     * @param stunoList
     *            the stunoList to set
     */
    public void setStunoList(List<String> stunoList)
    {
        this.stunoList = stunoList;
    }

    /**
     * @return the stunoList
     */
    public List<String> getStunoList()
    {
        stunoList = getStuNos();
        return stunoList;
    }

    /**
     * @return the commonPage
     */
    public cn.loosoft.stuwork.arch.Page getCommonPage()
    {
        return commonPage;
    }

    public List<LabelValue> getArchiveType()
    {
        archiveType = ArchiveType.enumList;
        return archiveType;
    }

    /**
     * 
     * 分页查询学档案信息
     * 
     * @since 2010-12-24
     * @author shanru.wu
     * @param archivesVOs
     * @return
     */
    public void pageQuery(List<ArchivesVO> archivesVOs)
    {
        if (null != archivesVOs && archivesVOs.size() > 0)
        {
            for (int i = (commonPage.getPageNo() - 1)
                    * commonPage.getPageSize(); i < (commonPage.getPageNo())
                    * commonPage.getPageSize(); i++)
            {
                if (archivesVOs.size() <= i)
                {
                    break;
                }
                this.tempList.add(archivesVOs.get(i));
            }
        }
    }

    // 院系
    public List<InstituteDTO> getColleges()
    {
        return instituteWebService.getInstitutes();
    }

    public List<ClazzDTO> getClazzes()
    {
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        if (welbatch != null)
        {
            this.clazzes = clazzWebService.getClazzsBySpecialty(majorCode, "",
                    welbatch.getYear(), welbatch.getSeason());
            if (this.clazzes == null)
            {
                this.clazzes = new ArrayList<ClazzDTO>();
            }
        }
        return this.clazzes;
    }

    public List<SpecialtyDTO> getMajors()
    {
        this.majors = specialtyWebService.getSpecialtysByCollege(collegeCode);

        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }
        return this.majors;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    @Deprecated
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
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
        List<String> stunoList = getStuNos();
        this.archivesVOs = convertToArchivesList(stunoList);
        pageQuery(archivesVOs);
        if (pageCode == "" || pageCode == null)
        {
            commonPage.setPageSize(15);
        }
        else
        {
            commonPage.setPageSize(Integer.parseInt(pageCode));
        }
        commonPage.setTotalCount(archivesVOs.size());
        return SUCCESS;
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
        String collegeCode = request.getParameter("filter_EQS_collegeCode") == "" ? null
                : request.getParameter("filter_EQS_collegeCode");
        String majorCode = request.getParameter("filter_EQS_majorCode") == "" ? null
                : request.getParameter("filter_EQS_majorCode");
        String classCode = request.getParameter("filter_EQS_classCode") == "" ? null
                : request.getParameter("filter_EQS_classCode");
        String tempPeriod = request.getParameter("period") == "" ? null
                : request.getParameter("period");
        String inDate = request.getParameter("inDate") == "" ? null : request
                .getParameter("inDate");

        List<String> stuNos = studentWebService.getStudentNosByCondition(
                collegeCode, majorCode, classCode, null, null, null,
                tempPeriod, null, null, inDate, commonPage.getPageNo(),
                commonPage.getPageSize());
        return stuNos;
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
        String status = request.getParameter("filter_EQS_status");

        ArchivesVO archivesVO = null;
        Map<String, Integer> classList = new HashMap<String, Integer>();
        List<ArchivesVO> resList = Lists.newArrayList();
        if (stuNos != null)
        {
            if (status == "" || status == null)
            {
                for (int i = 0; i < stuNos.size(); i++)
                {
                    String studentNo = stuNos.get(i);
                    StudentDTO studentDTO = studentWebService
                            .getStudentByStudentNo(studentNo);
                    Archives archives = archivesManager.getArchives(studentDTO
                            .getStudentNo());
                    if (null == archives)
                    {
                        Integer count = 0;
                        if (classList.containsKey(studentDTO.getClassCode()
                                + "缺档"))
                        {
                            count = classList.get(studentDTO.getClassCode()
                                    + "缺档");
                            classList.put(studentDTO.getClassCode() + "缺档",
                                    count + 1);
                            for (int j = 0; j < resList.size(); j++)
                            {
                                if (resList.get(j).getClassCode().equals(
                                        studentDTO.getClassCode())
                                        && resList.get(j).getStatus().equals(
                                                "缺档"))
                                {
                                    resList.remove(j);
                                    break;
                                }
                            }

                        }
                        else
                        {
                            count = 1;
                            classList.put(studentDTO.getClassCode() + "缺档",
                                    count);
                        }
                        archivesVO = new ArchivesVO();
                        archivesVO.setCollegeName(studentDTO.getCollegeName()); // 院系名称

                        archivesVO.setMajorName(studentDTO.getMajorName()); // 专业名称
                        archivesVO.setClassCode(studentDTO.getClassCode()); // 班级Code
                        archivesVO.setClassName(studentDTO.getClassName());// 班级名称
                        archivesVO.setStatus("缺档");// 状态
                        archivesVO.setClassCount(classList.get(studentDTO
                                .getClassCode()
                                + "缺档"));// 班级人数

                        resList.add(archivesVO);
                        continue;
                        // continue;
                    }

                    Integer count = 0;

                    if (classList.containsKey(studentDTO.getClassCode()
                            + archives.getStatus()))
                    {
                        count = classList.get(studentDTO.getClassCode()
                                + archives.getStatus());
                        classList.put(studentDTO.getClassCode()
                                + archives.getStatus(), count + 1);
                        for (int j = 0; j < resList.size(); j++)
                        {
                            if (resList.get(j).getClassCode().equals(
                                    studentDTO.getClassCode())
                                    && resList.get(j).getStatus().equals(
                                            archives.getStatus()))
                            {
                                resList.remove(j);

                                break;
                            }
                        }

                    }
                    else
                    {
                        count = 1;
                        classList.put(studentDTO.getClassCode()
                                + archives.getStatus(), count);
                    }
                    archivesVO = new ArchivesVO();
                    archivesVO.setCollegeName(studentDTO.getCollegeName()); // 院系名称

                    archivesVO.setMajorName(studentDTO.getMajorName()); // 专业名称
                    archivesVO.setClassCode(studentDTO.getClassCode()); // 班级Code
                    archivesVO.setClassName(studentDTO.getClassName());// 班级名称
                    archivesVO.setStatus(archives.getStatus());// 状态
                    archivesVO.setClassCount(classList.get(studentDTO
                            .getClassCode()
                            + archives.getStatus()));// 班级人数

                    resList.add(archivesVO);
                }

            }
            else
            {

                if (stuNos != null)
                {

                    for (int i = 0; i < stuNos.size(); i++)
                    {
                        String studentNo = stuNos.get(i);
                        StudentDTO studentDTO = studentWebService
                                .getStudentByStudentNo(studentNo);

                        Archives archives = archivesManager
                                .getArchives(studentDTO.getStudentNo());

                        if (null == archives)// 缺档
                        {
                            if (status.equals("缺档"))
                            {

                                Integer count;
                                if (classList.containsKey(studentDTO
                                        .getClassCode()
                                        + "缺档"))
                                {
                                    count = classList.get(studentDTO
                                            .getClassCode()
                                            + "缺档");
                                    classList.put(studentDTO.getClassCode()
                                            + "缺档", count + 1);
                                    for (int j = 0; j < resList.size(); j++)
                                    {
                                        if (resList
                                                .get(j)
                                                .getClassCode()
                                                .equals(
                                                        studentDTO
                                                                .getClassCode())
                                                && resList.get(j).getStatus()
                                                        .equals("缺档"))
                                        {
                                            resList.remove(j);
                                            break;
                                        }
                                    }

                                }
                                else
                                {
                                    count = 1;
                                    classList.put(studentDTO.getClassCode()
                                            + "缺档", count);
                                }
                                archivesVO = new ArchivesVO();
                                archivesVO.setCollegeName(studentDTO
                                        .getCollegeName()); // 院系名称

                                archivesVO.setMajorName(studentDTO
                                        .getMajorName()); // 专业名称
                                archivesVO.setClassCode(studentDTO
                                        .getClassCode()); // 班级Code
                                archivesVO.setClassName(studentDTO
                                        .getClassName());// 班级名称
                                archivesVO.setStatus("缺档");// 状态
                                archivesVO.setClassCount(classList
                                        .get(studentDTO.getClassCode() + "缺档"));// 班级人数

                                resList.add(archivesVO);

                            }
                            continue;
                        }

                        if (archives.getStatus().equals(status))// 如果有相同的班级
                        {
                            Integer count;

                            if (classList.containsKey(studentDTO.getClassCode()
                                    + archives.getStatus()))
                            {
                                count = classList.get(studentDTO.getClassCode()
                                        + archives.getStatus());
                                classList.put(studentDTO.getClassCode()
                                        + archives.getStatus(), count + 1);
                                for (int j = 0; j < resList.size(); j++)
                                {
                                    if (resList.get(j).getClassCode().equals(
                                            studentDTO.getClassCode())
                                            && resList.get(j).getStatus()
                                                    .equals(status))
                                    {
                                        resList.remove(j);

                                        break;
                                    }
                                }

                            }
                            else
                            {
                                count = 1;
                                classList.put(studentDTO.getClassCode()
                                        + archives.getStatus(), count);
                            }

                            archivesVO = new ArchivesVO();
                            archivesVO.setCollegeName(studentDTO
                                    .getCollegeName()); // 院系名称

                            archivesVO.setMajorName(studentDTO.getMajorName()); // 专业名称
                            archivesVO.setClassCode(studentDTO.getClassCode()); // 班级Code
                            archivesVO.setClassName(studentDTO.getClassName());// 班级名称
                            archivesVO.setStatus(archives.getStatus());
                            archivesVO.setClassCount(classList.get(studentDTO
                                    .getClassCode()
                                    + archives.getStatus()));

                            resList.add(archivesVO);

                        }

                    }

                }
            }

        }

        else
        {
            return resList;
        }
        return resList;
    }

    /**
     * 
     * 导出excel
     * 
     * @since 2011-1-8
     * @author Administrator
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {

        List<String> stunoList = getStuNos();
        this.archivesVOs = convertToArchivesList(stunoList);
        if (pageCode == "" || pageCode == null)
        {
            commonPage.setPageSize(15);
        }
        else
        {
            commonPage.setPageSize(Integer.parseInt(pageCode));
        }
        commonPage.setTotalCount(archivesVOs.size());

        pageQuery(archivesVOs);

        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学院;专业;班级;状态;人数;";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        for (int i = 0; i < archivesVOs.size(); i++)
        {

            ArrayList rowData = new ArrayList();
            ArchivesVO archiveVo = archivesVOs.get(i);
            rowData.add(archiveVo.getCollegeName());
            rowData.add(archiveVo.getMajorName());
            rowData.add(archiveVo.getClassName());
            rowData.add(archiveVo.getStatus());
            rowData.add(archiveVo.getClassCount());
            data.add(rowData);

        }
        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("档案统计");
        // 设置报表内容
        excel.setData(data);

        // 写入到Excel格式输出流供下载

        // 调用自编的下载类，实现Excel文件的下载
        ExcelDownLoad downLoad = new BaseExcelDownLoad();

        // 不生成文件，直接生成文件输出流供下载
        downLoad.downLoad("档案统计.xls", excel, response);
        downLoad.downLoad("调出记录.xls", excel, response);
        PageContext pageContext = (PageContext) request.getSession()
                .getAttribute("pageContext");
        JspWriter out = pageContext.getOut();
        out.clear();
        out = pageContext.pushBody();

        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    @Deprecated
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    @Deprecated
    public String save() throws Exception
    {

        // TODO Auto-generated method stub
        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public Archives getModel()
    {
        // TODO Auto-generated method stub
        return stuArchives;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

    /**
     * 
     * 学生档案列表
     * 
     * @since 2010-12-20
     * @author jie.yang
     * @return
     */
    public List<ArchivesVO> getArchivesVOs()
    {
        return archivesVOs;
    }

    /**
     * 
     * 学生列表
     * 
     * @since 2010-12-20
     * @author jie.yang
     * @return
     */
    public List<StudentDTO> getStudentDTOs()
    {
        return studentDTOs;
    }

    public List<ArchivesVO> getTempList()
    {
        return tempList;
    }

}
