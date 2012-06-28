package cn.loosoft.stuwork.stuinfo.web.student;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.stuwork.stuinfo.service.student.StudentManager;
import cn.loosoft.stuwork.stuinfo.vo.SpecialCountVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 学生统计管理Action，用于前台显示.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数. 演示带分页的管理界面.
 * 
 * @author fangyong
 * @author houbing.qian
 */
// 定义URL映射对应/news/article.action
@Namespace("/student")
// 定义名为reload的result重定向到user.action, 其他result则按照convention默认 .
public class StudentCountAction extends ActionSupport
{
    /**
     * serialVersionUID long
     */
    private static final long    serialVersionUID = 1L;

    private InstituteWebService  instituteWebService;

    private SpecialtyWebService  specialtyWebService;

    private StudentManager       studentManager;

    private String               collegeCode;                            // 院系编号

    private List<SpecialCountVO> stuCountVOList   = Lists.newArrayList();

    /**
     * 学生基础信息统计
     * 
     * @since 2011-12-14
     * @see com.opensymphony.xwork2.ActionSupport#execute()
     */
    @Override
    public String execute() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();

        Calendar calendar = Calendar.getInstance();

        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        if (month > 7)
        {
            year = year + 1;
        }

        String collegeCode = ParamUtils.getParameter(request, "collegeCode",
                null);
        String specialCode = ParamUtils
                .getParameter(request, "majorCode", null);

        stuCountVOList = studentManager.countStudent(collegeCode, specialCode,
                year);

        // 预科总学生数
        long yukeCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            yukeCount += sp.getYukeStuCount();
        }
        request.setAttribute("yukeCount", yukeCount);

        // 一年级总学生数
        long freCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            freCount += sp.getFreBeStuCount() + sp.getFreZhStuCount()
                    + sp.getFreZsbStuCount();
        }
        request.setAttribute("freCount", freCount);

        // 二年级总学生数
        long sopCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            sopCount += sp.getSopBeStuCount() + sp.getSopZhStuCount()
                    + sp.getSopZsbStuCount();
        }
        request.setAttribute("sopCount", sopCount);

        // 三年级总学生数
        long junCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            junCount += sp.getJunBeStuCount() + sp.getJunZhStuCount();
        }
        request.setAttribute("junCount", junCount);

        // 四年级总学生数
        long senCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            senCount += sp.getSenBeStuCount();
        }
        request.setAttribute("senCount", senCount);

        // 小计总学生数
        long xiaojiCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            xiaojiCount += sp.getTotalStuNumber();
        }
        request.setAttribute("xiaojiCount", xiaojiCount);

        // 全校总学生数
        long allCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            allCount += sp.getTotalCount();
        }
        request.setAttribute("allCount", allCount);

        // 预计毕业学生数
        long yujiCount = 0;
        for (SpecialCountVO sp : stuCountVOList)
        {
            yujiCount += sp.getTotalNumber();
        }
        request.setAttribute("yujiCount", yujiCount);

        // 预计毕业年份
        request.setAttribute("year", year);

        return SUCCESS;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    // 取得专业
    public List<SpecialtyDTO> getMajors()
    {
        List<SpecialtyDTO> majors = Lists.newArrayList();

        if (StringUtils.isNotBlank(collegeCode))
        {
            majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
        }
        return majors;
    }

    // 取得院系
    public List<InstituteDTO> getCollegues()
    {
        List<InstituteDTO> collegues = Lists.newArrayList();

        collegues = instituteWebService.getInstitutes();

        return collegues;
    }

    // 院系编号
    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public List<SpecialCountVO> getStuCountVOList()
    {
        return stuCountVOList;
    }

}