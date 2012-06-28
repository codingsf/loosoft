package cn.loosoft.stuwork.welnew.web.register;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.register.Register;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.register.RegisterManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

/**
 * 
 * 迎新网站管理Action.
 * 
 * @author bo.chen
 * @version 1.0
 * @since 2010-12-2
 */
@Namespace("/register")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "regist.action", type = "redirect") })
public class RegisterAction extends CrudActionSupport<Register>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private Register          entity;               // 注册信息实体类

    @Autowired
    private RegisterManager   registerManger;

    @Autowired
    private StudentManager    studentManager;

    @Autowired
    private WelbatchManager   welbatchManager;

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String save() throws Exception
    {
        // ----------------------------

        Student student = studentManager.getByIDcard(entity.getPassword());
        if (student == null)
        {
            Struts2Utils.renderText("此身份证号码不正确");
            return null;
        }
        else
        {
            student = studentManager.getByNoticeId(entity.getNoticeId());
            if (student == null)
            {
                Struts2Utils.renderText("此通知书号码不正确");
                return null;
            }
            else
            {
                Register register = registerManger.findUniqueByIDCard(entity
                        .getPid(), entity.getNoticeId());
                if (register == null)
                {
                    // -------
                    Welbatch welbatch = welbatchManager.getCurrentBatch();
                    Student stu = studentManager.getByIdCardNo(entity.getPid(),
                            welbatch);
                    stu.setNoticeId(register.getNoticeId());
                    stu.setStudentNo("2222");
                    studentManager.save(stu);
                    entity.setLoginName("");
                    registerManger.save(entity);
                    Struts2Utils.renderText("注册成功");
                    return null;
                }
                else
                {
                    Struts2Utils.renderText("该新生已注册");
                    return null;
                }

            }
        }

    }

    public Register getEntity()
    {
        return entity;
    }

    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        entity = new Register();
    }

    public Register getModel()
    {
        return entity;
    }

}
