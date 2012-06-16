package cn.loosoft.stuwork.leave.dao;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.leave.entity.StudentCheck;

/**
 * 审核学生持久化类
 * 
 * @author bochins
 * @since 2012-6-12
 */
@Component
public class StudentCheckDao extends HibernateDao<StudentCheck, Long> {

	public StudentCheck get(String studentno, String departmentCode) {
		String hql = "from StudentCheck where studentid=? and departmentcode=?";
		return super.findUnique(hql, studentno, departmentCode);
	}

}
