package cn.loosoft.stuwork.welnew.service.clazz;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.common.lib.util.file.FileUtils;
import cn.loosoft.common.util.date.DateUtils;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.welnew.dao.clazz.MajorClazzInfoDao;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.clazz.MajorClazzInfo;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.util.ExcelUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 
 * 专业分班信息的管理类.
 * 
 * @author shanru.wu
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class MajorClazzInfoManager extends EntityManager<MajorClazzInfo, Long>
{

    public static String logRelativePath ="log";
    private static Map<String,Integer> claxxNumMap = null;

    // private static Logger logger =
    // LoggerFactory.getLogger(SchareaManager.class);
    private MajorClazzInfoDao   majorClazzInfoDao;

    private SpecialtyWebService specialtyWebService;

    private StudentManager      studentManager;

    private WelbatchManager     welbatchManager;

    private ClazzWebService     clazzWebService;

    private StudentDao          studentDao;

    /**
     * 取得批次的分班信息
     * 
     * @since  2011-8-31
     * @author houbing.qian
     * @param filters
     * @return
     */
    public List<MajorClazzInfo> getAll(List<PropertyFilter> filters){
        return majorClazzInfoDao.find(filters);
    }
    /**
     * 
     * 取得专业分班信息
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param welbatch
     *            批次
     * @return
     */
    public List<MajorClazzInfo> handleMajorClazzInfos(List<MajorClazzInfo> majorClazzInfos,Welbatch welbatch)
    {
        if (majorClazzInfos.isEmpty())
        {
            // insert initialy data from basedata service
            List<SpecialtyDTO> specialtyDTOs = specialtyWebService
            .getSpecialtys();
            MajorClazzInfo majorClazzInfo = null;
            for (SpecialtyDTO specialtyDTO : specialtyDTOs)
            {
                majorClazzInfo = new MajorClazzInfo();
                majorClazzInfo.setCollegeCode(specialtyDTO.getCollegeCode());
                majorClazzInfo.setCollegeName(specialtyDTO.getCollegeName());
                majorClazzInfo.setDepartCode(specialtyDTO.getDepartCode());
                majorClazzInfo.setDepartName(specialtyDTO.getDepartName());
                majorClazzInfo.setMajorCode(specialtyDTO.getCode());
                majorClazzInfo.setMajorName(specialtyDTO.getName());
                majorClazzInfo.setWelbatch(welbatch);
                majorClazzInfo.setType(StudentType.DUIKOU);
                majorClazzInfoDao.save(majorClazzInfo);
                majorClazzInfos.add(majorClazzInfo);

                MajorClazzInfo majorClazzInfo2 = new MajorClazzInfo(); 
                majorClazzInfo2.setCollegeCode(specialtyDTO.getCollegeCode());
                majorClazzInfo2.setCollegeName(specialtyDTO.getCollegeName());
                majorClazzInfo2.setDepartCode(specialtyDTO.getDepartCode());
                majorClazzInfo2.setDepartName(specialtyDTO.getDepartName());
                majorClazzInfo2.setMajorCode(specialtyDTO.getCode());
                majorClazzInfo2.setMajorName(specialtyDTO.getName());
                majorClazzInfo2.setWelbatch(welbatch);
                majorClazzInfo2.setType(StudentType.TONGZHAO);
                majorClazzInfoDao.save(majorClazzInfo2);
                majorClazzInfos.add(majorClazzInfo2);

                MajorClazzInfo majorClazzInfo3 = new MajorClazzInfo(); 
                majorClazzInfo3.setCollegeCode(specialtyDTO.getCollegeCode());
                majorClazzInfo3.setCollegeName(specialtyDTO.getCollegeName());
                majorClazzInfo3.setDepartCode(specialtyDTO.getDepartCode());
                majorClazzInfo3.setDepartName(specialtyDTO.getDepartName());
                majorClazzInfo3.setMajorCode(specialtyDTO.getCode());
                majorClazzInfo3.setMajorName(specialtyDTO.getName());
                majorClazzInfo3.setWelbatch(welbatch);
                majorClazzInfo3.setType(StudentType.ZHUANSHENBEN);
                majorClazzInfoDao.save(majorClazzInfo3);
                majorClazzInfos.add(majorClazzInfo3);
            }
        }
        return majorClazzInfos;
    }

    /**
     * 
     * 对某个专业进行分班
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @author shanru.wu
     * @param majorCode
     * @param personNum
     */
    public void majorAssign(MajorClazzInfo majorClazzInfo, int personNum)
    {
        //打开分班序号map
        claxxNumMap = Maps.newHashMap();
        if (personNum == 0)
        {
            return;
        }
        //取得专业代码
        String majorCode = majorClazzInfo.getMajorCode();
        // 取得当前批次
        Welbatch welbatch = welbatchManager.getCurrentBatch();

        // 先按照分数从高到低取出专业所有学生
        List<Student> students = studentManager.getStudents(majorCode,
                welbatch,majorClazzInfo.getType(), "mark", Page.DESC);
        if (students.isEmpty())
        {
            return;
        }
        // 按照性别进行人员分组
        List<Student> maleStudents = Lists.newArrayList();
        List<Student> femaleStudents = Lists.newArrayList();
        for (Student student : students)
        {
            if ("m".equalsIgnoreCase(student.getSex()))
            {
                maleStudents.add(student);
            }
            else
            {
                femaleStudents.add(student);
            }
        }

        // 计算分班数量
        int classNum = students.size()%personNum>0?students.size() / personNum + 1:students.size() / personNum ;
        Map<Integer, List<Student>> classMap = Maps.newHashMap();
        List<ClazzDTO> clazzs = Lists.newArrayList();
        for (int i = 1; i <= classNum; i++)
        {
            classMap.put(i, new ArrayList<Student>());

            ClazzDTO clazzDTO = new ClazzDTO();
            clazzDTO.setCode(generateClazzCode(majorCode,majorClazzInfo.getType()));
            clazzDTO.setName(generateClazzName(majorCode, i));
            clazzDTO.setMajorCode(majorCode);
            clazzDTO.setYear(welbatch.getYear());
            clazzDTO.setSeason(welbatch.getSeason());
            clazzDTO.setType(majorClazzInfo.getType());
            clazzs.add(clazzDTO);
        }

        putStudentToClassMap(maleStudents, classMap, classNum);

        putStudentToClassMap(femaleStudents, classMap, classNum);

        // 持久化班级
        clazzWebService.saveClazzs(clazzs);

        // 持久化学生
        for (Integer num : classMap.keySet())
        {
            List<Student> list = classMap.get(num);
            ClazzDTO curClazz = clazzs.get(num - 1);
            for (Student student : list)
            {
                student.setClassCode(curClazz.getCode());
                student.setClassName(curClazz.getName());
                studentManager.save(student);
            }
        }

        // 修改专业分班信息
        majorClazzInfo.setAssignDate(DateUtils.getNowTimestamp());
        majorClazzInfo.setAssigned(true);
        majorClazzInfoDao.save(majorClazzInfo);

        // 分班结束-------
        //关闭分班序号map
        claxxNumMap = null;
    }

    /**
     * 
     * 生成班级代码 系统生成用户不可修改<br/>
     * 规则：年月+专业代码+序号（两位）
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param majorCode
     * @param num
     * @return
     */
    private String generateClazzCode(String majorCode,String type)
    {
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        String season = welbatch.getSeason();
        if("秋季".equals(season)){
            season = "02";
        }else{
            season = "01";
        }
        int num = generateClazzNum(majorCode);
        String newnum = String.valueOf(num + 100).substring(1);
        return getYear()+ season + majorCode +type+ newnum;
    }

    /**
     * 
     * 给每次分班进行编号
     * @since  2010-9-1
     * @author houbing.qian
     * @author shanru.wu
     * @param majorCode
     * @return
     */
    private int generateClazzNum(String majorCode){
        Integer num =null;
        if(claxxNumMap!=null)
        {
            num = claxxNumMap.get(majorCode);
        }
        else
        {
            claxxNumMap=new HashMap<String, Integer>();
        }
        if(num == null){
            num = 1;
        }else{
            num++;
        }
        claxxNumMap.put(majorCode,num);
        return num;
    }

    public static String getYearYm(){ 
        Calendar ca = Calendar.getInstance(); 
        ca.setTime(new java.util.Date()); 
        String year = ""+ca.get(Calendar.YEAR)+(ca.get(Calendar.MONTH)+1); 
        return year; 
    } 

    public static String getYear(){ 
        Calendar ca = Calendar.getInstance(); 
        ca.setTime(new java.util.Date()); 
        String year = ""+ca.get(Calendar.YEAR); 
        return year; 
    } 

    /**
     * 
     * 产生班级名称 规则：年份+“专业名称”+"序号"+“班” 如：
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param majorCode
     * @param num
     * @return
     */
    private String generateClazzName(String majorCode, int num)
    {
        String majorName = null;
        try
        {
            majorName = specialtyWebService.getSpecialtyName(majorCode);
        }
        catch (Exception e)
        {
            // TODO: handle exception
            return "";
        }
        return getYear() + majorName + num + "班";
    }

    /**
     * 
     * Description of this Method
     * 
     * @since 2010-8-25
     * @author houbing.qian
     * @param students
     * @param classMap
     * @param classNum
     */
    private void putStudentToClassMap(List<Student> students,
            Map<Integer, List<Student>> classMap, int classNum)
    {
        // 从高分开始男生 班
        // 当前班级下班
        int currentIndex = 1;
        boolean isForward = true;// 赋值方向
        for (Student tempStudent : students)
        {
            classMap.get(currentIndex).add(tempStudent);
            if (isForward)
            {
                currentIndex++;
            }
            else
            {
                currentIndex--;
            }
            System.out.println(currentIndex);
            if (currentIndex == classNum + 1)
            {
                isForward = !isForward;
                currentIndex = currentIndex - 1;
            }
            else
                if (currentIndex == 0)
                {
                    isForward = !isForward;
                    currentIndex = currentIndex + 1;
                }
        }
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
    public List<String> importexcel(File file, String dstPath,String filename,boolean isAuto)
    {
        File dstFile = new File(dstPath+"\\"+filename);
        ExcelUtils.copy(file, dstFile);

        List<String> keyList = new ArrayList<String>();
        keyList.add("考生号");
        keyList.add("姓名");
        keyList.add("班级名称");
        String filetype = filename.substring(filename.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }else if (filetype.equalsIgnoreCase("xls"))
        {
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }
        Student student;
        List<String> result = new ArrayList<String>();
        int total = 0;
        int fail = 0;
        String failstr = "";
        Collection<String> logs = Lists.newArrayList();
        if (null != datas && datas.size() > 1)
        {
            total = datas.size() - 1;
            for (int i = 1; i < datas.size(); i++)
            {
                try
                {
                    Map<String, String> data = datas.get(i);
                    student = studentDao.getByExamineeNo(data.get(keyList
                            .get(0)), data.get(keyList.get(1)));
                    student.setClassName(data.get(keyList.get(2)));
                    //取得班级代码
                    String classCode = clazzWebService.getClazzCodeByName(student.getClassName(), student.getType(), student.getWelbatch().getYear(), student.getWelbatch().getSeason());
                    if(StringUtils.isNotEmpty(classCode)){
                        student.setClassCode(classCode);
                        studentDao.save(student);
                    }else{
                        //创建保存班级
                        if(isAuto){
                            ClazzDTO clazzDTO = new ClazzDTO();
                            clazzDTO.setCode(this.generateClazzCode(student.getMajorCode(), student.getType()));
                            clazzDTO.setName(student.getClassName());
                            clazzDTO.setMajorCode(student.getMajorCode());
                            clazzDTO.setType(student.getType());
                            clazzDTO.setSeason(student.getWelbatch().getSeason());
                            clazzDTO.setYear(student.getWelbatch().getYear());
                            List<ClazzDTO> list = new ArrayList<ClazzDTO>();
                            list.add(clazzDTO);
                            clazzWebService.saveClazzs(list);
                            student.setClassCode(clazzDTO.getCode());
                        }else{
                            //严格验证班级名称和后台设置一致
                            //failstr="\""+student.getClassName()+"\"班级名称不正确";
                            logs.add(i+"行：\""+student.getClassName()+"\"班级名称不正确");
                            fail++;
                            if (i == 1)
                            {
                                failstr = i+"行";
                            }
                            else
                            {
                                failstr = failstr+ (failstr.isEmpty()?"":",") + i+"行";
                            }
                        }
                    }
                }
                catch (Exception e)
                {
                    e.printStackTrace();
                    logs.add(i+"行："+e.getMessage());
                    fail++;
                    if (i == 1)
                    {
                        failstr = i+"行";
                    }
                    else
                    {
                        failstr = failstr+ (failstr.isEmpty()?"":",") + i+"行";
                    }
                }
            }
        }


        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        result.add(failstr);
        result.add(writeImportLog(dstPath,logs));
        return result;
    }

    /**
     * 写导入错误日志
     * @since  2011-8-31
     * @author houbing.qian
     * @param logs
     */
    private String writeImportLog(String path, Collection<String> logList){
        String logFileName= FileUtils.generateFileName("log", "txt");
        File file = new File(path+ "\\"+logRelativePath);
        if(!file.exists())
        {
            file.mkdirs();
        }
        try
        {
            org.apache.commons.io.FileUtils.writeLines(new File(path+File.separator+logRelativePath+File.separator+logFileName), "utf-8",logList);
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return logFileName;
    }
    @Override
    protected HibernateDao<MajorClazzInfo, Long> getEntityDao()
    {
        return majorClazzInfoDao;
    }

    @Autowired
    public void setMajorClazzInfoDao(MajorClazzInfoDao majorClazzInfoDao) {
        this.majorClazzInfoDao = majorClazzInfoDao;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService) {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager) {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager) {
        this.welbatchManager = welbatchManager;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService) {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setStudentDao(StudentDao studentDao)
    {
        this.studentDao = studentDao;
    }
}
