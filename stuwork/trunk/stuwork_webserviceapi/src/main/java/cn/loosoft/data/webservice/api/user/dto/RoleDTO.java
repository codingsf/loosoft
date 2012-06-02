package cn.loosoft.data.webservice.api.user.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 角色DTO
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-27
 */
public class RoleDTO{

    private String name;     //名称

    private String authNames;//权限

    private List<AuthorityDTO> authorityList = new ArrayList<AuthorityDTO>();

    public RoleDTO() {
    }

    public RoleDTO(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<AuthorityDTO> getAuthorityList() {
        return authorityList;
    }

    public void setAuthorityList(List<AuthorityDTO> authorityList) {
        this.authorityList = authorityList;
    }


    public String getAuthNames()
    {
        return authNames;
    }

    public void setAuthNames(String authNames)
    {
        this.authNames = authNames;
    }

}
