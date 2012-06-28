package cn.loosoft.stuwork.welnew.web.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.sys.LogData;
import cn.loosoft.stuwork.welnew.service.sys.LogDataManager;

/**
 * 
 * 操作日志Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "logdata.action", type = "redirect") })
public class LogdataAction extends CrudActionSupport<LogData>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private Long              id;

    private LogData           logdata;

    private Page<LogData>     page             = new Page<LogData>(10);

    @Autowired
    private LogDataManager    logDataManager;

    public Long getId()
    {
        return id;
    }

    public Page<LogData> getPage()
    {
        return page;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        HttpServletRequest request = Struts2Utils.getRequest();
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(Struts2Utils.getRequest());
        ParamPropertyUtils.replacePropertyRule(filters);// 替换'$'
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("id");
        }
        String operateEndDate = ParamUtils.getParameter(request,
                "operateEndDate", null);

        if (StringUtils.isNotBlank(operateEndDate))
        {
            filters.add(new PropertyFilter("LED_operatedate", operateEndDate
                    + " 23:59:59"));
        }
        page = logDataManager.search(page, filters);

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {

    }

    @Override
    public String save() throws Exception
    {

        return RELOAD;
    }

    public LogData getModel()
    {
        return logdata;
    }

}
