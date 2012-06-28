package cn.loosoft.stuwork.welnew.web.clazz;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;

import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.clazz.MajorClazzInfo;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.clazz.MajorClazzInfoManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.MajorClazzVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 专业分班信息管理Action.
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-25
 */
@Namespace("/clazz")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "majorclazz.action", type = "redirect") })
public class MajorClazzAction extends ActionSupport
{

    private static final long          serialVersionUID = 1L;

    // @Autowired
    // private SpecialtyWebService specialtyWebService;

    @Autowired
    private WelbatchManager            welbatchManager;

    @Autowired
    private MajorClazzInfoManager      majorClazzInfoManager;

    @Autowired
    private ClazzWebService            clazzWebService;

    @Autowired
    private StudentManager             studentManager;

    // -- 页面属性 --//
    private List<MajorClazzVO>         dataList;                                    // 列表页面显示数据

    private final Page<MajorClazzInfo> page             = new Page<MajorClazzInfo>(
            Constant.PAGE_SIZE); // 分页列表页面显示数据

    @Override
    public String execute()
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("welbatch");
            page.setOrder(Page.DESC);
        }
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        List<PropertyFilter> filters = Lists.newArrayList();
        filters.add(new PropertyFilter("EQL_welbatch.id", welbatch.getId().toString()));

        List<MajorClazzInfo> majorClazzInfos = majorClazzInfoManager.getAll(filters);
        List<MajorClazzInfo> infoList = majorClazzInfoManager
        .handleMajorClazzInfos(majorClazzInfos, welbatch);
        dataList = convertToVOList(infoList);
        return Action.SUCCESS;
    }

    /**
     * 
     * 将专业班级信息po转化成vo输出到页面
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param infoList
     * @return
     */
    private List<MajorClazzVO> convertToVOList(List<MajorClazzInfo> infoList)
    {
        List<MajorClazzVO> resList = Lists.newArrayList();
        MajorClazzVO majorClazzVO = null;
        for (MajorClazzInfo majorClazzInfo : infoList)
        {
            long studentNums = studentManager.countStudent(majorClazzInfo
                    .getMajorCode(), majorClazzInfo.getType(), majorClazzInfo
                    .getWelbatch());
            if (studentNums == 0)
            {
                continue;
            }
            majorClazzVO = new MajorClazzVO();
            majorClazzVO
            .setCollegeDepartName(majorClazzInfo.getColdepartdesc());
            majorClazzVO.setMajorName(majorClazzInfo.getMajorName());
            majorClazzVO.setWelbatch(majorClazzInfo.getWelbatch().getComname());
            majorClazzVO.setAssigned(majorClazzInfo.isAssigned());
            majorClazzVO.setAssignDate(majorClazzInfo.getAssignDate());
            String clazzStr = clazzWebService.getClazzStrBySpecialty(
                    majorClazzInfo.getMajorCode(), majorClazzInfo.getType(),
                    majorClazzInfo.getWelbatch().getYear(), majorClazzInfo
                    .getWelbatch().getSeason());
            majorClazzVO.setClazzs(clazzStr);
            majorClazzVO.setClazzNums(StringUtils.isEmpty(clazzStr) ? 0
                    : clazzStr.split(",").length);
            majorClazzVO.setInfoId(majorClazzInfo.getId());
            majorClazzVO.setTypedesc(StudentType.getDesc(majorClazzInfo
                    .getType()));
            majorClazzVO.setStudentNums(Integer.parseInt(String
                    .valueOf(studentNums)));
            resList.add(majorClazzVO);
        }
        return resList;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<MajorClazzVO> getDataList()
    {
        return this.dataList;
    }

    public Page<MajorClazzInfo> getPage()
    {
        return page;
    }

    /**
     * 
     * 页面显示默认班级预设人数
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @return
     */
    public int getPersonNum()
    {
        return 50;
    }

}