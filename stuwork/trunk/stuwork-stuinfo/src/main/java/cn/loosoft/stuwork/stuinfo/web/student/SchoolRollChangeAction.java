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
package cn.loosoft.stuwork.stuinfo.web.student;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.stuinfo.entity.batch.Batch;
import cn.loosoft.stuwork.stuinfo.entity.student.SchoolRollChange;
import cn.loosoft.stuwork.stuinfo.service.batch.BatchManager;
import cn.loosoft.stuwork.stuinfo.service.student.SchoolRollChangeManager;

/**
 * 
 * 学籍异动管理Action.
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-10-19
 */
@Namespace("/student")
public class SchoolRollChangeAction extends CrudActionSupport<SchoolRollChange>
{

    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
                                                              .getRequest();

    private String                   pageCode         = "";                 // 分页显示数

    private List<LabelValue>         selectPageList;

    private String                   collegeCode;

    private String                   classCode;

    private String                   majorCode;

    private Page<SchoolRollChange>   page             = new Page<SchoolRollChange>(
                                                              20);

    // 批量删除ID

    private Long                     id;

    // ==页面访问函数== //

    private SchoolRollChange         schoolRollChange;

    // 批次列表

    private final String             total            = "0";

    private final String             failnum          = "0";

    private final String             failstr          = "";

    @Autowired
    private InstituteWebService      instituteWebService;                   // 院系manage

    @Autowired
    private BatchManager             batchManager;                          // 批次manage

    @Autowired
    private SchoolRollChangeManager  schoolRollChangeManager;               // 异动manage

    @Autowired
    private SpecialtyWebService      specialtyWebService;                   // 专业manage

    @Autowired
    private ClazzWebService          clazzWebService;                       // 班级manage

    private List<Batch>              batches;                               // 批次列表

    private List<InstituteDTO>       collegues;                             // 原所属院系列表

    private List<SpecialtyDTO>       majors;                                // 原所属专业列表

    private List<ClazzDTO>           clazzs;                                // 原所属班级列表

    private List<SpecialtyDTO>       newMajors;                             // 现所属现专业列表

    private List<ClazzDTO>           newClazzs;                             // 现所属现班级列表

    @Override
    public String list() throws Exception
    {
        // 设置分页属性
        if (null != pageCode && StringUtils.isNotEmpty(pageCode))
        {
            page.setPageSize(Integer.parseInt(pageCode));
        }
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("changeDateTime");
            page.setOrder(Page.DESC);
        }

        // 设置过滤器
        HttpServletRequest req = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils.buildPropertyFilters(req);
        ParamPropertyUtils.replacePropertyRule(filters);

        // 回带处理
        String collgeCode = ParamUtils.getParameter(req,
                "filter_EQS_collegeCode", null);
        String majorCode = ParamUtils.getParameter(req, "filter_EQS_majorCode",
                null);
        String newCollgeCode = ParamUtils.getParameter(req,
                "filter_EQS_newcollegeCode", null);
        String newMajorCode = ParamUtils.getParameter(req,
                "filter_EQS_newmajorCode", null);

        if (StringUtils.isNotBlank(collgeCode))
        {
            this.majors = specialtyWebService
                    .getSpecialtysByCollege(collgeCode);
            if (this.majors == null)
            {
                this.majors = new ArrayList<SpecialtyDTO>();
            }
        }

        if (StringUtils.isNotBlank(majorCode))
        {
            Batch batch = batchManager.getCurrentBatch();
            if (batch != null)
            {
                this.clazzs = clazzWebService.getClazzsBySpecialty(majorCode,
                        "", batch.getYear(), batch.getSeason());

            }
            if (this.clazzs == null)
            {
                this.clazzs = new ArrayList<ClazzDTO>();
            }
        }
        if (StringUtils.isNotBlank(newCollgeCode))
        {
            this.newMajors = specialtyWebService
                    .getSpecialtysByCollege(newCollgeCode);
            if (this.newMajors == null)
            {
                this.newMajors = new ArrayList<SpecialtyDTO>();
            }
        }

        if (StringUtils.isNotBlank(newMajorCode))
        {
            Batch batch = batchManager.getCurrentBatch();
            if (batch != null)
            {
                this.newClazzs = clazzWebService.getClazzsBySpecialty(
                        newMajorCode, "", batch.getYear(), batch.getSeason());

            }
            if (this.newClazzs == null)
            {
                this.newClazzs = new ArrayList<ClazzDTO>();
            }
        }

        // 查询
        String endChangeDateTime = ParamUtils.getParameter(request,
                "endChangeDateTime", null);

        if (StringUtils.isNotBlank(endChangeDateTime))
        {
            filters.add(new PropertyFilter("LED_changeDateTime",
                    endChangeDateTime + " 23:59:59"));
        }
        page = schoolRollChangeManager.search(page, filters);

        if (page.getResult().size() == 0)
        {
            addActionMessage("抱歉,没有找到您想要的数据");
        }

        return SUCCESS;
    }

    @Override
    public String save() throws Exception
    {
        return RELOAD;
    }

    @Override
    public String delete()
    {
        return RELOAD;
    }

    // ==ModelDriven 与 Preparable函数 == //
    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            schoolRollChange = schoolRollChangeManager.get(id);

        }
        else
        {
            schoolRollChange = new SchoolRollChange();
        }
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public SchoolRollChange getModel()
    {
        // TODO Auto-generated method stub
        return schoolRollChange;
    }

    // ==CRUD Action 函数== //
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    public String getPageCode()
    {
        return pageCode;
    }

    public List<LabelValue> getSelectPageList()
    {
        selectPageList = new ArrayList<LabelValue>();
        selectPageList.add(new LabelValue("10", "10"));
        selectPageList.add(new LabelValue("15", "15"));
        selectPageList.add(new LabelValue("20", "20"));
        return selectPageList;
    }

    // -- 页面属性访问函数 --//
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

    public Page<SchoolRollChange> getPage()
    {
        return page;
    }

    public SchoolRollChange getSchoolRollChange()
    {
        return schoolRollChange;
    }

    public List<ClazzDTO> getClazzs()
    {
        if (this.clazzs == null)
        {
            this.clazzs = new ArrayList<ClazzDTO>();
        }
        return this.clazzs;
    }

    public List<SpecialtyDTO> getMajors()
    {
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }
        return this.majors;
    }

    public List<InstituteDTO> getCollegues()
    {
        this.collegues = instituteWebService.getInstitutes();
        if (this.collegues == null)
        {
            this.collegues = new ArrayList<InstituteDTO>();
        }
        return this.collegues;
    }

    public List<ClazzDTO> getNewClazzs()
    {
        if (this.newClazzs == null)
        {
            this.newClazzs = new ArrayList<ClazzDTO>();
        }
        return this.newClazzs;
    }

    public List<SpecialtyDTO> getNewMajors()
    {
        if (this.newMajors == null)
        {
            this.newMajors = new ArrayList<SpecialtyDTO>();
        }
        return this.newMajors;
    }

    public List<Batch> getBatches()
    {
        try
        {
            this.batches = batchManager.getAll();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.batches == null)
        {
            this.batches = new ArrayList<Batch>();
        }

        return batches;
    }

    public void setPageCode(String pageCode)
    {
        this.pageCode = pageCode;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

}
