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

import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;
import cn.loosoft.stuwork.welnew.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelModel;

/**
 * 新生缴费记录Action Description of the class
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-3-25
 */
@Namespace("/query")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "newstudentpayment.action", type = "redirect") })
public class NewstudentpaymentAction extends CrudActionSupport<PaymentLog>
{

    /**
     * serialVersionUID long
     */
    private static final long        serialVersionUID = 1L;

    private PaymentLogManager        paymentLogManager;

    private WelbatchManager          batchManager;

    private InstituteWebService      instituteWebService;

    private SpecialtyWebService      specialtyWebService;

    private ClazzWebService          clazzWebService;

    private final HttpServletRequest request          = Struts2Utils
    .getRequest();

    // -- 页面属性 -- //
    private PaymentLog               entity;

    private Page<PaymentLog>         page             = new Page<PaymentLog>(
            Constant.PAGE_SIZE);

    private Long                     batchId;                                                         // 批次ID

    private List<Welbatch>           batches;                                                         // 批次列表

    private List<InstituteDTO>       collegues;                                                       // 学院列表

    // 院系列表

    private List<SpecialtyDTO>       majors;                                                          // 专业列表

    private List<ClazzDTO>           clazzes;                                                         // 班级列表

    private final String             collegeCode      = request
    .getParameter("filter_EQS_collegeCode"); // 院系代码

    private final String             majorCode        = request
    .getParameter("filter_EQS_majorCode");  // 专业代码

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {

        //List<PropertyFilter> filters = HibernateUtils
        //.buildPropertyFilters(request);
        //ParamPropertyUtils.replacePropertyRule(filters);

        //ExtPropertyFilter
        //.extBuildFromHttpRequest(Struts2Utils.getRequest());

        // ExtPropertyFilter filter = new ExtPropertyFilter("EQS_..", "级联对象",
        // "级联对象属性");

        page = paymentLogManager.search(page);

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
        System.out.println(1111);
        List<PaymentLog> patmentlist = paymentLogManager.getAll();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学号;姓名;性别;学院;专业;班级;缴费项目;缴费金额"; // 标题名称
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }
        ArrayList list = new ArrayList();

        if (patmentlist != null && patmentlist.size() > 0)
        {

            for (PaymentLog payment : patmentlist)
            {
                if (payment.getStudent() != null
                        && payment.getCostItem() != null)
                {

                    ArrayList rowlist = new ArrayList();
                    rowlist.add(payment.getStudent().getStudentNo());
                    rowlist.add(payment.getStudent().getSexdesc());
                    rowlist.add(payment.getStudent().getCollegeName());
                    rowlist.add(payment.getStudent().getMajorName());
                    rowlist.add(payment.getStudent().getClassName());

                    rowlist.add(payment.getCostItem().getProject());

                    rowlist.add(payment.getDebtMoney());
                    list.add(rowlist);
                }
            }
        }

        // 设置报表标题
        excel.setHeader(header);

        // 报表名称
        excel.setSheetName("新生缴费信息");

        // 设置报表内容
        excel.setData(list);

        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("新生缴费信息.xls", excel, Struts2Utils.getResponse());

        }
        catch (Exception e)
        {

            e.printStackTrace();
        }

        return null;
    }

    public PaymentLog getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    public PaymentLog getEntity()
    {
        return entity;
    }

    public void setEntity(PaymentLog entity)
    {
        this.entity = entity;
    }

    public Page<PaymentLog> getPage()
    {
        return page;
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

    @Autowired
    public void setPaymentLogManager(PaymentLogManager paymentLogManager)
    {
        this.paymentLogManager = paymentLogManager;
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

    public Long getBatchId()
    {
        return batchId;
    }

    public void setBatchId(Long batchId)
    {
        this.batchId = batchId;
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

        return majors;
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

    public void setBatches(List<Welbatch> batches)
    {
        this.batches = batches;
    }

}
