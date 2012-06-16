package cn.loosoft.stuwork.leave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.leave.dao.StudentDao;
import cn.loosoft.stuwork.leave.entity.Student;

/**
 * 学生相关的业务类
 * 
 * @author bochins
 * @since 2012-6-11
 */
// 表示是一个组件 能被spring 管理 自动织入
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StudentService extends EntityManager<Student, Long> {

	private StudentDao studentDao;

	@Autowired
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}

	@Override
	protected HibernateDao<Student, Long> getEntityDao() {
		return studentDao;
	}

	public Page<Student> search(Page<Student> page, String collegeCode,
			String majorCode, String classCode, String comname, Boolean status)

	{
		return studentDao.search(page, collegeCode, majorCode, classCode,
				comname, status);

	}

}
