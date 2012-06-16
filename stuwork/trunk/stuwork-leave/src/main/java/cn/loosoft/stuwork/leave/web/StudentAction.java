package cn.loosoft.stuwork.leave.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.leave.entity.Student;
import cn.loosoft.stuwork.leave.service.StudentService;
/**
 * 离校学生Action.
 * 
 * @since 2012-6-11
 * 
 * @author chenbo
 */
@Namespace("/student")

public class StudentAction  extends CrudActionSupport<Student>{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// -- 页面属性 --//
    private Long                id;

    private Student                entity;
    

    private Page<Student>          page             = new Page<Student>(20); // 每页20条记录
    
    @Autowired
    private StudentService studentService;
    
    
    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = studentService.get(id);
        }
        else
        {
            entity = new Student();
        }
    }
    
    public Page<Student> getPage() {
		return page;
	}

	public Student getModel()
    {
        return entity;
    }

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public String init() throws Exception
	{
		return null;	
	}
    
}
