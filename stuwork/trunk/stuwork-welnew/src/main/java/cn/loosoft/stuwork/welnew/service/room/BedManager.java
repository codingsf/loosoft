package cn.loosoft.stuwork.welnew.service.room;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.common.StudentType;
import cn.loosoft.stuwork.welnew.dao.room.BedDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.room.Bed;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.util.ExcelUtils;

/**
 * 
 * 床位的管理类.
 * 
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class BedManager extends EntityManager<Bed, Long>
{

    // private static Logger logger =
    // LoggerFactory.getLogger(SchareaManager.class);
    private BedDao bedDao;

    private InstituteWebService instituteWebService;

    private SpecialtyWebService specialtyWebService;

    private ClazzWebService clazzWebService;

    private WelbatchManager welbatchManager;

    @Override
    protected HibernateDao<Bed, Long> getEntityDao()
    {
        return bedDao;
    }

    /**
     * 
     * 批量删除户籍信息.
     * 
     * @since 2010-8-20
     * @author houbing.qian
     * @param ids
     */
    public void deleteBeds(List<Long> ids)
    {
        bedDao.deleteBeds(ids);
    }

    /**
     * 
     * 获取所有的床位总数.
     * @since  2010-12-2
     * @author shanru.wu
     * @return
     */
    public long countBed(String collegeCode,String majorCode,String classCode){
        return bedDao.countBed(collegeCode,majorCode,classCode);
    }

    /**
     * 
     * 取得未分床位总数
     * @since  2010-12-2
     * @author shanru.wu
     * @return
     */
    public long unassignBed(String collegeCode,String majorCode,String classCode,int isAssigned){
        return bedDao.unassignBed(collegeCode, majorCode, classCode, isAssigned);
    }

    /**
     * 
     * 取得床位列表
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @param isAssigned
     * @return
     */
    public List<Bed> getBeds(String collegeCode, String majorCode,
            String classCode, int isAssigned)
            {
        return bedDao.getBeds(collegeCode, majorCode, classCode, isAssigned);
            }

    /**
     * 
     * 取得班级的未分配床位<br>
     * 按照院系，专业，班级和床位的升序排列的
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @param collegeCode
     * @param majorCode
     * @param classCode
     * @return
     */
    public Bed getUnassignedBed(String collegeCode, String majorCode,
            String classCode)
    {
        return bedDao.getUnassignedBed(collegeCode, majorCode, classCode);
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
        keyList.add("学院");
        keyList.add("专业");
        keyList.add("班级");
        keyList.add("公寓楼");
        keyList.add("楼层");
        keyList.add("宿舍");
        keyList.add("床位");
        keyList.add("性别"); 

        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }
        if (filetype.equalsIgnoreCase("xls"))
        {
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }
        Bed bed;
        Welbatch welbatch = welbatchManager.getCurrentBatch();
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
                    bed = new Bed();
                    String collegeName = data.get(keyList.get(0));
                    bed.setCollegeName(collegeName);
                    bed.setCollegeCode(instituteWebService.getInstituteCode(collegeName));

                    String majorName = data.get(keyList.get(1));
                    bed.setMajorName(majorName);
                    bed.setMajorCode(specialtyWebService.getSpecialtyCode(majorName));

                    String className = data.get(keyList.get(2));
                    String classCode = clazzWebService.getClazzCodeByName(className, StudentType.TONGZHAO, welbatch.getYear(), welbatch.getSeason());
                    if(StringUtils.isEmpty(classCode)){
                        classCode = clazzWebService.getClazzCodeByName(className, StudentType.DUIKOU, welbatch.getYear(), welbatch.getSeason());
                    }
                    bed.setClassName(className);
                    bed.setClassCode(classCode);

                    String building = data.get(keyList.get(3));
                    bed.setBuilding(building);
                    bed.setFloor(data.get(keyList.get(4)));
                    String room = data.get(keyList.get(5));
                    try{
                        room = StringUtils.substringBefore(room, ".");
                    }catch (Exception e) {
                        // TODO: handle exception
                        logger.debug("room 格式化错误。");
                    }
                    bed.setRoom(room);
                    String bedNo = data.get(keyList.get(6));
                    try{
                        bedNo =StringUtils.substringBefore(bedNo, ".");
                    }catch (Exception e) {
                        // TODO: handle exception
                        logger.debug("room 格式化错误。");
                    }
                    bed.setBedNo(bedNo);
                    bed.setSex("男".equals(data.get(keyList.get(7)))?"m":"f");
                    bed.setWelbatch(welbatch);

                    //判断床位是否已经导入
                    if(bedDao.exist(building, room, bedNo)){
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
                    bedDao.save(bed);
                }
                catch (Exception e)
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
            }
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        result.add(failstr);
        return result;
    }

    @Autowired
    public void setBedDao(BedDao bedDao) {
        this.bedDao = bedDao;
    }

    @Autowired
    public void setInstituteWebService(InstituteWebService instituteWebService) {
        this.instituteWebService = instituteWebService;
    }

    @Autowired
    public void setSpecialtyWebService(SpecialtyWebService specialtyWebService) {
        this.specialtyWebService = specialtyWebService;
    }

    @Autowired
    public void setClazzWebService(ClazzWebService clazzWebService) {
        this.clazzWebService = clazzWebService;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager) {
        this.welbatchManager = welbatchManager;
    }
}
