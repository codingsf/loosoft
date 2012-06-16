package cn.loosoft.stuwork.leave.dao;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.leave.entity.Student;

/**
 * 学生持久化类
 * 
 * @author bochins
 * @since 2012-6-9
 */
@Component
public class StudentDao extends HibernateDao<Student, Long> {

	public Page<Student> search(Page<Student> page, String collegeCode,
			String majorCode, String classCode, String comname, Boolean status)

	{
		String hql = "from Student where 1=1";
		if (collegeCode != null && StringUtils.isNotEmpty(collegeCode)) {
			hql += " and collegeCode='" + collegeCode + "' ";
		}
		if (majorCode != null && StringUtils.isNotEmpty(majorCode)) {
			hql += " and majorCode='" + majorCode + "' ";
		}
		if (classCode != null && StringUtils.isNotEmpty(classCode)) {
			hql += " and classCode='" + classCode + "' ";
		}

		return super.findPage(page, hql);
	}
}
