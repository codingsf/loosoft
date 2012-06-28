//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: qingang
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
package cn.loosoft.stuwork.welnew.web.student;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.json.Json2JavaUtil;
import cn.common.lib.util.web.PropertyUtils;
import cn.common.lib.util.web.RequestUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.DepartmentDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.StudentLength;
import cn.loosoft.stuwork.common.StudentSex;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.print.NoticeCertVO;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.util.Code39;

import com.google.common.collect.Lists;
import com.sun.image.codec.jpeg.ImageFormatException;

/**
 * 
 *通知书
 * 
 * @author qingang
 * @version 1.0
 * @since 2011-7-26
 */
@Namespace("/student")
public class NoticeAction extends CrudActionSupport<Student>
{

    private final String tiaomaPath = PropertyUtils.getPropertiy("tiaomaPath");
    /**
     * serialVersionUID long
     */
    private static final long   serialVersionUID = 1L;

    private List<Welbatch>      batches;                                     // 批次列表

    private List<InstituteDTO>  collegues;                                   // 学院列表

    private List<DepartmentDTO> departments;                                 // 院系列表

    private List<SpecialtyDTO>  majors;                                      // 专业列表

    private List<ClazzDTO>      clazzes;                                     // 班级列表

    private List<LabelValue>    studentTypeList;                             // 学生类别列表

    private List<LabelValue>    studentLengthList;                           // 学生学制列表

    private List<LabelValue>    sexes;

    private Page<Student>       page             = new Page<Student>(
            Constant.PAGE_SIZE);

    private String              collegeCode;                                 // 院系代码

    private String              majorCode;                                   // 专业代码

    private List<Long>                ids;                                   //批量处理的id  

    public Page<Student> getPage()
    {
        return page;
    }

    public void setPage(Page<Student> page)
    {
        this.page = page;
    }

    @Autowired
    private StudentManager      studentManager;

    @Autowired
    private WelbatchManager     batchManager;

    @Autowired
    private InstituteWebService instituteWebService;

    @Autowired
    private SpecialtyWebService specialtyWebService;

    @Autowired
    private ClazzWebService     clazzWebService;

    /**
     * 选择批量打印通知书
     * Description of this Method
     * @since  2011-7-27
     * @author houbing.qian
     * @return
     * @throws Exception
     */
    public String prints() throws Exception
    {

        RequestUtils.getWebURL(Struts2Utils.getRequest());
        List<NoticeCertVO> noticeCertVOList = Lists.newArrayList();
        Student student;
        NoticeCertVO ncvo;

        StringBuilder leftContentSB ;
        StringBuilder rightContentSB;
        for(long id : ids){
            student = studentManager.get(id);
            ncvo = new NoticeCertVO();
            //左边内容
            leftContentSB = new StringBuilder();
            leftContentSB.append("&nbsp;&nbsp;&nbsp;&nbsp;经<span style=\"font-family: 仿宋_GB2312; font-weight:600;\">安徽省</span>招生委员会批准，你被录取到我校");
            leftContentSB.append(student.getCollegeName());
            leftContentSB.append("<span style=\"font-family: 仿宋_GB2312; font-weight:600;\">"+student.getMajorName()+"</span>").append("专业学习，");
            leftContentSB.append("学制"+student.getLength()+"年，请凭录取通知书按时来校报到。");
            ncvo.setLeftContent(leftContentSB.toString());
            //右边内容

            rightContentSB = new StringBuilder();
            rightContentSB.append("&nbsp;&nbsp;&nbsp;&nbsp;经<span style=\"font-family: 仿宋_GB2312; font-weight:600; \">安徽省</span>招生委员会批准，你被录取到我校");
            rightContentSB.append(student.getCollegeName());
            rightContentSB.append("<span style=\"font-family: 仿宋_GB2312; font-weight:600;\">"+student.getMajorName()+"</span>").append("专业学习，");
            rightContentSB.append("学制"+student.getLength()+"年，请于九月十一日来校报到。");
            ncvo.setRightContent(rightContentSB.toString());
            BeanUtils.copyProperties(ncvo, student);
            ncvo.setTime("二○一一年八月一日");
            ncvo.setTiaoma(this.gentm(student.getExamineeNo()));
            ncvo.setLeftName("<span style=\"font-family: 仿宋_GB2312; font-weight:600;\">"+student.getName()+"</span>同学：");
            ncvo.setRightName("<span style=\"font-family: 仿宋_GB2312; font-weight:600;\">"+student.getName()+"</span>同学：");

            noticeCertVOList.add(ncvo);
        }
        String json = Json2JavaUtil.JavaList2Json(noticeCertVOList);
        //重定向到打印服务
        // TODO Auto-generated method stub
        Struts2Utils.getRequest().setAttribute("printcontent", java.net.URLEncoder.encode(json,"UTF-8"));
        return "prints";
    }

    /**
     * 
     * Description of this Method
     * @since  2011-7-27
     * @author houbing.qian
     * @param exh
     * @return
     */
    private String gentm(String exh){
        Code39 code = new Code39();
        try
        {
            code.getImage("*"+exh+"*",  tiaomaPath+"\\"+exh+ ".jpg");
        }
        catch (ImageFormatException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return exh+ ".jpg";
    }
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("welbatch");
            page.setOrder(Page.DESC);
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        collegeCode = request.getParameter("filter_EQS_collegeCode");
        majorCode = request.getParameter("filter_EQS_majorCode");

        List<PropertyFilter> filters = HibernateUtils
        .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        page = studentManager.search(page, filters);
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

    public Student getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }
    public List<LabelValue> getTypeList()
    {
        return StudentType.enumList;
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

    public List<SpecialtyDTO> getMajors()
    {
        this.majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<SpecialtyDTO>();
        }

        return this.majors;
    }

    public List<LabelValue> getSexes()
    {

        try
        {
            this.sexes = StudentSex.enumList;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (sexes == null)
        {
            this.sexes = new ArrayList<LabelValue>();
        }
        return sexes;
    }

    public List<DepartmentDTO> getDepartments()
    {
        return departments;
    }

    public List<ClazzDTO> getClazzes()
    {
        Welbatch welbatch = batchManager.getCurrentBatch();
        if (null == welbatch)
        {
            this.clazzes = new ArrayList<ClazzDTO>();
            return this.clazzes;
        }
        this.clazzes = clazzWebService.getClazzsBySpecialty(majorCode, "",
                welbatch.getYear(), welbatch.getSeason());
        if (this.clazzes == null)
        {
            this.clazzes = new ArrayList<ClazzDTO>();
        }
        return this.clazzes;
    }

    public List<LabelValue> getStudentLengthList()
    {
        try
        {
            this.studentLengthList = StudentLength.enumList;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.studentLengthList == null)
        {
            this.studentLengthList = new ArrayList<LabelValue>();
        }

        return this.studentLengthList;
    }

    /**
     * 取得学生类别列表
     * 
     * @author shanwu.wu
     * @since 2010-12-12
     * @version 1.0
     * @return
     */
    public List<LabelValue> getStudentTypeList()
    {
        try
        {
            this.studentTypeList = StudentType.enumList;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        if (this.studentTypeList == null)
        {
            this.studentTypeList = new ArrayList<LabelValue>();
        }

        return this.studentTypeList;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

}
