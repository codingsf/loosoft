package cn.loosoft.stuwork.leave.util;


/**
 * 
 * 在内存进行分页的通用类
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-26
 */

public class Pages
{
    private String tempPageNo = "1";

    private int    pageNo     = (tempPageNo == null || tempPageNo == "") ? 1
                                      : Integer.parseInt(tempPageNo); // 页数(默认为第一页)

    private int    pageSize   = 20;

    /**
     * @param pageSize
     *            the pageSize to set
     */
    public void setPageSize(int pageSize)
    {
        this.pageSize = pageSize;
    }

    private int totalCount; // 总条数

    /**
     * 
     * 取得总记录数, 默认值为-1.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public int getTotalCount()
    {

        return totalCount;
    }

    public String getTempPageNo()
    {
        return tempPageNo;
    }

    public void setTotalCount(int totalCount)
    {
        this.totalCount = totalCount;
    }

    /**
     * 
     * 是否还有下一页.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public boolean isHasNext()
    {
        return (pageNo + 1 <= getTotalPages());
    }

    /**
     * 
     * 取得下页的页号, 序号从1开始. 当前页为尾页时仍返回尾页序号.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public int getNextPage()
    {
        if (isHasNext())
        {
            return pageNo + 1;
        }
        else
        {
            return pageNo;
        }
    }

    /**
     * 
     * 是否还有上一页.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     */
    public boolean isHasPre()
    {
        return (pageNo - 1 >= 1);
    }

    /**
     * 取得上页的页号, 序号从1开始. 当前页为首页时返回首页序号.
     */
    public int getPrePage()
    {
        if (isHasPre())
        {
            return pageNo - 1;
        }
        else
        {
            return pageNo;
        }
    }

    /**
     * 获得当前页的页号,序号从1开始,默认为1.
     */
    public int getPageNo()
    {
        return pageNo;
    }

    /**
     * 获得每页的记录数量,默认为20.
     */
    public int getPageSize()
    {
        return pageSize;
    }

    /**
     * @since 2010-12-23
     * @author shanru.wu 根据pageSize与totalCount计算总页数, 默认值为-1.
     */
    public long getTotalPages()
    {
        if (this.getTotalCount() < 0)
        {
            return -1;
        }

        long count = this.getTotalCount() / pageSize;
        if (this.getTotalCount() % pageSize > 0)
        {
            count++;
        }
        return count;
    }

    /**
     * 
     * 设置当前页的页号,序号从1开始,低于1时自动调整为1.
     * 
     * @author shanru.wu
     * @since 2010-12-25
     * 
     */
    public void setPageNo(int pageNo)
    {
        this.pageNo = pageNo;
        if (this.pageNo < 1)
        {
            this.pageNo = 1;
        }
    }

    public void setTempPageNo(String tempPageNo)
    {
        if (tempPageNo.equals("") || tempPageNo == null)
        {
            tempPageNo = "1";
        }
        this.pageNo = Integer.parseInt(tempPageNo);
        this.tempPageNo = tempPageNo;
    }

}

