package cn.loosoft.stuwork.welnew.web.clazz;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.clazz.MajorClazzInfo;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

/**
 * 
 * 手工分班管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-9
 */
// @ParentPackage("json-default")
@Namespace("/clazz")
public class HandAssignAction extends CrudActionSupport<MajorClazzInfo>
{

    private static final long serialVersionUID = 1L;

    private ClazzWebService   clazzWebService;

    private StudentManager    studentManager;

    /**
     * 手工分班
     * 
     * @author shanru.wu
     * @since 2010-12-9
     */
    public String handClazz()
    {

        HttpServletRequest request = ServletActionContext.getRequest();

        String idString = request.getParameter("ids");
        String id2String = request.getParameter("ids2");

        String flag = ParamUtils.getParameter(request, "flag");

        String classCode = ParamUtils.getParameter(request, "classCode");

        // String majorCode=ParamUtils.getParameter(request,"majorCode");

        String className = clazzWebService.getClazzName(classCode);

        if (flag.equals("update"))
        {
            if (null != idString)
            {
                String[] ids = idString.split(",");

                for (String id : ids)
                {
                    Student student = studentManager.get(Long.parseLong(id));
                    student.setClassName(className);
                    student.setClassCode(classCode);
                    studentManager.save(student);
                }
            }

            Struts2Utils.renderText("学生成功添加到此班级");
        }
        else
            if (flag.equals("delete"))
            {
                if (null != id2String)
                {
                    String[] ids = id2String.split(",");
                    for (String id : ids)
                    {
                        Student student = studentManager
                                .get(Long.parseLong(id));
                        student.setClassName("");
                        student.setClassCode("");
                        studentManager.save(student);
                    }
                }
                Struts2Utils.renderText("学生成功从此班级移除");
            }

        return null;
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
        System.out.println("========执行到这里了啊==================");
        return null;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public MajorClazzInfo getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService)
    {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

}
