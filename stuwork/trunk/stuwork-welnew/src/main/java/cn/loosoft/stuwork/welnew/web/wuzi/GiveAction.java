package cn.loosoft.stuwork.welnew.web.wuzi;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.item.CostItem;
import cn.loosoft.stuwork.welnew.entity.log.BackLog;
import cn.loosoft.stuwork.welnew.entity.log.ExtendLog;
import cn.loosoft.stuwork.welnew.entity.log.PaymentLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.item.CostItemManager;
import cn.loosoft.stuwork.welnew.service.log.BackLogManager;
import cn.loosoft.stuwork.welnew.service.log.ExtendLogManager;
import cn.loosoft.stuwork.welnew.service.log.PaymentLogManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.ExtendVO;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 
 * 发放、退还管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-28
 */
@Namespace("/wuzi")
@Results( { @Result(name = "singleinput", location = "give-single.jsp"),
    @Result(name = "multiinput", location = "give-multi.jsp"),
    @Result(name = "returninput", location = "return-input.jsp") })
    public class GiveAction extends CrudActionSupport<Object>
{

    private static final long           serialVersionUID = 7248806444185447414L;

    HttpServletRequest                  request          = Struts2Utils
    .getRequest();

    private StudentManager              studentManager;

    private WelbatchManager             welbatchManager;

    private CostItemManager             costItemManager;

    private InstituteWebService         instituteWebService;

    private SpecialtyWebService         specialtyWebService;

    private ClazzWebService             clazzWebService;

    PaymentLogManager                   paymentLogManager;

    ExtendLogManager                    extendLogManager;

    BackLogManager                      backLogManager;

    // ---页面属性-- //

    private String                      testNo;                                                           // 学员考生号

    private String                      ids;                                                              // 学员ids

    private List<Long>                  extendIds;                                                        // 发放项目ids

    private List<Long>                  returnIds;                                                        // 退还项目ids

    private String                      checkedExtendIds;                                                 // 选择要发放的项目

    private String                      checkedIds;                                                       // 选择要发放的学员

    private String                      giveStatus;                                                       // 发放状态

    private String                      noticeId;                                                         // 通知书编号

    private String                      examineeNo;                                                       // 考生号

    private String                      IDcard;                                                           // 身份证号

    private Student                     student;                                                          // 学生信息

    private List<InstituteDTO>          collegues;                                                        // 学员列表

    private List<SpecialtyDTO>          majors;                                                           // 专业列表

    private List<ClazzDTO>              clazzes;                                                          // 班级列表

    private Map<Integer, List<Student>> dataMap;                                                          // 页面分行数据

    private final Page<CostItem>                      givePage         = new Page<CostItem>(
            10);                                     // 分页列表页面显示发放项目

    private Page<Student>               page             = new Page<Student>(
            100);                                    // 分页列表页面显示数据

    private final List<ExtendVO>                      extendItems      = Lists.newArrayList();                              // 发放项目列表

    private List<CostItem>                      returnItems;                                                      // 退还项目列表

    private final List<ExtendVO>                      extendVOList     = Lists.newArrayList();

    public List<LabelValue>             radioList;

    public String                       column           = request
    .getParameter("filter_EQS_filterColumn"); // radio选中的值

    private String                      value;

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    public String search()
    {
        if (column != null && value != "")
        {
            student = studentManager.getStudent(column, value);
        }
        extendItems();
        String type = request.getParameter("type");
        if (type.equals("th"))
        {
            return "returninput";
        }
        return INPUT;

    }

    /*
     * 发放项目列表
     */
    public void extendItems()
    {
        if (null != student)
        {
            List<CostItem> extendItems = costItemManager.getExtendItems();
            for (int i = 0; i < extendItems.size(); i++)
            {
                ExtendVO extendVO;
                CostItem extendItem = extendItems.get(i);
                PaymentLog paymentLog = paymentLogManager.getPaymentLog(student
                        .getExamineeNo(), extendItem.getId());
                extendVO = new ExtendVO();
                extendVO.setProject(extendItem.getProject()); // 缴费项目
                extendVO.setPrice(extendItem.getPrice()); // 费用标准
                extendVO.setId(extendItem.getId()); // 发放项目编号
                if (null != paymentLog)
                {

                    extendVO.setPayedMoney(paymentLog.getPayedMoney());// 已缴金额
                    extendVO.setUnPayedMoney(extendItem.getPrice()
                            - paymentLog.getPayedMoney()); // 欠费金额
                    ExtendLog extendLog = extendLogManager.getExtendLog(student
                            .getExamineeNo(), Integer.parseInt(extendItem
                                    .getId().toString())); // 根据学号和发放项目ID查询该学生该项目是否已经领取
                    if (null != extendLog)
                    {
                        extendVO.setReceived(true); // 已领取
                    }
                    else
                    {
                        extendVO.setReceived(false);
                    }
                    extendVOList.add(extendVO);

                }
                else
                {
                    extendVO.setPayedMoney(0);// 已缴金额
                    extendVO.setUnPayedMoney(extendItem.getPrice()); // 欠费金额
                    ExtendLog extendLog = extendLogManager.getExtendLog(student
                            .getExamineeNo(), Integer.parseInt(extendItem
                                    .getId().toString())); // 根据学号和发放项目ID查询该学生该项目是否已经领取
                    if (null != extendLog)
                    {
                        extendVO.setReceived(true); // 已领取
                    }
                    else
                    {
                        extendVO.setReceived(false);
                    }
                    extendVOList.add(extendVO);
                }
            }
        }
    }

    @Override
    public String list() throws Exception
    {

        return LIST;
    }

    // /**
    // *
    // * 取得班级的学生
    // *
    // * @since 2010-9-2
    // * @author houbing.qian
    // * @return
    // * @throws Exception
    // */
    // public String students() throws Exception
    // {
    // if (!page.isOrderBySetted())
    // {
    // page.setOrderBy("orderNum");
    // page.setOrder(Page.DESC);
    // }
    // page.setAutoCount(false);
    // HttpServletRequest request = ServletActionContext.getRequest();
    // List<PropertyFilter> filters = HibernateUtils
    // .buildPropertyFilters(request);
    // ParamPropertyUtils.replacePropertyRule(filters);
    // page = studentManager.search(page, filters);
    // return "mulitinput";
    // }

    /**
     * 
     * 取得班级的学生
     * 
     * @since 2010-12-29
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String students() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("id");
            page.setOrder(Page.ASC);
        }
        page.setAutoCount(false);
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
        .buildPropertyFilters(request);
        ParamPropertyUtils.replacePropertyRule(filters);
        page = studentManager.search(page, filters);

        // 取得专业
        String collegeCode = ParamUtils.getParameter(request,
        "filter_EQS_collegeCode");
        if (StringUtils.isNotEmpty(collegeCode))
        {
            majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        }
        String majorCode = ParamUtils.getParameter(request,
        "filter_EQS_majorCode");
        if (StringUtils.isNotEmpty(majorCode))
        {
            String studentType = ParamUtils.getParameter(request,
            "filter_EQS_type");
            Welbatch welbatch = welbatchManager.getCurrentBatch();
            clazzes = clazzWebService.getClazzsBySpecialty(majorCode,
                    studentType, welbatch.getYear(), welbatch.getSeason());
        }
        // 转化数据列表
        dataMap = convertToMap(page.getResult(), 10);
        return "multiinput";
    }

    /**
     * 
     * 将list进行分组
     * 
     * @since 2010-12-28
     * @author shanru.wu
     * @param students
     *            待分组list
     * @param rowSize
     *            每组大小
     * @return 分组结果map结构，非null
     */
    private Map<Integer, List<Student>> convertToMap(List<Student> students,
            int rowSize)
            {
        Assert.notNull(students);
        Map<Integer, List<Student>> tempDataMap = Maps.newHashMap();
        Integer rows = students.size() % rowSize == 0 ? students.size()
                / rowSize : (students.size() / rowSize + 1);
        List<Student> tempList;
        for (Integer i = 0; i < rows; i++)
        {
            tempList = Lists.newArrayList();
            int toIndex = (i + 1) * 10 > students.size() ? students.size()
                    : (i + 1) * 10;
            tempList = students.subList(i * 10, toIndex);
            tempDataMap.put(i, tempList);
        }
        return tempDataMap;
            }

    /**
     * 
     * load multi give page
     * 
     * @since 2010-8-23
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String multiInput() throws Exception
    {
        return "multiinput";
    }

    /**
     * 
     * 退还发放品
     * 
     * @since 2010-1-24
     * @author shanru.wu
     * @return
     * @throws UnsupportedEncodingException
     */
    public String returnInput() throws UnsupportedEncodingException
    {
        String examineeNo = ParamUtils.getParameter(request, "examineeNo");
        Student student = studentManager.getByExamineeNo(examineeNo);
        BackLog backLog = null;
        if (null != student)
        {
            if (null != returnIds && returnIds.size() > 0)
            {
                for (Long extendItemId : returnIds)
                {

                    ExtendLog extendLog = extendLogManager.getExtendLog(
                            examineeNo, Integer.parseInt(extendItemId
                                    .toString()));
                    CostItem extendItem = costItemManager.get(extendItemId);
                    if (null == extendLog) // 如果该项目没发放记录，不进行退还
                    {
                        continue;
                    }
                    backLog = new BackLog();

                    request.setCharacterEncoding("utf-8");
                    String reason = ParamUtils.getParameter(request, "reason_"
                            + extendItemId); // 退还缘由
                    if (StringUtils.isEmpty(reason))
                    {
                        extendItems();
                        addActionMessage("退还缘由不能为空");
                        return "returninput";
                    }

                    reason = new String(reason.getBytes("ISO-8859-1"), "UTF-8");

                    backLog.setExamineeNo(student.getExamineeNo());
                    backLog.setExtendItemId(Integer.parseInt(extendItemId
                            .toString()));
                    backLog.setOperater(SpringSecurityUtils
                            .getCurrentUserName());
                    backLog.setReason(reason);
                    backLog.setBackTime(new Date());

                    // 处理学生发放操作
                    String giveList = student.getGiveList();
                    String giveString = "";
                    if (StringUtils.isNotEmpty(giveList))
                    {
                        String[] giveItem = giveList.split(",");
                        for (int i = 0; i < giveItem.length; i++)
                        {
                            if (!extendItem.getProject().equals(giveItem[i]))
                            {
                                giveString = giveString + "," + giveItem[i];
                            }
                        }
                    }
                    if (StringUtils.isNotEmpty(giveString)
                            && giveString.substring(0, 1).equals(","))
                    {
                        giveString = giveString.substring(1, giveString
                                .length());
                    }
                    student.setGiveList(giveString);
                    if (StringUtils.isEmpty(giveString))
                    {
                        student.setGived(false);
                    }

                    studentManager.save(student);

                    backLogManager.save(backLog); // 向数据库增加一条退还记录

                    extendLogManager.deleteExtendLog(examineeNo, Integer
                            .parseInt(extendItemId.toString())); // 删除该项目发放记录
                }
                addActionMessage("退还成功");

            }

        }
        extendItems();
        return "returninput";
    }

    /**
     * 
     * 单笔发放
     * 
     * @since 2010-12-28
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @Override
    public String save() throws Exception
    {
        // // 验证
        // if (StringUtils.isEmpty(testNo))
        // {
        // this.giveStatus = "请输入考生号";
        // return "singleinput";
        // }
        // Student student = studentManager.getByExamineeNo(testNo,
        // welbatchManager.getCurrentBatch());
        // if (student == null)
        // {
        // this.giveStatus = "新生不存在";
        // return "singleinput";
        // }
        // if (student.isGived())
        // {
        // this.giveStatus = "已经发放";
        // return "singleinput";
        // }
        // student.setGived(true);
        // student.setGivetime(DateUtils.getNowTimestamp());
        // studentManager.save(student);
        // this.giveStatus = "发放成功";

        String examineeNo = ParamUtils.getParameter(request, "examineeNo");
        student = studentManager.getByExamineeNo(examineeNo);
        if (null != extendIds && extendIds.size() > 0)
        {
            String giveList = student.getGiveList() != null ? student
                    .getGiveList() : ""; // 发放清单
                    ExtendLog extendLog = null;
                    for (Long id : extendIds)
                    {

                        extendLog = extendLogManager.getExtendLog(examineeNo, Integer
                                .parseInt(id.toString()));
                        CostItem extendItem = costItemManager.get(id);

                        if (null != extendLog) // 如果发放，将不在发放
                        {
                            continue;
                        }
                        giveList = giveList + "," + extendItem.getProject();
                        extendLog = new ExtendLog();
                        extendLog.setExamineeNo(examineeNo);
                        extendLog.setExtendItemId(Integer.parseInt(id.toString()));
                        extendLog.setReceived(true);
                        extendLog.setOperater(SpringSecurityUtils.getCurrentUserName());
                        extendLogManager.save(extendLog);
                    }
                    // 改变学生的发放状态并添加发放清单
                    if (StringUtils.isNotEmpty(giveList)
                            && giveList.substring(0, 1).equals(","))
                    {
                        giveList = giveList.substring(1, giveList.length());
                    }
                    student.setGiveList(giveList);
                    student.setGived(true);
                    studentManager.save(student);
        }

        extendItems();
        addActionMessage("发放成功");
        return INPUT;
    }

    /**
     * 
     * 批量发放
     * 
     * @since 2010-8-23
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    public String multisave() throws Exception
    {
        // String[] idArr = ids.split(",");
        // for (String id : idArr)
        // {
        // Student student = studentManager.get(Long.parseLong(id));
        // if (student == null)
        // {
        // continue;
        // }
        // if (student.isGived())
        // {
        // if (checkedIds.indexOf(id + ",") > -1)
        // {
        // continue;
        // }
        // else
        // {
        // student.setGived(false);
        // student.setGivetime(DateUtils.getNowTimestamp());
        // studentManager.save(student);
        // }
        // }
        // else
        // {
        // if (checkedIds.indexOf(id + ",") > -1)
        // {
        // student.setGived(true);
        // student.setGivetime(DateUtils.getNowTimestamp());
        // studentManager.save(student);
        // }
        // }
        //
        // }
        String[] checkIdArr = checkedIds.split(",");
        String[] extendIdArr = checkedExtendIds.split(",");
        ExtendLog extendLog = null;
        for (String id : checkIdArr)
        {
            Student student = studentManager.get(Long.parseLong(id));
            if (student == null)
            {
                continue;
            }
            String giveList = student.getGiveList() != null ? student
                    .getGiveList() : ""; // 发放清单
                    for (String extendItemId : extendIdArr)
                    {
                        extendLog = extendLogManager.getExtendLog(student
                                .getExamineeNo(), Integer.parseInt(extendItemId));
                        CostItem extendItem = costItemManager.get(Long
                                .parseLong(extendItemId));
                        if (null != extendLog) // 如果该项目已发放，将不再重复发放
                        {
                            continue;
                        }
                        giveList = giveList + "," + extendItem.getProject();
                        extendLog = new ExtendLog();
                        extendLog.setExamineeNo(student.getExamineeNo());
                        extendLog.setExtendItemId(Integer.parseInt(extendItemId));
                        extendLog.setReceived(true);
                        extendLog.setOperater(SpringSecurityUtils.getCurrentUserName());
                        extendLogManager.save(extendLog);
                    }
                    // 改变学生的发放状态并添加发放清单
                    if (StringUtils.isNotEmpty(giveList)
                            && giveList.substring(0, 1).equals(","))
                    {
                        giveList = giveList.substring(1, giveList.length());
                    }
                    student.setGiveList(giveList);
                    student.setGived(true);
                    studentManager.save(student);
        }

        Struts2Utils.renderText("成功完成");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    @Override
    protected void prepareModel() throws Exception
    {
    }

    public Object getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    // -- 其他 Action 函数 --//

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
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

    @Autowired
    public void setCostItemManager(CostItemManager costItemManager)
    {
        this.costItemManager = costItemManager;
    }

    @Autowired
    public void setExtendLogManager(ExtendLogManager extendLogManager)
    {
        this.extendLogManager = extendLogManager;
    }

    @Autowired
    public void setPaymentLogManager(PaymentLogManager paymentLogManager)
    {
        this.paymentLogManager = paymentLogManager;
    }

    public void setNoticeId(String noticeId)
    {
        this.noticeId = noticeId;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public void setTestNo(String testNo)
    {
        this.testNo = testNo;
    }

    public void setIds(String ids)
    {
        this.ids = ids;
    }

    public void setCheckedIds(String checkedIds)
    {
        this.checkedIds = checkedIds;
    }

    public void setExtendIds(List<Long> extendIds)
    {
        this.extendIds = extendIds;
    }

    public void setCheckedExtendIds(String checkedExtendIds)
    {
        this.checkedExtendIds = checkedExtendIds;
    }

    @Autowired
    public void setBackLogManager(BackLogManager backLogManager)
    {
        this.backLogManager = backLogManager;
    }

    public void setReturnIds(List<Long> returnIds)
    {
        this.returnIds = returnIds;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public String getGiveStatus()
    {
        return giveStatus;
    }

    public Map<Integer, List<Student>> getDataMap()
    {
        return dataMap;
    }

    /**
     * 页面访问学生信息
     */
    public Student getStudent()
    {
        return student;
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
        return majors == null ? new ArrayList<SpecialtyDTO>() : majors;
    }

    public List<ClazzDTO> getClazzes()
    {
        return clazzes == null ? new ArrayList<ClazzDTO>() : clazzes;
    }

    public Page<Student> getPage()
    {
        return page;
    }

    public void setPage(Page<Student> page)
    {
        this.page = page;
    }

    public String getNoticeId()
    {
        return noticeId;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public String getTestNo()
    {
        return testNo;
    }

    public String getIds()
    {
        return ids;
    }

    public String getCheckedIds()
    {
        return checkedIds;
    }

    public Page<CostItem> getGivePage()
    {
        return givePage;
    }

    /**
     * 页面显示发放项目
     */
    public List<ExtendVO> getExtendItems()
    {
        List<CostItem> extendItemOs = costItemManager.getExtendItems(); 

        for(CostItem costItem : extendItemOs){
            if(this.student!=null && this.student.getGiveList()!=null && this.student.getGiveList().indexOf(costItem.getProject())>-1)
            {
                extendItems.add(new ExtendVO(costItem.getId(),costItem.getProject(),true));
            }
            else
            {
                extendItems.add(new ExtendVO(costItem.getId(),costItem.getProject(),false));
            }
        }
        return extendItems;
    }

    /**
     * 页面显示退还项目
     */
    public List<CostItem> getReturnItems()
    {
        this.returnItems = costItemManager.getReturnItems();
        return returnItems;
    }

    public List<ExtendVO> getExtendVOList()
    {
        return extendVOList;
    }

    /**
     * 页面radio集合
     */
    public List<LabelValue> getRadioList()
    {
        radioList = new ArrayList<LabelValue>();
        radioList.add(new LabelValue("noticeId", "通知书编号"));
        radioList.add(new LabelValue("examineeNo", "考生号"));
        radioList.add(new LabelValue("studentNo", "学号"));
        return radioList;
    }

    public String getValue()
    {
        return value;
    }

    public void setValue(String value)
    {
        this.value = value;
    }
}