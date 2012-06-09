package cn.loosoft.stuwork.backmanage.web.school;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.school.Scharea;
import cn.loosoft.stuwork.backmanage.service.school.SchareaManager;

/**
 * 
 * 学区管理Action.
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-19
 */
@Namespace("/school")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "scharea.action", type = "redirect") })
public class SchareaAction extends CrudActionSupport<Scharea> {

    private static final long serialVersionUID = 1L;

    @Autowired
    private SchareaManager schareaManager;

    //-- 页面属性 --//
    private Long id;
    private Scharea entity;
    private List<Scharea> allAreaList;//学区列表
    private List<Long> ids;//批量id
    //-- ModelDriven 与 Preparable函数 --//
    public Scharea getModel() {
        return entity;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    protected void prepareModel() throws Exception {
        if (id != null) {
            entity = schareaManager.get(id);
        } else {
            entity = new Scharea();
        }
    }
    public void setIds(List<Long> ids) {
        this.ids = ids;
    }

    //-- CRUD Action 函数 --//
    @Override
    public String list() throws Exception {
        allAreaList = schareaManager.getAll();
        return SUCCESS;
    }

    @Override
    public String input() throws Exception {
        return INPUT;
    }

    @Override
    public String save() throws Exception {
        //保存用户并放入成功信息.
        schareaManager.save(entity);
        addActionMessage("保存学区成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception {
        schareaManager.delete(id);
        Struts2Utils.renderText("删除学区成功");
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
        schareaManager.deleteSchareas(ids);
        addActionMessage("批量删除学区成功");
        return RELOAD;
    }


    //-- 页面属性访问函数 --//
    /**
     * list页面显示所有学区列表.
     */
    public List<Scharea> getAllAreaList() {
        return this.allAreaList;
    }

}