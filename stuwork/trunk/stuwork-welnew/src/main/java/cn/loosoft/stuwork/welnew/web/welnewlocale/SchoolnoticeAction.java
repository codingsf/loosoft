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
package cn.loosoft.stuwork.welnew.web.welnewlocale;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.common.lib.util.json.Json2JavaUtil;
import cn.common.lib.util.web.PropertyUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.item.DevolveItem;
import cn.loosoft.stuwork.welnew.entity.item.TurnOverItem;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.entity.room.Bed;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.entity.sys.LogData;
import cn.loosoft.stuwork.welnew.entity.welnewlocale.SchoolNotice;
import cn.loosoft.stuwork.welnew.print.RegTableVO;
import cn.loosoft.stuwork.welnew.service.account.AccountManager;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.item.DevolveItemManager;
import cn.loosoft.stuwork.welnew.service.item.TurnOverItemManager;
import cn.loosoft.stuwork.welnew.service.log.DevolverLogManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;
import cn.loosoft.stuwork.welnew.service.room.BedManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.service.sys.LogDataManager;
import cn.loosoft.stuwork.welnew.service.welnewlocale.SchoolNoticeManager;
import cn.loosoft.stuwork.welnew.vo.DevolverVO;
import cn.loosoft.stuwork.welnew.vo.PayStudentVO;

import com.google.common.collect.Lists;

/**
 * 
 * 缴费项目设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/welnewlocale")
@Results( {
    @Result(name = CrudActionSupport.RELOAD, location = "schoolnotice.action", type = "redirect"),
    @Result(name = "noticedetail", location = "notice-detail.jsp"),
    @Result(name = "noticeprint", location = "${printUrl}",type = "redirect") })
    public class SchoolnoticeAction extends CrudActionSupport<Object>
{
    /**
     * serialVersionUID long
     */
    private static final long        serialVersionUID = 1L;

    private final HttpServletRequest request          = Struts2Utils
    .getRequest();

    @Autowired
    private StudentManager           studentManager;                                                   // 学生管理

    @Autowired
    private SchoolNoticeManager      schoolNoticeManager;                                              // 学院报道管理

    @Autowired
    private CostItemManager          costItemManager;                                                  // 缴费明细管理

    @Autowired
    private PaymentLogManager        paymentLogManager;                                                // 缴费记录管理

    @Autowired
    private DevolveItemManager       devolverItemManager;                                              // 转移项目管理

    @Autowired
    private DevolverLogManager       devolverLogManager;                                               // 转移项目记录

    @Autowired
    private TurnOverItemManager      turnOverItemManager;                                              // 上缴物品

    @Autowired
    private AccountManager           accountManager;                                                   // 用户账号Manager

    @Autowired
    private BedManager               bedManager;                                                       // 床位信息
    @Autowired
    private LogDataManager           logDataManager;                                                       // 床位信息    

    private Student                  student;                                                          // 学生实体

    private String                   value;

    public String                    column           = request
    .getParameter("filter_EQS_filterColumn");

    public List<LabelValue>          radioList;

    public String                    extendString     = "";

    public String                    turnOverString   = "";

    public String                    devolverString   = "";

    public String                    actionMessage;                                                    // 提示信息

    public String                    noticeMessage;                                                    // 报到信息

    public List<Long>                idList;

    private String printUrl;

    /**
     * @return the actionMessage
     */
    public String getNoticeMessage()
    {
        return noticeMessage;
    }

    /**
     * @return the actionMessage
     */
    public String getActionMessage()
    {
        return actionMessage;
    }

    /**
     * 转移记录VO
     */
    public List<DevolverVO> getDevolverVOList()
    {
        List<DevolveItem> itemList = devolverItemManager.getAll();
        DevolverVO devolverVo = null;
        List<DevolverVO> devoVOList = new ArrayList<DevolverVO>();

        if (itemList.size() > 0)
        {
            for (int i = 0; i < itemList.size(); i++)// 首先查询所有的发放项目
            {

                if (student != null)
                {
                    DevolverLog stuLog = devolverLogManager.getStudentLog(
                            student.getExamineeNo(), Integer.parseInt(itemList
                                    .get(i).getId().toString()));

                    if (stuLog != null)
                    {
                        devolverVo = new DevolverVO();
                        devolverVo.setId(itemList.get(i).getId());
                        devolverVo.setDevolver(true);
                        devolverVo.setName(itemList.get(i).getName());
                        devoVOList.add(devolverVo);
                    }
                    else
                    {
                        devolverVo = new DevolverVO();
                        devolverVo.setId(itemList.get(i).getId());
                        devolverVo.setDevolver(false);
                        devolverVo.setName(itemList.get(i).getName());
                        devoVOList.add(devolverVo);
                    }
                }
                else
                {
                    devolverVo = new DevolverVO();
                    devolverVo.setId(itemList.get(i).getId());
                    devolverVo.setDevolver(false);
                    devolverVo.setName(itemList.get(i).getName());
                    devoVOList.add(devolverVo);
                }
            }
        }
        else
        {
            for (int i = 0; i < itemList.size(); i++)
            {// 首先查询所有的发放项目
                devolverVo = new DevolverVO();
                devolverVo.setId(itemList.get(i).getId());
                devolverVo.setDevolver(false);
                devolverVo.setName(itemList.get(i).getName());
                devoVOList.add(devolverVo);
            }

        }
        return devoVOList;

    }

    /**
     * 转移物品
     */
    public String getDevolverString()
    {
        List<DevolveItem> extendList = devolverItemManager.getAll();
        for (int i = 0; i < extendList.size(); i++)
        {
            devolverString += extendList.get(i).getName() + ",";
        }
        devolverString = devolverString.substring(0,
                devolverString.length() - 1);
        return devolverString;
    }

    /**
     * 发放物品
     */
    public String getExtendString()
    {
        List<CostItem> extendList = costItemManager.getExtendItems();
        for (int i = 0; i < extendList.size(); i++)
        {
            extendString += extendList.get(i).getProject() + ",";
        }
        extendString = extendString.substring(0, extendString.length() - 1);
        return extendString;
    }

    /**
     * 上缴物品
     */
    public String getTurnOverString()
    {
        List<TurnOverItem> turnoverList = turnOverItemManager.getAll();
        for (int i = 0; i < turnoverList.size(); i++)
        {
            turnOverString += turnoverList.get(i).getName() + ",";
        }
        turnOverString = turnOverString.substring(0,
                turnOverString.length() - 1);
        return turnOverString;
    }

    /**
     * @return the radioList
     */
    public List<LabelValue> getRadioList()
    {
        radioList = new ArrayList<LabelValue>();
        radioList.add(new LabelValue("noticeId", "通知书编号"));
        radioList.add(new LabelValue("examineeNo", "考生号"));
        radioList.add(new LabelValue("studentNo", "学号"));
        return radioList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        UserDTO userDTO = accountManager.getUser(SpringSecurityUtils.getCurrentUserName());
        request.setAttribute("userCollegeName", userDTO.getCollegeName());
        // TODO Auto-generated method stub
        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    /**
     * 
     * 查询学生缴费情况
     * 
     * @since 2010-12-31
     * @author jie.yang
     * @return
     */
    public List<PayStudentVO> getPayStudentList()
    {
        List<PayStudentVO> payStuList = Lists.newArrayList();
        List<CostItem> costList = costItemManager.getAll("need",false);

        if (costList != null)
        {
            for (CostItem costItem : costList)
            {
                if (student != null)
                {
                    PaymentLog paymentLog = paymentLogManager.getPaymentLog(
                            student.getExamineeNo(), costItem.getId());
                    if (paymentLog != null)
                    {
                        PayStudentVO paystuVo = new PayStudentVO();
                        paystuVo.setDebtMoney(paymentLog.getDebtMoney());
                        paystuVo.setItemId(costItem.getId().toString());
                        if (paymentLog.getDebtMoney() > 0)
                        {
                            paystuVo.setCost(false);
                        }
                        else
                        {
                            paystuVo.setCost(true);
                        }
                        paystuVo.setType(costItem.getProject());
                        paystuVo.setMoney(costItem.getPrice());
                        paystuVo.setPayedMoney(paymentLog.getPayedMoney());
                        paystuVo.setNeed(costItem.isNeed());
                        payStuList.add(paystuVo);
                    }
                    else
                    {
                        PayStudentVO paystuVo = new PayStudentVO();
                        paystuVo.setDebtMoney(0);
                        paystuVo.setItemId(costItem.getId().toString());
                        paystuVo.setCost(true);
                        paystuVo.setType(costItem.getProject());
                        paystuVo.setMoney(costItem.getPrice());
                        paystuVo.setPayedMoney(0);
                        paystuVo.setNeed(costItem.isNeed());
                        payStuList.add(paystuVo);
                    }
                }
            }
        }

        return payStuList;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }
    /*
     * 
     */
    public String searchStudent()
    {
        if (column != null && column != "")
        {
            student = studentManager.getStudent(column, value);
        }
        UserDTO userDTO = accountManager.getUser(SpringSecurityUtils.getCurrentUserName());
        if(student!=null && student.getCollegeCode()!=null && !student.getCollegeCode().equals(userDTO.getCollegeCode())){
            super.addActionMessage("您不能操作其他学院的新生");
            student = null;
        }
        request.setAttribute("userCollegeName", userDTO.getCollegeName());
        return SUCCESS;
    }

    /**
     * 
     * 新生学院报到
     * @since  2011-9-2
     * @author houbing.qian
     * @return
     */
    public String submitSchoolNotice()
    {
        student = studentManager.getStudent(column, value);

        if (student != null)
        {
            if (student.isReged())
            {
                noticeMessage = "该生已经报到";
                return SUCCESS;
            }
            else
            {
                List<DevolveItem> devolveItems = Lists.newArrayList();
                if (null != idList && idList.size() > 0)
                {
                    for (Long idd : idList)
                    {
                        devolveItems.add(devolverItemManager.get(idd));
                    }
                }

                SchoolNotice schoolNotice = new SchoolNotice();
                schoolNotice.setNoticeTime(new Date());
                schoolNotice.setNoticeType("现场报到");
                schoolNotice.setStudent(student);

                schoolNoticeManager.saveAndDevolverLog(schoolNotice,
                        devolveItems, student, SpringSecurityUtils
                        .getCurrentUserName());

                //是否通过资格审查
                //student.setCheckPass(checkPass==1?true:false);
                student.setCheckPass(true);
                //分配寝室，已经有就不再分配了
                assignBed();
                student.setReged(true);
                studentManager.save(student);
            }
        }
        //添加操作日志
        logDataManager.save(new LogData(SpringSecurityUtils.getCurrentUserName(),"新生报到,姓名："+student.getName()+"，考生号："+student.getExamineeNo(),LogData.operate_type_reg));
        printUrl = PropertyUtils.getPropertyWithConfigName("application.properties", "stuwork.reportservice")+"?printcontent="+getPrintContent(student);

        return "noticeprint";
    }

    /**
     * 
     * 
     * 打印报道表
     * @since  2011-9-3
     * @author houbing.qian
     * @return
     */
    public String print(){
        student = studentManager.getStudent(column, value);
        printUrl = PropertyUtils.getPropertyWithConfigName("application.properties", "stuwork.reportservice")+"?printcontent="+getPrintContent(student);
        return "noticeprint"; 
    }
    /**
     * 
     * 取得打印报道表的内容
     * @since  2011-9-5
     * @author houbing.qian
     * @param student
     * @return
     */
    private String getPrintContent(Student student){
        RegTableVO regTableVO = new RegTableVO();
        try
        {
            BeanUtils.copyProperties(regTableVO, student);
            regTableVO.setMajorName(student.getClassName());
            Date date = new Date();
            regTableVO.setYear(DateUtils.getDateFromDateTime(date, "yyyy"));
            regTableVO.setMonth(DateUtils.getDateFromDateTime(date, "MM"));
            regTableVO.setDay(DateUtils.getDateFromDateTime(date, "dd"));
            UserDTO userDTO = accountManager.getUser(SpringSecurityUtils.getCurrentUserName());

            if(userDTO==null){
                regTableVO.setRegOperator(SpringSecurityUtils.getCurrentUserName());
            }else{
                regTableVO.setRegOperator(userDTO.getName());
            }
        }
        catch (IllegalAccessException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (InvocationTargetException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        String json = Json2JavaUtil.Java2Json(regTableVO);
        //重定向到打印服务
        // TODO Auto-generated method stub
        try
        {
            return java.net.URLEncoder.encode(json,"UTF-8");
        }
        catch (UnsupportedEncodingException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "";
    }
    /**
     * 分配床位
     * @since  2011-9-2
     * @author houbing.qian
     */
    public void assignBed(){
        if(!StringUtils.isEmpty(student.getRoombed()))
        {
            return ;
        }
        // get valid bed info
        Bed bed = bedManager.getUnassignedBed(student.getCollegeCode(), student
                .getMajorCode(), student.getClassCode());
        if (bed == null)
        {
            //assginResult = "系统已经没有可分配的床位，请与宿管科联系，新增预分床位";
            return;
        }
        // 下面两步稍候要放到一个事务中
        // assign bed
        String roombed = (bed.getBuilding().indexOf("楼")) > 0 ? bed
                .getBuilding() : bed.getBuilding()
                + "楼"
                + (bed.getFloor().indexOf("层") > 0 ? bed.getFloor() : bed
                        .getFloor()
                        + "层")
                        + (bed.getRoom().indexOf("室") > 0 ? bed.getRoom() : bed
                                .getRoom()
                                + "室");
                student.setRoombed(roombed);
                // update bed status
                bed.setAssigned(true);
                bed.setStudent(student);
                bedManager.save(bed);

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-10
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public Object getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    // ///////////////////////////属性
    /**
     * @param studentNo
     *            the studentNo to set
     */
    public void setValue(String value)
    {
        this.value = value;
    }

    /**
     * @return the student
     */
    public Student getStudent()
    {

        return student;
    }

    public List<Long> getIdList()
    {
        return idList;
    }

    public void setIdList(List<Long> idList)
    {
        this.idList = idList;
    }

    public void setIsAuto(int isAuto){
    }

    public String getPrintUrl()
    {
        return printUrl;
    }


}
