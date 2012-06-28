package cn.loosoft.stuwork.welnew.util;


/**
 * 
 * @author mlv
 * 
 */
public class FileUploadUtil
{
    /**
     * 
     * 设置文件下载类型
     * 
     * @since 2011-5-6
     * @author fangyong
     * @param filename
     *            文件名
     * @param postfox
     *            文件类型
     * @return String[]
     */
    public static String[] getContentType(String filename, String postfox)
    {
        String[] downStrArray = new String[2];

        String contentType = "application/octet-stream";
        if (postfox.equalsIgnoreCase(".PDF"))// pdf
        {
            contentType = "application/pdf";
        }
        else
            if (postfox.equalsIgnoreCase(".ZIP"))// zip
            {
                contentType = "application/zip";
            }
            else
                if (postfox.equalsIgnoreCase(".RAR"))// rar
                {
                    contentType = "application/rar";
                }
                else
                    if (postfox.equalsIgnoreCase(".DOC")// word 2003
                            || postfox.equalsIgnoreCase(".DOCX"))
                    {
                        contentType = "application/msword";
                    }
                    else
                        if (postfox.equalsIgnoreCase(".XLS"))// excel 2003
                        {
                            contentType = "application/vnd.ms-excel";
                            if (filename.length() - 4 > 12)
                            {
                                filename = filename.substring(0, 12) + ".xls";
                            }
                            // file_name =
                            // article_id+".xls";//由于Excel文件名过长的话,无法打开,只能下载,所以覆盖掉原来的文件名
                        }
                        else
                            if (postfox.equalsIgnoreCase(".XLSX"))// excel 2007
                            {
                                contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                                if (filename.length() - 5 > 13)
                                {
                                    filename = filename.substring(0, 12)
                                            + ".xlsx";
                                }
                            }
                            else
                                if (postfox.equalsIgnoreCase(".PPT") // ppt
                                        || postfox.equalsIgnoreCase(".PPTX"))
                                {
                                    contentType = "/vnd.ms-powerpoint";
                                }
                                else
                                    if (postfox.equalsIgnoreCase(".JPG"))// jpg
                                    {
                                        contentType = "image/jpeg";
                                    }
                                    else
                                        if (postfox.equalsIgnoreCase(".BMP"))// bmp
                                        {
                                            contentType = "image/x-xbitmap";
                                        }
                                        else
                                            if (postfox
                                                    .equalsIgnoreCase(".GIF"))// gif
                                            {
                                                contentType = "image/gif";
                                            }
                                            else
                                                if (postfox
                                                        .equalsIgnoreCase(".TXT")) // txt
                                                {
                                                    contentType = "application/txt";
                                                }
        downStrArray[0] = contentType;
        downStrArray[1] = filename;

        return downStrArray;
    }

}
