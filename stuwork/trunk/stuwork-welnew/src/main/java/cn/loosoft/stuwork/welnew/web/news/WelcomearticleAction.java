package cn.loosoft.stuwork.welnew.web.news;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.entity.news.WelcomeArticle;
import cn.loosoft.stuwork.welnew.service.news.WelcomeArticleManager;

/**
 * 
 * 迎新网站管理Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/news")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "welcomearticle.action", type = "redirect") })
public class WelcomearticleAction extends CrudActionSupport<WelcomeArticle>
{

    /**
     * serialVersionUID long
     */
    private static final long     serialVersionUID = 1L;

    private WelcomeArticleManager welcomeArticleManager; // 迎新辞管理

    private WelcomeArticle        welcomeArticle;       // 迎新辞实体

    public WelcomeArticle getWelcomeArticle()
    {
        return welcomeArticle;
    }

    private Long id; // 编号

    public void setId(Long id)
    {
        this.id = id;
    }

    @Autowired
    public void setWelcomeArticleManager(
            WelcomeArticleManager welcomeArticleManager)
    {
        this.welcomeArticleManager = welcomeArticleManager;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            welcomeArticle = welcomeArticleManager.get(id);
        }
        else
        {
            welcomeArticle = new WelcomeArticle();
        }

    }

    @Override
    public String save() throws Exception
    {
        welcomeArticle.setUser(SpringSecurityUtils.getCurrentUserName());
        welcomeArticleManager.save(welcomeArticle);
        return RELOAD;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-12
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub
        if (welcomeArticleManager.getAll().size() > 0)
        {
            welcomeArticle = welcomeArticleManager.getAll().get(0);
        }
        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-1-5
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public WelcomeArticle getModel()
    {
        // TODO Auto-generated method stub
        return welcomeArticle;
    }

}
