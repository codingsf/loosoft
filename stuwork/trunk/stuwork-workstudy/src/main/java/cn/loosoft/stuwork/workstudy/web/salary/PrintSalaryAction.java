package cn.loosoft.stuwork.workstudy.web.salary;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.Constant;
import cn.loosoft.stuwork.workstudy.entity.salary.Salary;
import cn.loosoft.stuwork.workstudy.service.salary.SalaryManager;
import cn.loosoft.stuwork.workstudy.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.workstudy.util.ExcelDownLoad;
import cn.loosoft.stuwork.workstudy.util.ExcelModel;

/**
 * 
 * 小组审核工资单Action.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-3-7
 */
@Namespace("/salary")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "print-salary.action", type = "redirect") })
public class PrintSalaryAction extends CrudActionSupport<Salary>
{

    /**
     * serialVersionUID long
     */
    private static final long         serialVersionUID = 1L;

    private Salary                    entity;

    private SalaryManager             salaryManager;

    private StudentWebService         studentWebService;

    private final HttpServletResponse response         = Struts2Utils
                                                               .getResponse();

    // 页面属性
    private Long                      id;

    private List<Long>                ids;                                         // 批量id

    private Page<Salary>              page             = new Page<Salary>(
                                                               Constant.PAGE_SIZE);

    private String                    startWorkStartTime;

    private String                    endWorkStartTime;

    private String                    startWorkStopTime;

    private String                    endWorkStopTime;

    /**
     * 
     * 打印单个数据
     * 
     * @since 2011-3-7
     * @author Administrator
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String print() throws Exception
    {
        String titleStr = "姓名;身份证号;岗位;用工单位;银行名称;银行账户;工作开始时间;工作结束时间;工作时长;工资标准;工资金额;";// 标题
        ArrayList header = new ArrayList();
        ExcelModel excel = new ExcelModel();
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();
        Salary salary = salaryManager.get(id);
        // 把已生成的过的，进行标识
        salary.setIsPrint("已生成");
        salaryManager.save(salary);

        ArrayList rowData = new ArrayList();
        StudentDTO studentDTO = studentWebService.getStudentByStudentNo(salary
                .getStudentNo());

        rowData.add(salary.getStudentName());
        rowData.add(studentDTO.getCardNum());
        rowData.add(salary.getPostName());
        rowData.add(salary.getCompanyName());
        rowData.add(studentDTO.getBankName());
        rowData.add(studentDTO.getBankAccount());
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        String startDate = f.format(salary.getWorkStartTime());
        rowData.add(startDate);
        String endDate = f.format(salary.getWorkStopTime());
        rowData.add(endDate);
        rowData.add(salary.getWorkTime());
        rowData.add(salary.getStandard());
        rowData.add(salary.getAmount());
        data.add(rowData);
        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("学生工资单");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {
            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();
            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("学生工资单.xls", excel, response);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 
     * 打印多条记录
     * 
     * @since 2011-3-8
     * @author Administrator
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printAll() throws Exception
    {
        List<Salary> salaryList = new ArrayList<Salary>();
        if (null != ids && ids.size() > 0)
        {
            for (int i = 0; i < ids.size(); i++)
            {
                Salary salary = salaryManager.get(ids.get(i));
                // 把已生成的过的，进行标识
                salary.setIsPrint("已生成");
                salaryManager.save(salary);
                salaryList.add(salary);
            }
        }
        else
        {
            addActionMessage("没有可打印记录,请勾选");
        }

        String titleStr = "姓名;身份证号;岗位;用工单位;银行名称;银行账户;工作开始时间;工作结束时间;工作时长;工资标准;工资金额;";// 标题
        ArrayList header = new ArrayList();
        ExcelModel excel = new ExcelModel();
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }
        ArrayList data = new ArrayList();

        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        for (int i = 0; i < salaryList.size(); i++)
        {
            ArrayList rowData = new ArrayList();
            Salary salary = salaryList.get(i);

            StudentDTO studentDTO = studentWebService
                    .getStudentByStudentNo(salary.getStudentNo());

            rowData.add(salary.getStudentName());
            rowData.add(studentDTO.getCardNum());
            rowData.add(salary.getPostName());
            rowData.add(salary.getCompanyName());
            rowData.add(salary.getBankName());
            rowData.add(salary.getBankAccount());
            String startDate = f.format(salary.getWorkStartTime());
            rowData.add(startDate);
            String endDate = f.format(salary.getWorkStopTime());
            rowData.add(endDate);
            rowData.add(salary.getWorkTime());
            rowData.add(salary.getStandard());
            rowData.add(salary.getAmount());

            data.add(rowData);
        }

        // 设置报表标题
        excel.setHeader(header);
        // 报表名称
        excel.setSheetName("学生工资单");
        // 设置报表内容
        excel.setData(data);
        // 写入到Excel格式输出流供下载
        try
        {
            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();
            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("学生工资单.xls", excel, response);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return SUCCESS;
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
            page.setOrder(Page.DESC);
            page.setOrderBy("createDate");
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(request);
        // 必须判断是否为null，因为空值传进参数，会报错
        if (startWorkStartTime != null && endWorkStartTime != null)
        {
            if (startWorkStartTime.length() != 0
                    && endWorkStartTime.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_workStartTime",
                        startWorkStartTime));
                filters.add(new PropertyFilter("LED_workStartTime",
                        endWorkStartTime));
            }
        }
        if (startWorkStopTime != null && endWorkStopTime != null)
        {
            if (startWorkStopTime.length() != 0
                    && endWorkStopTime.length() != 0)
            {
                // 还有判断空值
                filters.add(new PropertyFilter("GED_workStopTime",
                        startWorkStopTime));
                filters.add(new PropertyFilter("LED_workStopTime",
                        endWorkStopTime));
            }
        }

        filters.add(new PropertyFilter("EQS_centerStatus", Constant.SHTG));
        page = salaryManager.search(page, filters);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = salaryManager.get(id);
        }
        else
        {
            entity = new Salary();
        }
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public Salary getModel()
    {
        return entity;
    }

    public Page<Salary> getPage()
    {
        return page;
    }

    public void setPage(Page<Salary> page)
    {
        this.page = page;
    }

    public Salary getEntity()
    {
        return entity;
    }

    public void setEntity(Salary entity)
    {
        this.entity = entity;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public List<Long> getIds()
    {
        return ids;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    @Autowired
    public void setSalaryManager(SalaryManager salaryManager)
    {
        this.salaryManager = salaryManager;
    }

    public String getStartWorkStartTime()
    {
        return startWorkStartTime;
    }

    public void setStartWorkStartTime(String startWorkStartTime)
    {
        this.startWorkStartTime = startWorkStartTime;
    }

    public String getEndWorkStartTime()
    {
        return endWorkStartTime;
    }

    public void setEndWorkStartTime(String endWorkStartTime)
    {
        this.endWorkStartTime = endWorkStartTime;
    }

    public String getStartWorkStopTime()
    {
        return startWorkStopTime;
    }

    public void setStartWorkStopTime(String startWorkStopTime)
    {
        this.startWorkStopTime = startWorkStopTime;
    }

    public String getEndWorkStopTime()
    {
        return endWorkStopTime;
    }

    public void setEndWorkStopTime(String endWorkStopTime)
    {
        this.endWorkStopTime = endWorkStopTime;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

    public StudentWebService getStudentWebService()
    {
        return studentWebService;
    }
}
