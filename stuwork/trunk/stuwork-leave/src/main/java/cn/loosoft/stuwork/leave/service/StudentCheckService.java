package cn.loosoft.stuwork.leave.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.leave.dao.StudentCheckDao;
import cn.loosoft.stuwork.leave.entity.StudentCheck;

/**
 * 学生审核相关的业务类
 * 
 * @author bochins
 * @since 2012-6-11
 */
// 表示是一个组件 能被spring 管理 自动织入
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StudentCheckService extends EntityManager<StudentCheck, Long> {
	private StudentCheckDao studentCheckDao;
	
	@Autowired
	public void setStudentCheckDao(StudentCheckDao studentCheckDao) {
		this.studentCheckDao = studentCheckDao;
	}
	
	@Override
	protected HibernateDao<StudentCheck, Long> getEntityDao() {
		return studentCheckDao;
	}
	
	
	public StudentCheck get(String studentno,String departmentCode )
	{
		return studentCheckDao.get(studentno, departmentCode);
	}
	
}
