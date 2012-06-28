package cn.loosoft.stuwork.welnew.web.sys;

import java.sql.Date;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.sys.SysData;
import cn.loosoft.stuwork.welnew.service.sys.SysDataManager;

/**
 * 
 * 报到时间设置Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-28
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "registertime.action", type = "redirect") })
public class RegistertimeAction extends CrudActionSupport<SysData>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private Long              id;                   // 编号

    private SysData           sysData;              // 基础数据实体

    private SysDataManager    sysDataManager;       // 基础数据管理

    private Date              startdate;            // 开始时间

    private Date              enddate;              // 结束时间

    public Date getStartdate()
    {
        return startdate;
    }

    public void setStartdate(Date startdate)
    {
        this.startdate = startdate;
    }

    public Date getEnddate()
    {
        return enddate;
    }

    public void setEnddate(Date enddate)
    {
        this.enddate = enddate;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    @Autowired
    public void setSysDataManager(SysDataManager sysDataManager)
    {
        this.sysDataManager = sysDataManager;
    }

    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub

        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        sysData = sysDataManager.getSysData(SysData.BDSJ);
        if (sysData != null)
        {
            String[] regTime = sysData.getSetvalue().split(",");
            startdate = Date.valueOf(regTime[0]);
            enddate = Date.valueOf(regTime[1]);

        }
        else
        {
            sysData = new SysData();
            System.out.println("是空的");
        }
    }

    @Override
    public String save() throws Exception
    {
        SysData sys = new SysData();
        String regTime = startdate.toString() + "," + enddate.toString();
        sysData.setSetvalue(regTime);
        sysData.setType("bdsj");
        sysData.setDescription("报到时间");
        sysDataManager.save(sys);
        return INPUT;

    }

    public SysData getModel()
    {
        // TODO Auto-generated method stub
        return sysData;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

}
