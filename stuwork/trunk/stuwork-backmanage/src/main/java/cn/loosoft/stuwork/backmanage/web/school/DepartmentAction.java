package cn.loosoft.stuwork.backmanage.web.school;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.school.Department;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.service.school.DepartmentManager;
import cn.loosoft.stuwork.backmanage.service.school.InstituteManager;

/**
 * 
 * 系管理Action.
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-19
 */
@Namespace("/school")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "department.action", type = "redirect") })
public class DepartmentAction extends CrudActionSupport<Department> {

    private static final long serialVersionUID = 1L;

    @Autowired
    private DepartmentManager departmentManager;
    @Autowired
    private InstituteManager instituteManager;

    //-- 页面属性 --//
    private Long id;
    private Department entity;
    private List<Department> dataList;//列表页显示数据
    private List<Long> ids;//批量

    private Long instituteId;//页面提交和显示的学院id
    private List<Institute> instituteList;//

    //-- ModelDriven 与 Preparable函数 --//
    public Department getModel() {
        return entity;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    protected void prepareModel() throws Exception {
        if (id != null) {
            entity = departmentManager.get(id);
        } else {
            entity = new Department();
        }
    }
    public void setIds(List<Long> ids) {
        this.ids = ids;
    }

    //-- CRUD Action 函数 --//
    @Override
    public String list() throws Exception {
        dataList = departmentManager.getAll();
        return SUCCESS;
    }

    @Override
    public String input() throws Exception {
        //给系的学院赋页面id域的值
        instituteId = entity.getInstitute()!=null?entity.getInstitute().getId():0;
        //填充学院数据
        instituteList = instituteManager.getAll();
        return INPUT;
    }

    @Override
    public String save() throws Exception {
        //set institute 
        entity.setInstitute(instituteManager.get(instituteId));
        //保存用户并放入成功信息.
        departmentManager.save(entity);
        addActionMessage("保存系成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception {
        departmentManager.delete(id);
        Struts2Utils.renderText("删除系成功");
        //因为直接输出内容而不经过jsp,因此返回null.
        return null;        
    }

    /**
     * 
     * 删除多笔记录
     * @since  2010-8-20
     * @author houbing.qian
     * @return
     * @throws Exception
     */
    public String deletes() throws Exception {
        departmentManager.deleteDepartments(ids);
        addActionMessage("批量删除学院成功");
        return RELOAD;
    }


    //-- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<Department> getDataList() {
        return this.dataList;
    }

    /**
     * list页面显示所有学院列表.
     */
    public List<Institute> getInstituteList() {
        return instituteList;
    }

    public Long getInstituteId()
    {
        return instituteId;
    }

    public void setInstituteId(Long instituteId)
    {
        this.instituteId = instituteId;
    }    

}