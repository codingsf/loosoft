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
package cn.loosoft.stuwork.arch.web.lendlog;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
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
import cn.loosoft.stuwork.arch.Constant;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.batch.Welbatch;
import cn.loosoft.stuwork.arch.entity.lendlog.LendLog;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.service.batch.WelbatchManager;
import cn.loosoft.stuwork.arch.service.lendlog.LendLogManager;
import cn.loosoft.stuwork.arch.vo.ArchivesVO;

import com.google.common.collect.Lists;

/**
 * 
 * 档案调阅管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-20
 */
@Namespace("/lendlog")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "lend-log.action", type = "redirect"),
        @Result(name = LendManageAction.DETAIL, location = "lend-manage-detail.jsp") })
public class LendManageAction extends CrudActionSupport<Archives>
{
    private static final long                  serialVersionUID = 1L;

    private static final String                DETAIL           = "detail";

    HttpServletRequest                         request          = Struts2Utils
                                                                        .getRequest();

    private InstituteWebService                instituteWebService;                                  // 院系信息

    private SpecialtyWebService                specialtyWebService;                                  // 专业信息

    private StudentWebService                  studentWebService;                                    // 学生信息

    private ClazzWebService                    clazzWebService;                                      // 班级信息

    private ArchivesManager                    archivesManager;                                      // 档案信息

    private WelbatchManager                    welbatchManager;                                      // 批次信息

    private LendLogManager                     lendLogManager;                                       // 调阅信息

    private Page<Archives>                     page             = new Page<Archives>(
                                                                        Constant.PAGE_SIZE);

    private final cn.loosoft.stuwork.arch.Page commonPage       = new cn.loosoft.stuwork.arch.Page(); // 内存分页Page类

    // --页面属性-- //
    private Archives                           entity;                                               // 调阅实体

    private String                             stuNo;                                                // 学号

    private String                             examineeNo;                                           // 考生号

    private String                             name;                                                 // 姓名

    private String                             IDcard;                                               // 身份证号

    private String                             period;                                               // 届数

    private List<InstituteDTO>                 colleges;                                             // 学院列表

    private List<SpecialtyDTO>                 majors;                                               // 专业列表

    private List<ClazzDTO>                     clazzes;                                              // 班级列表

    private StudentDTO                         studentDTO;

    private LendLog                            lendLog;

    private List<LabelValue>                   selectPageList;

    private List<ArchivesVO>                   archivesVOs;                                          // 学生档案列表

    // -- ModelDriven 与 Preparable函数 --//

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    public Archives getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    // --CURD Action 函数-- //

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * 
     * 档案调阅详情
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @return
     */
    public String detail()
    {
        this.entity = archivesManager.getArchives(stuNo);
        this.studentDTO = studentWebService.getStudentByStudentNo(stuNo);
        return DETAIL;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("storageTime");
        }
        page = archivesManager.search(page, name, stuNo, examineeNo);

        // this.archivesVOs = convertToArchivesList(getStuNos());

        return CrudActionSupport.SUCCESS;

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
        List<ArchivesVO> resList = Lists.newArrayList();
        if (null != stuNos && stuNos.size() > 0)
        {
            for (int i = 0; i < stuNos.size(); i++)
            {
                String studentNo = stuNos.get(i);
                Archives archives = archivesManager.getArchives(studentNo);
                archivesVO = new ArchivesVO();
                archivesVO.setStuId(archives.getStuId()); // 学号
                archivesVO.setName(archives.getName()); // 姓名
                archivesVO.setStorageTime(archives.getStorageTime()); // 入库时间
                archivesVO.setStatus(archives.getStatus()); // 档案状态
                archivesVO.setArchivesInfo(archives.getArchivesInfo()); // 档案库位
                archivesVO.setStoreInfo(archives.getStoreInfo()); // 档案材料
                resList.add(archivesVO);

            }
        }

        return resList;
    }

    // --页面访问函数-- //

    public LendLog getLendLog()
    {
        this.lendLog = lendLogManager.getRecentLendLog(stuNo);
        return lendLog;
    }

    public Archives getEntity()
    {
        return entity;
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
        String type = request.getParameter("type");
        clazzes = clazzWebService.getClazzsBySpecialty(majorCode, type,
                welbatch.getYear(), welbatch.getSeason());
        if (null == clazzes)
        {
            this.clazzes = new ArrayList<ClazzDTO>();

        }
        return clazzes;
    }

    // /**
    // * 学号列表
    // *
    // * @since 2010-12-24
    // * @author shanru.wu
    // * @return
    // * @return
    // */
    // public List<String> getStuNos()
    //
    // {
    // String pageCode = request.getParameter("filter_EQS_pageCode"); // 分页显示数
    // if (pageCode == "" || pageCode == null)
    // {
    // commonPage.setPageSize(15);
    // }
    // else
    // {
    // commonPage.setPageSize(Integer.parseInt(pageCode));
    // }
    // commonPage.setTotalCount(Integer.parseInt(String
    // .valueOf(archivesManager.countArchives(stuNo, name))));
    //
    // List<String> stuNos = archivesManager.getStuNos(stuNo, name);
    // return stuNos;
    // }

    public cn.loosoft.stuwork.arch.Page getCommonPage()
    {
        return commonPage;
    }

    /**
     * 学号
     */
    public String getStuNo()
    {
        return stuNo;
    }

    /**
     * 考生号
     */
    public String getExamineeNo()
    {
        return examineeNo;
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
     * 身份证号
     */
    public String getIDcard()
    {
        return IDcard;
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

    public StudentDTO getStudentDTO()
    {
        return studentDTO;
    }

    public Page<Archives> getPage()
    {
        return page;
    }

    // --其他 Action 函数-- //

    @Autowired
    public void setLendLogManager(LendLogManager lendLogManager)
    {
        this.lendLogManager = lendLogManager;
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

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

    public void setStuNo(String stuNo)
    {
        this.stuNo = stuNo;
    }

    public void setPeriod(String period)
    {
        this.period = period;
    }

    public void setFileFileName(String fileFileName)
    {
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

}
