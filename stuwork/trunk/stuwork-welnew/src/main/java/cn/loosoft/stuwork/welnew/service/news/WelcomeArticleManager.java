package cn.loosoft.stuwork.welnew.service.news;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.news.WelcomeArticleDao;
import cn.loosoft.stuwork.welnew.entity.news.WelcomeArticle;
/**
 * 
 * 迎新辞管理类.
 * 
 * @author jie.yang
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class WelcomeArticleManager extends EntityManager<WelcomeArticle, Long> {

	private WelcomeArticleDao welcomeArticleDao;
	
	@Autowired
	public void setWelcomeArticleDao(WelcomeArticleDao welcomeArticleDao) {
		this.welcomeArticleDao = welcomeArticleDao;
	}

	@Override
	protected HibernateDao<WelcomeArticle, Long> getEntityDao() {
		// TODO Auto-generated method stub
		return welcomeArticleDao;
	}

}
