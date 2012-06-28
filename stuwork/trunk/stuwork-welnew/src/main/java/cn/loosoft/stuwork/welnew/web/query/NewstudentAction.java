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
package cn.loosoft.stuwork.welnew.web.query;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.DepartmentDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.welnewlocale.SchoolNotice;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.welnewlocale.SchoolNoticeManager;
import cn.loosoft.stuwork.welnew.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelModel;

/**
 * 
 * 新生报道查询Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-3-25
 */
@Namespace("/query")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "newstudent.action", type = "redirect") })
public class NewstudentAction extends CrudActionSupport<SchoolNotice>
{

    /**
     * serialVersionUID long
     */
    private static final long        serialVersionUID = 1L;

    private SchoolNoticeManager      schoolNoticeManager;

    private WelbatchManager          batchManager;

    private InstituteWebService      instituteWebService;

    private SpecialtyWebService      specialtyWebService;

    private ClazzWebService          clazzWebService;

    private final HttpServletRequest request          = Struts2Utils
    .getRequest();

    // -- 页面属性 -- //
    private Long                     id;

    private SchoolNotice             entity;

    private Page<SchoolNotice>       page             = new Page<SchoolNotice>(
            Constant.PAGE_SIZE);                    // 分页列表页面显示数据

    private Long                     batchId;                                                         // 批次ID

    private List<Welbatch>           batches;                                                         // 批次列表

    private List<InstituteDTO>       collegues;                                                       // 学院列表

    private List<DepartmentDTO>      departments;                                                     // 院系列表

    private List<SpecialtyDTO>       majors;                                                          // 专业列表

    private List<ClazzDTO>           clazzes;                                                         // 班级列表

    private final String             collegeCode      = request
    .getParameter("filter_EQS_collegeCode"); // 院系代码

    private final String             majorCode        = request
    .getParameter("filter_EQS_majorCode");  // 专业代码

    private final String             classCode        = request
    .getParameter("filter_EQS_classCode");  // 专业代码

    // 班级代码

    private List<LabelValue>         noticeTypeList;

    public List<LabelValue> getNoticeTypeList()
    {
        try
        {
            this.noticeTypeList = Constant.getNoticeTypeList();
        }
        catch (Exception e)
        {
            e.getStackTrace();
        }
        return noticeTypeList;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Page<SchoolNotice> getPage()
    {
        return page;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("noticeTime");
            page.setOrder(Page.DESC);
        }

        // HttpServletRequest request = ServletActionContext.getRequest();

        request.getParameter("name");

        // page = schoolNoticeManager.search(page, examineeNo, name, batchId,
        // collegeCode, majorCode, classCode);

        // List<ExtPropertyFilter> extFilters = ExtPropertyFilter
        // .extBuildFromHttpRequest(Struts2Utils.getRequest());
        //
        // extFilters.add(new ExtPropertyFilter("EQS_examineeNo", "student",
        // "student.examineeNo"));
        // extFilters.add(new ExtPropertyFilter("EQS_name", "student",
        // "student.name"));

        // ExtPropertyFilter filter = new ExtPropertyFilter("EQS_..", "级联对象",
        // "级联对象属性");

        page = schoolNoticeManager.search(page);

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public SchoolNotice getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * * 导出excel
     * 
     * @since 2011-3-28
     * @author bing.hu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {
        List<SchoolNotice> schoolnotice = schoolNoticeManager.getAll();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;性别;学院;专业;班级;报道时间"; // 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList list = new ArrayList();

        if (schoolnotice != null && schoolnotice.size() > 0)
        {

            for (SchoolNotice school : schoolnotice)
            {
                ArrayList rowlist = new ArrayList();
                rowlist.add(school.getStudent().getStudentNo());
                rowlist.add(school.getSexdesc());
                rowlist.add(school.getStudent().getCollegeName());
                rowlist.add(school.getStudent().getMajorName());
                rowlist.add(school.getStudent().getClassName());
                rowlist.add(school.getNoticeTime());
                list.add(rowlist);
            }
        }

        // 设置报表标题
        excel.setHeader(header);

        // 报表名称
        excel.setSheetName("新生报道信息");

        // 设置报表内容
        excel.setData(list);

        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("新生报道信息.xls", excel, Struts2Utils.getResponse());

        }
        catch (Exception e)
        {

            e.printStackTrace();
        }

        return null;

    }

    public SchoolNotice getEntity()
    {
        return entity;
    }

    public void setEntity(SchoolNotice entity)
    {
        this.entity = entity;
    }

    @Autowired
    public void setSchoolNoticeManager(SchoolNoticeManager schoolNoticeManager)
    {
        this.schoolNoticeManager = schoolNoticeManager;
    }

    public Long getBatchId()
    {
        return batchId;
    }

    public void setBatchId(Long batchId)
    {
        this.batchId = batchId;
    }

    public List<Welbatch> getBatches()
    {
        try
        {
            this.batches = this.batchManager.getAll();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.batches == null)
        {
            this.batches = new ArrayList<Welbatch>();
        }

        return batches;
    }

    public void setBatches(List<Welbatch> batches)
    {
        this.batches = batches;
    }

    public List<InstituteDTO> getCollegues()
    {
        try
        {
            this.collegues = this.instituteWebService.getInstitutes();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.collegues == null)
        {
            this.collegues = new ArrayList<InstituteDTO>();
        }
        return this.collegues;
    }

    public void setCollegues(List<InstituteDTO> collegues)
    {
        this.collegues = collegues;
    }

    public List<DepartmentDTO> getDepartments()
    {
        return departments;
    }

    public void setDepartments(List<DepartmentDTO> departments)
    {
        this.departments = departments;
    }

    public List<SpecialtyDTO> getMajors()
    {
        this.majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }
        return majors;
    }

    public void setMajors(List<SpecialtyDTO> majors)
    {
        this.majors = majors;
    }

    public List<ClazzDTO> getClazzes()
    {
        Welbatch welbatch = batchManager.getCurrentBatch();
        this.clazzes = clazzWebService.getClazzsBySpecialty(majorCode, "",
                welbatch.getYear(), welbatch.getSeason());
        if (this.clazzes == null)
        {
            this.clazzes = new ArrayList<ClazzDTO>();
        }

        return clazzes;
    }

    public void setClazzes(List<ClazzDTO> clazzes)
    {
        this.clazzes = clazzes;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    @Autowired
    public void setBatchManager(WelbatchManager batchManager)
    {
        this.batchManager = batchManager;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    public String getClassCode()
    {
        return classCode;
    }
}
