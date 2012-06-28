package cn.loosoft.stuwork.welnew.web.student;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;

import cn.loosoft.stuwork.common.entity.user.SecurityUser;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.util.MathUtils;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 新生注册管理Action.
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-22
 */
@Namespace("/student")
@Results( { @Result(name = "list", location = "reg-list.jsp")})
public class RegAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    @Autowired
    private StudentManager studentManager;

    @Autowired
    private WelbatchManager welbatchManager;

    //-- 页面属性 --//
    private String examineeNo;//考生号

    private String IDcard;//省份证号

    private String regStatus;//注册状态

    private long total;//总数

    private long regTotal;//报到数

    private String regRate;//报到率

    private String collegeName = "全校";//学院名称

    private String name;//姓名
    private String province;//省份

    private Welbatch welbatch;

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public String list(){
        return "list";
    }


    @Override
    public String execute(){

        perpareCountData(SpringSecurityUtils.getCurrentUser());
        System.out.println(SpringSecurityUtils.getCurrentUser().getUsername());
        Student student = null;
        if(!StringUtils.isEmpty(examineeNo)){
            Welbatch welbatch =  welbatchManager.getCurrentBatch();
            student = studentManager.getByExamineeNo(examineeNo, welbatch);
        }else if(!StringUtils.isEmpty(IDcard)){
            Welbatch welbatch =  welbatchManager.getCurrentBatch();
            student = studentManager.getByIdCardNo(IDcard, welbatch);
        }else{
            return Action.SUCCESS;
        }

        if(student == null){
            regStatus="该生不存在";
            return Action.SUCCESS;
        }
        this.name = student.getName();
        this.province = student.getProvince();

        if(student.isReged()){
            regStatus="该生已经注册";
            return Action.SUCCESS;
        }

        studentManager.reg(student);

        regStatus="注册完成";
        return Action.SUCCESS;
    }


    /**
     * 
     * 准备报到统计数据
     * @since  2010-9-1
     * @author houbing.qian
     * @param userLevel 用户等级，全校用户：1，院系用户
     */
    private void perpareCountData(User detailUser){
        welbatch = welbatchManager.getCurrentBatch();
        if(detailUser instanceof SecurityUser){
            SecurityUser securityUser = (SecurityUser) detailUser;
            //判断用户级别
            if(StringUtils.isEmpty(securityUser.getCollegeCode())){//校级用户
                //统计全校报到数据
                //录取总数
                total = studentManager.countStudent(welbatch);
                //报到数
                Boolean isReged = true;
                regTotal = studentManager.countStudent(welbatch, isReged);

            }else{
                collegeName = securityUser.getCollegeName();
                total = studentManager.countStudent(securityUser.getCollegeCode(), welbatch);
                //报到数
                Boolean isReged = true;
                regTotal = studentManager.countStudent(securityUser.getCollegeCode(), welbatch, isReged);
            }

            //报到率
            regRate = MathUtils.bit((regTotal/(total*1F))*100,2)+"%";
        }
    }



    //-- 页面属性访问函数 --//
    /**
     * 注册状态
     */
    public String getRegStatus() {
        return this.regStatus;
    }

    public long getTotal()
    {
        return total;
    }

    public long getRegTotal()
    {
        return regTotal;
    }

    public String getRegRate()
    {
        return regRate;
    }

    public Welbatch getWelbatch()
    {
        return welbatch;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public String getName()
    {
        return name;
    }

    public String getProvince()
    {
        return province;
    }


}