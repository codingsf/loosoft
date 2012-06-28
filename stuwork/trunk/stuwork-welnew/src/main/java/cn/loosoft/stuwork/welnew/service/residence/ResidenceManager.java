package cn.loosoft.stuwork.welnew.service.residence;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.residence.ResidenceDao;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.residence.Residence;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.util.ExcelUtils;

/**
 * 
 * 户籍登记的管理类.
 * 
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class ResidenceManager extends EntityManager<Residence, Long>
{

    // private static Logger logger =
    // LoggerFactory.getLogger(SchareaManager.class);
    @Autowired
    private ResidenceDao residenceDao;

    private StudentDao   studentDao;

    @Autowired
    public void setStudentDao(StudentDao studentDao)
    {
        this.studentDao = studentDao;
    }

    @Override
    protected HibernateDao<Residence, Long> getEntityDao()
    {
        return residenceDao;
    }

    /**
     * 
     * 批量删除户籍信息.
     * 
     * @since 2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteResidences(List<Long> ids)
    {
        residenceDao.deleteResidences(ids);
    }

    /**
     * 
     * Description of this Method
     * 
     * @since 2010-8-25
     * @author wxd
     * @param file
     * @param dstPath
     * @return
     */
    public List<String> importexcel(File file, String dstPath)
    {
        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);

        List<String> keyList = new ArrayList<String>();
        keyList.add("majorName");
        keyList.add("className");
        keyList.add("name");
        keyList.add("idCardNo");
        keyList.add("migrateNo");
        keyList.add("origAddress");
        keyList.add("curAddress");
        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        if (filetype.equalsIgnoreCase("xls"))
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        Residence residence;
        List<String> result = new ArrayList<String>();
        int total = 0;
        int fail = 0;
        String failstr = "";
        if (null != datas && datas.size() > 1)
        {
            total = datas.size() - 1;
            for (int i = 1; i < datas.size(); i++)
            {
                try
                {
                    Map<String, String> data = datas.get(i);
                    residence = new Residence();
                    residence.setMajorName(data.get(keyList.get(0)));
                    residence.setClassName(data.get(keyList.get(1)));
                    Student student = new Student();
                    student = studentDao.getByIdCardNo(
                            data.get(keyList.get(3)), data.get(keyList.get(2)));
                    residence.setStudent(student);
                    residence.setMigrateNo(data.get(keyList.get(4)));
                    residence.setOrigAddress(data.get(keyList.get(5)));
                    residence.setCurAddress(data.get(keyList.get(6)));
                    residenceDao.save(residence);
                }
                catch (Exception e)
                {
                    fail++;
                    if (i == 1)
                        failstr = failstr + i;
                    else
                        failstr = failstr + "笔," + i;
                }
            }
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        result.add(failstr);
        return result;
    }
}
