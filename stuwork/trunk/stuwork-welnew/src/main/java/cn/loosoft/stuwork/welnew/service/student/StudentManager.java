package cn.loosoft.stuwork.welnew.service.student;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.common.util.date.DateUtils;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SchareaWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.common.Nation;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.util.ExcelUtils;
import cn.loosoft.stuwork.welnew.vo.StudentReportVO;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 
 * 学生的管理类.
 * 
 * @author shanru.wu
 * @author xiaodong.wei
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class StudentManager extends EntityManager<Student, Long>
{

    // private static Logger logger =
    // LoggerFactory.getLogger(StudentManager.class);
    private static Map<String, Integer> majorMap = Maps.newHashMap();

    private StudentDao                  studentDao;

    private WelbatchManager             welbatchManager;

    private SchareaWebService           schareaWebService;

    private SpecialtyWebService         specialtyWebService;

    private InstituteWebService         instituteWebService;

    @Override
    protected HibernateDao<Student, Long> getEntityDao()
    {
        return studentDao;
    }

    /**
     * 
     * 根据院系、专业、班级查询.
     * 
     * @since 2010-12-27
     * @author jie.yang
     * @param
     */
    public List<Student> getStudentList(String collegeCode, String majorCode,
            String classCode)
    {

        return studentDao.getStudentList(collegeCode, majorCode, classCode);
    }

    /**
     * 
     * 根据通知书编号、学号、考生号查询.
     * 
     * @since 2010-12-27
     * @author jie.yang
     * @param
     */
    public Student getStudent(String column, String value)
    {
        return studentDao.findUniqueBy(column, value);
    }

    /**
     * 
     * 批量删除批次.
     * 
     * @since 2010-8-23
     * @author Weixiaodong
     * @param ids
     */
    public void deleteStudents(List<Long> ids)
    {
        studentDao.deleteStudents(ids);
    }

    /**
     * 
     * 根据身份证号和批次取得新生
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @param examineeNo
     * @param batch
     * @return
     */
    public Student getByIdCardNo(String idCardNo, Welbatch batch)
    {
        return studentDao.getByIdCardNo(idCardNo, batch);
    }

    /**
     * 根据通知书编号取得学员
     * 
     * @since 2010-12-6
     * @author wsr
     * @param notcieId
     * @return
     */
    public Student getByNoticeId(String noticeId)
    {
        return studentDao.getByNoticeId(noticeId);
    }

    /**
     * 根据省份证号取得学员
     * 
     * @since 2010-12-6
     * @author wsr
     * @param IDcard
     * @return
     */
    public Student getByIDcard(String IDcard)
    {
        return studentDao.getByIDcard(IDcard);
    }

    public Student getByNoticeIdAndIDcard(String noticeId, String IDcard)
    {
        return studentDao.getByNoticeIdAndIDcard(noticeId, IDcard);
    }

    /**
     * 
     * 根据考生号和批次取得学员
     * 
     * @since 2010-8-23
     * @author houbing.qian
     * @param examineeNo
     * @param batch
     * @return
     */
    public Student getByExamineeNo(String examineeNo, Welbatch batch)
    {
        return studentDao.getByExamineeNo(examineeNo, batch);
    }

    public Student getByExamineeNo(String examineeNo)
    {
        return studentDao.getByExamineeNo(examineeNo);
    }

    /**
     * 分业提取数据 Description of this Method
     * 
     * @since 2010-8-24
     * @author wxd
     * @param page
     * @param student
     * @return
     */
    public Page<Student> getStudents(Page<Student> page, Student student)
    {
        if (null == page)
        {
            page = new Page<Student>(20);
            page.setPageNo(1);
        }
        page.setPageSize(20);
        return studentDao.getStudents(page, student);
    }

    /**
     * 
     * 从Excel表格中批量导入新生信息
     * 
     * @param file
     * @param dstPath
     * @param type
     * @return
     */
    public List<String> importexcel(File file, String dstPath, String type,
            List<Student> errorInfo, List<String> errorList)
    {
        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);
        List<String> keyList = new ArrayList<String>();

        SimpleDateFormat sdf = new SimpleDateFormat(
                "EEE MMM dd HH:mm:ss z yyyy", Locale.US);
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");

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
        Student student;
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
                    student = new Student();
                    String examineeNo = "";
                    String majorCode = "";// 专业代码
                    String collegeCode = ""; // 学院代码
                    String majorName = ""; // 专业
                    String collegeName = ""; // 学院
                    String birthday = "";
                    for (int j = 0; j < keyList.size(); j++)
                    {

                        String key = keyList.get(j);
                        if (null == key || StringUtils.isEmpty(key))
                        {
                            continue;
                        }

                        if (key.equals("学院"))
                        {
                            collegeName = data.get(key);
                            collegeName = collegeName.replaceAll(" ", " ")
                                    .trim();
                            student.setCollegeName(collegeName);// 学院
                            collegeCode = instituteWebService
                                    .getInstituteCode(student.getCollegeName());
                            student.setCollegeCode(collegeCode);
                            continue;
                        }

                        if (key.equals("专业"))
                        {

                            majorName = data.get(key);
                            majorName = majorName.replaceAll(" ", " ").trim();
                            student.setMajorName(majorName);// 专业
                            majorCode = specialtyWebService
                                    .getSpecialtyCode(student.getMajorName());
                            student.setMajorCode(majorCode);
                            continue;
                        }

                        if (key.equals("通知书编号"))
                        {
                            student.setNoticeId(data.get(key));
                            continue;
                        }

                        if (key.equals("学制"))
                        {
                            student.setLength(data.get(key));// 学制
                            continue;
                        }
                        if (key.equals("省份"))
                        {
                            student.setProvince(data.get(key)); // 省份
                        }

                        if (key.equals("考生号"))
                        {
                            examineeNo = data.get(key);
                            student.setExamineeNo(examineeNo);// 考生号
                            continue;
                        }
                        if (key.equals("姓名"))
                        {
                            student.setName(data.get(key));// 姓名
                            continue;
                        }
                        if (key.equals("性别"))
                        {
                            String sexdesc = data.get(key);
                            if ("男".equals(sexdesc))
                            {
                                student.setSex("m");// 性别
                            }
                            else
                                if ("女".equals(sexdesc))
                                {
                                    student.setSex("f");// 性别
                                }
                                else
                                {
                                    student.setSex(sexdesc);
                                }
                            continue;
                        }
                        if (key.equals("高考分数"))
                        {
                            String mark = data.get(key);
                            if (mark.indexOf(".") > -1)
                            {
                                mark = mark.substring(0, mark.indexOf("."));
                            }
                            student.setMark(Integer.parseInt(mark));
                            continue;
                        }

                        if (key.equals("联系地址"))
                        {
                            student.setAddress(data.get(key));
                            continue;
                        }
                        if (key.equals("联系电话"))
                        {
                            student.setTelephone(data.get(key));
                            continue;
                        }

                        if (key.equals("身份证号"))
                        {
                            student.setIDcard(data.get(key));// 身份证号
                            continue;
                        }

                        if (key.equals("生源地"))
                        {
                            student.setTestaddr(data.get(key));// 生源地
                            continue;

                        }
                        if (key.equals("校区"))
                        {
                            student.setSchareaName(data.get(keyList.get(12)));// 校区
                            if (StringUtils
                                    .isNotEmpty(student.getSchareaName()))
                            {
                                student.setSchareaCode(schareaWebService
                                        .getCode(student.getSchareaName()));
                            }
                            continue;

                        }
                        if (key.equals("出生年月"))
                        {
                            birthday = data.get(key);
                            if (null != birthday
                                    && StringUtils.isNotEmpty(birthday))
                            {
                                if (birthday.length() <= 8)
                                {
                                    continue;
                                }
                                if (birthday.contains("-"))
                                {
                                    student.setBirthday(DateUtils.getDate(
                                            birthday, "yyyy-MM-dd"));
                                }
                                else
                                {
                                    Date birthdayTemp = sdf.parse(birthday);
                                    String birthdayString = sd
                                            .format(birthdayTemp);
                                    student.setBirthday(DateUtils.getDate(
                                            birthdayString, "yyyy-MM-dd"));
                                }
                            }
                            else
                            {
                                student.setBirthday(null);
                            }

                            continue;
                        }
                        if (key.equals("民族"))
                        {
                            String nation = Nation.getValue(data.get(key));
                            student.setNation(nation); // 民族
                            continue;
                        }

                    }
                    student.setWelbatch(welbatchManager.getCurrentBatch());// 入学批次
                    student.setType(type);// 学生类别

                    // 判断学生是否已经导入
                    if (!studentDao.isPropertyUnique("examineeNo", examineeNo,
                            "")
                            || StringUtils.isEmpty(collegeCode)
                            || StringUtils.isEmpty(majorCode))
                    {
                        fail++;
                        if (i == 1)
                        {
                            failstr = failstr + i;
                        }
                        else
                        {
                            failstr = failstr + "," + i;
                        }
                    }
                    if (StringUtils.isNotEmpty(birthday))
                    {
                        if (birthday.length() <= 8)
                        {
                            errorInfo.add(student);
                            errorList.add("此生所填写的出生日期格式不正确,应为yyyy-MM-dd");
                            fail++;
                            if (i == 1)
                            {
                                failstr = failstr + i;
                            }
                            else
                            {
                                failstr = failstr + "," + i;
                            }
                            continue;
                        }
                    }

                    if (!studentDao.isPropertyUnique("examineeNo", examineeNo,
                            ""))
                    {
                        errorInfo.add(student);
                        errorList.add("该生已存在");

                        continue;
                    }
                    if (StringUtils.isEmpty(collegeCode))
                    {
                        errorInfo.add(student);
                        errorList.add("此生所填写的学院在系统中不存在,请预设");

                        continue;
                    }
                    if (StringUtils.isEmpty(majorCode))
                    {
                        errorInfo.add(student);
                        errorList.add("此生所填写的专业在系统中不存在,请预设");

                        continue;
                    }
                    studentDao.save(student);
                }
                catch (Exception e)
                {
                    System.out.println(e.getMessage());
                    fail++;
                    if (i == 1)
                    {
                        failstr = failstr + i;
                    }
                    else
                    {
                        failstr = failstr + "," + i;
                    }
                }
            }
        }
        if (failstr.length() > 0)
        {
            failstr.substring(1, failstr.length());
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        result.add(failstr);
        return result;
    }

    /**
     * 
     * 取得专业下的新生
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param majorCode
     * @return
     */
    public List<Student> getStudents(String majorCode, Welbatch welbatch,
            String type, String orderBy, String order)
    {
        return studentDao
                .getStudents(majorCode, welbatch, type, orderBy, order);
    }

    /**
     * 
     * 新生注册
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param student
     */
    public void reg(Student student)
    {

        student.setReged(true);
        student.setRegisterdate(DateUtils.getNowTimestamp());

        // 注册序号
        student.setOrderNum(this.getNumber(student.getMajorCode()));

        this.save(student);
    }

    /**
     * 
     * 取得最大学生注册序号
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param majorCode
     * @return
     */
    private int getNumber(String majorCode)
    {
        Integer num = majorMap.get(majorCode);
        if (num == null)
        {
            // load from db
            num = studentDao.getMaxNumber(majorCode);
        }
        num++;
        majorMap.put(majorCode, num);
        return num;
    }

    /**
     * 
     * 统计批次下的学生数量
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param welbatch
     * @return
     */
    public long countStudent(Welbatch welbatch)
    {
        String collegeCode = null;
        return this.countStudent(collegeCode, welbatch);
    }

    /**
     * 
     * 统计学院，批次的学生数量
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param collegeCode
     * @param welbatch
     * @return
     */
    public long countStudent(String collegeCode, Welbatch welbatch)
    {
        Boolean isReged = null;
        return this.countStudent(collegeCode, welbatch, isReged);
    }

    /**
     * 
     * 统计学院，批次,注册状态的学生数量
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param collegeCode
     * @param welbatch
     * @param isReged
     * @return
     */
    public long countStudent(String collegeCode, Welbatch welbatch,
            Boolean isReged)
    {
        return studentDao.countStudent(collegeCode, welbatch, isReged);
    }

    /**
     * 
     * 统计批次,注册状态的学生数量
     * 
     * @since 2010-9-1
     * @author houbing.qian
     * @param welbatch
     * @param isReged
     * @return
     */
    public long countStudent(Welbatch welbatch, Boolean isReged)
    {
        String collegeCode = null;
        return this.countStudent(collegeCode, welbatch, isReged);
    }

    /**
     * 
     * 查找批次，学院下审核通过的学生数量
     * 
     * @since 2010-9-1
     * @author zhengzheng.he
     * @param collegeCode
     * @param welbatch
     * @return
     */
    public long countChechPassStudent(String collegeCode, Welbatch welbatch)
    {
        return studentDao.countChechPassStudent(collegeCode, welbatch);
    }

    /**
     * 
     * 统计专业和类别下的学生数量
     * 
     * @since 2010-8-29
     * @author houbing.qian
     * @param collegeCode
     * @param type
     * @param welbatch
     * @return
     */
    public long countStudent(String collegeCode, String type, Welbatch welbatch)
    {
        return studentDao.countStudent(collegeCode, type, welbatch);
    }

    /**
     * 
     * 新生入学报到统计
     * 
     * @since 2011-9-1
     * @author fangyong
     * @param welbatch
     *            批次
     * @return
     */
    public List<StudentReportVO> getGroupStudentsByUnit(Welbatch welbatch)
    {
        if (welbatch != null)
        {
            List<StudentReportVO> reportVOs = Lists.newArrayList();

            List<Student> students = studentDao
                    .getGroupStudentsByCollege(welbatch);

            if (!students.isEmpty())
            {
                for (Student student : students)
                {
                    List<Student> studentsMajor = studentDao
                            .getGroupStudentsByMajor(welbatch, student
                                    .getCollegeName());

                    for (Student stuMajor : studentsMajor)
                    {
                        StudentReportVO reportVO = new StudentReportVO();
                        reportVO.setUnitName(stuMajor.getMajorName());
                        reportVO.setAlreadyReportCount(studentDao
                                .countStudentByMajorCode(stuMajor
                                        .getCollegeCode(), stuMajor
                                        .getMajorCode(), welbatch, true));
                        reportVO.setMustReportCount(studentDao
                                .countStudentByMajorCode(stuMajor
                                        .getCollegeCode(), stuMajor
                                        .getMajorCode(), welbatch, null));
                        if (reportVO.getMustReportCount() > 0)
                        {
                            reportVO.setNoReportCount(Math.round((reportVO
                                    .getAlreadyReportCount() / (reportVO
                                    .getMustReportCount() * 1.0F)) * 1000)
                                    / 10.0 + "%");
                        }
                        reportVOs.add(reportVO);
                    }

                    StudentReportVO reportVO = new StudentReportVO();
                    reportVO.setUnitName(student.getCollegeName());
                    reportVO.setAlreadyReportCount(studentDao.countStudent(
                            student.getCollegeCode(), welbatch, true));
                    reportVO.setMustReportCount(studentDao.countStudent(student
                            .getCollegeCode(), welbatch, null));

                    if (reportVO.getMustReportCount() > 0)
                    {
                        reportVO.setNoReportCount(Math.round((reportVO
                                .getAlreadyReportCount() / (reportVO
                                .getMustReportCount() * 1.0F)) * 1000)
                                / 10.0 + "%");
                    }
                    reportVO.setFlag(true);
                    reportVOs.add(reportVO);
                }
            }
            return reportVOs;
        }
        return null;
    }

    @Autowired
    public void setStudentDao(StudentDao studentDao)
    {
        this.studentDao = studentDao;
    }

    @Autowired
    public void setSchareaWebService(SchareaWebService schareaWebService)
    {
        this.schareaWebService = schareaWebService;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService)
    {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService)
    {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

}
