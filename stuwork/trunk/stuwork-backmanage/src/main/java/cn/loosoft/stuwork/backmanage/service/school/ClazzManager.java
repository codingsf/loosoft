package cn.loosoft.stuwork.backmanage.service.school;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.backmanage.dao.school.ClazzDao;
import cn.loosoft.stuwork.backmanage.dao.school.SpecialtyDao;
import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.backmanage.util.ExcelUtils;

/**
 * 班级实体的管理类.
 * 
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class ClazzManager extends EntityManager<Clazz, Long>
{

    // private static Logger logger =
    // LoggerFactory.getLogger(SchareaManager.class);

    @Autowired
    private ClazzDao     clazzDao;

    @Autowired
    private SpecialtyDao specialtyDao;

    @Override
    protected HibernateDao<Clazz, Long> getEntityDao()
    {
        return clazzDao;
    }

    /**
     * 
     * 批量删除系
     * 
     * @since 2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteClazzs(List<Long> ids)
    {
        clazzDao.deleteClazzs(ids);
    }

    /**
     * 
     * 根据专业，入学年份和入学季节
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @param specialtyCode
     * @param year
     * @param season
     * @return
     */
    public List<Clazz> getClazzsBySpecialty(String specialtyCode, String year,
            String season)
    {
        String type = null;
        Specialty specialty = specialtyDao.getByCode(specialtyCode);
        return clazzDao.getClazzsBySpecialty(specialty, type, year, season);
    }

    /**
     * 
     * 取得班级列表
     * 
     * @since 2010-9-2
     * @author houbing.qian
     * @param specialtyCode
     *            专业代码
     * @param type
     *            班级学生类别
     * @param year
     *            入学年份
     * @param season
     *            入学季节
     * @return
     */
    public List<Clazz> getClazzsBySpecialty(String specialtyCode, String type,
            String year, String season)
    {
        Specialty specialty = specialtyDao.getByCode(specialtyCode);
        return clazzDao.getClazzsBySpecialty(specialty, type, year, season);
    }

    /**
     * 根据班级名称，入学年份和季节取得班级代码
     * 
     * @since 2010-8-22
     * @author houbing.qian
     * @param name
     * @param year
     * @param season
     * @return
     */
    public Clazz getClazzByName(String name, String type, String year,
            String season)
    {
        return clazzDao.getClazzByName(name, type, year, season);
    }

    /**
     * 
     * 根据班级代码取得班级
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param code
     *            班级代码
     * @return
     */
    public Clazz getByCode(String code)
    {
        return clazzDao.findUniqueBy("code", code);
    }

    /**
     * 
     * 从Excel表格中批量导入档案入库信息
     * 
     * @param file
     * @param dstPath
     * @param type
     * @author shanru.wu
     * @since 2010-12-18
     * @return
     */
    public List<String> importArchives(File file, String dstPath)
    {
        // File dstFile = new File(dstPath);
        // ExcelUtils.copy(file, dstFile);
        // List<String> keyList = new ArrayList<String>();
        //
        // String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);
        //
        // List<Map<String, String>> datas = null;
        // if (filetype.equalsIgnoreCase("xlsx"))
        // {
        // keyList = ExcelUtils.excelFirstRowColumn(file, false);
        // datas = ExcelUtils.excel2List(keyList, dstFile, false);
        // }
        // if (filetype.equalsIgnoreCase("xls"))
        // {
        // keyList = ExcelUtils.excelFirstRowColumn(file, true);
        // datas = ExcelUtils.excel2List(keyList, dstFile, true);
        // }
        // Archives archives;
        // List<String> result = new ArrayList<String>();
        // int total = 0;
        // int fail = 0;
        // if (null != datas && datas.size() > 1)
        // {
        // total = datas.size() - 1;
        // for (int i = 1; i < datas.size(); i++)
        // {
        // try
        // {
        // Map<String, String> data = datas.get(i);
        // archives = new Archives();
        // String stuId = ""; // 学号
        // String storeInfo = ""; // 档案信息
        // String name = "";// 姓名
        // for (int j = 0; j < keyList.size(); j++)
        // {
        // String temp = keyList.get(j);
        // if (temp.equals("学号"))
        // {
        // stuId = data.get(temp);
        // archives.setStuId(stuId);
        // continue;
        // }
        // if (temp.equals("姓名"))
        // {
        // name = data.get(temp);
        // archives.setName(name);
        // continue;
        // }
        // if (temp.equals("考生号"))
        // {
        // archives.setExamineeNo(data.get(temp));
        // continue;
        // }
        // if (temp.equals("入库理由"))
        // {
        // archives.setReason(data.get(temp));
        // continue;
        // }
        // if (temp.equals("档案信息"))
        // {
        // archives.setArchivesInfo(data.get(temp)); // 档案信息
        // continue;
        // }
        // if (temp.equals("库位信息"))
        // {
        // storeInfo = data.get(temp);
        // archives.setStoreInfo(storeInfo); // 库位信息
        // continue;
        // }
        // if (temp.equals("移交人"))
        // {
        // archives.setTransfer(data.get(temp));
        // }
        // if (temp.equals("接收人"))
        // {
        // archives.setRecipient(data.get(temp));
        // }
        //
        // }
        // // 判断学生档案是否已存在
        // if (archivesDao.isPropertyUnique("stuId", stuId, ""))
        // {
        // String tempName = studentWebService
        // .getNameByStuId(stuId);
        // if (null != tempName
        // && StringUtils.isNotEmpty(tempName))
        // { // 学生学号和姓名对应
        // if (tempName.equals(name))
        // {
        // // 判断学生档案信息的格式是否正确
        // if (StringUtils.isNotEmpty(storeInfo)
        // && storeInfo.split("-").length != 4)
        // {
        // fail++;
        // continue;
        // }
        //
        // }
        // else
        // {
        // fail++;
        // continue;
        // }
        //
        // }
        // else
        // {
        // fail++;
        // continue;
        // }
        //
        // }
        // else
        // {
        // fail++;
        // continue;
        // }
        // archives.setStatus("在库");
        // archives.setStorageTime(new Date()); // 记录入库时间
        // archivesDao.save(archives);
        // }
        // catch (Exception e)
        // {
        // fail++;
        // }
        // }
        // }
        // result.add(String.valueOf(total));
        // result.add(String.valueOf(fail));
        // return result;
        return null;
    }

    /**
     * 
     * 导入入库信息的时候判断是否能全部成功
     * 
     * @since 2011-1-18
     * @author shanru.wu
     * @param file
     * @param dstPath
     * @param succesStuNos
     *            (记录能正确导入的学生学号)
     * @param errorStuNos
     *            (记录错误导入的学生学号)
     * @param errorStr
     *            (记录错误原因)
     * @param notExistInfo
     *            (记录导入不存在的学生信息)
     * @return
     */
    public void judge(File file, String dstPath, List<String[]> successClazz,
            List<String[]> errorClazz, String flag)
    {
        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);
        List<String> keyList = new ArrayList<String>();

        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, false);
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }
        if (filetype.equalsIgnoreCase("xls"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, true);
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }

        if (null != datas && datas.size() > 1)
        {
            for (int i = 1; i < datas.size(); i++)
            {
                String year = ""; // 年份
                String reaseon = "";// 季节
                String specialtyCode = "";// 专业编号
                String clazzName = "";// 班级名称
                try
                {
                    Map<String, String> data = datas.get(i);
                    for (int j = 0; j < keyList.size(); j++)
                    {
                        String key = keyList.get(j);
                        if (key.equals("入学年份"))
                        {
                            year = data.get(key);
                        }
                        if (key.equals("季节"))
                        {
                            reaseon = data.get(key);
                        }
                        if (key.equals("专业编号"))
                        {
                            specialtyCode = data.get(key);
                        }
                        if (key.equals("班级名称"))
                        {
                            clazzName = data.get(key);
                        }
                    }

                    // 非空判断
                    if (StringUtils.isBlank(year)
                            || StringUtils.isBlank(reaseon)
                            || StringUtils.isBlank(specialtyCode)
                            || StringUtils.isBlank(clazzName))
                    {
                        errorClazz.add(putArrErrorClazz(year, reaseon,
                                specialtyCode, clazzName, "导入信息不完整"));
                        continue;
                    }

                    // 判断年份格式是否正确
                    String datePattern = "\\d{4}";
                    Pattern pattern = Pattern.compile(datePattern);
                    Matcher match = pattern.matcher(year);
                    if (!match.matches())
                    {
                        errorClazz.add(putArrErrorClazz(year, reaseon,
                                specialtyCode, clazzName, "年份输入错误"));
                        continue;
                    }

                    // 判断季节格式是否正确
                    if (!"春季".equals(reaseon.trim())
                            && !"秋季".equals(reaseon.trim()))
                    {
                        errorClazz.add(putArrErrorClazz(year, reaseon,
                                specialtyCode, clazzName, "季节不正确"));
                        continue;
                    }

                    // 判断专业编号是否存在
                    if (null == specialtyDao.getByCode(specialtyCode))
                    {
                        errorClazz.add(putArrErrorClazz(year, reaseon,
                                specialtyCode, clazzName, "专业编号输入错误"));
                        continue;
                    }

                    // 判断班级名称是否重复
                    if (null != clazzDao
                            .getClazzByName(specialtyDao
                                    .getByCode(specialtyCode), clazzName, year,
                                    reaseon))
                    {
                        errorClazz.add(putArrErrorClazz(year, reaseon,
                                specialtyCode, clazzName, "班级名称重复"));
                        continue;
                    }

                    successClazz.add(putArrErrorClazz(year, reaseon,
                            specialtyCode, clazzName, ""));

                    if (StringUtils.isNotBlank(flag))
                    {
                        Clazz entity = new Clazz();
                        entity.setSpecialty(specialtyDao
                                .getByCode(specialtyCode));
                        entity.setSeason(reaseon);
                        entity.setYear(year);
                        entity.setName(clazzName);
                        List<Clazz> list = this.getClazzsBySpecialty(
                                specialtyCode, null, year, reaseon);
                        // 年度
                        Calendar cal = Calendar.getInstance();
                        int years = cal.get(Calendar.YEAR);

                        // 班级代码规则 ：年度+专业代码+(最大序号+1）
                        if (null == list || list.size() < 1)
                        {
                            entity.setCode(years + specialtyCode + "01");
                        }
                        else
                        {
                            Clazz clazz = list.get(list.size() - 1);
                            String sub = clazz.getCode().substring(
                                    clazz.getCode().length() - 2,
                                    clazz.getCode().length());
                            int num = Integer.parseInt(sub) + 1;
                            String cont = num < 10 ? "0" + num : num + "";
                            entity.setCode(years + specialtyCode + (cont));
                        }
                        clazzDao.save(entity);
                    }
                }
                catch (Exception e)
                {
                    // errorClazz.add(putArrErrorClazz(year, reaseon,
                    // specialtyCode, clazzName, "异常错误"));
                }
            }
        }
    }

    private String[] putArrErrorClazz(String year, String reason,
            String specialtyCode, String clazzName, String cause)
    {
        String[] arrErrorClazz = new String[5];
        arrErrorClazz[0] = year;
        arrErrorClazz[1] = reason;
        arrErrorClazz[2] = specialtyCode;
        arrErrorClazz[3] = clazzName;
        arrErrorClazz[4] = cause;

        return arrErrorClazz;
    }
}
