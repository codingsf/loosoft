package cn.loosoft.data.webservice.api.user.dto;

/**
 * 
 * 权限DTO
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-27
 */
public class AuthorityDTO {

    private String prefixedName;

    public AuthorityDTO() {
    }

    public String getPrefixedName(){
        return this.prefixedName;
    }

    public void setPrefixedName(String prefixedName)
    {
        this.prefixedName = prefixedName;
    }

}
