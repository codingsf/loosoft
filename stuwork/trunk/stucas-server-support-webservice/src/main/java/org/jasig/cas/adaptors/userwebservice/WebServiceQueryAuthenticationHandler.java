/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.adaptors.userwebservice;

import javax.validation.constraints.NotNull;

import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;

import cn.loosoft.data.webservice.api.user.UserWebService;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;

/**
 * 通过远程rmi服务取得用户信息，然后进行密码匹配对比
 * 
 * @author houbing qian
 * @version $Revision: 19533 $ $Date: 2009-12-14 23:33:36 -0500 (Mon, 14 Dec
 *          2009) $
 * @since 3.0
 */
public final class WebServiceQueryAuthenticationHandler extends
        AbstractUsernamePasswordAuthenticationHandler
{

    @NotNull
    // private String rmiServerPort;
    // private UserAdapter userAdapter;
    private UserWebService userWebService;

    @Override
    protected final boolean authenticateUsernamePasswordInternal(
            final UsernamePasswordCredentials credentials)
            throws AuthenticationException
    {
        final String username = getPrincipalNameTransformer().transform(
                credentials.getUsername());
        final String password = credentials.getPassword();
        final String encryptedPassword = this.getPasswordEncoder().encode(
                password);
        UserDTO userDTO = null;
        try
        {
            userDTO = userWebService.getUser(username);
            if (userDTO != null)
            {
                final String dbPassword = userDTO.getPassword();
                return dbPassword.equals(encryptedPassword);
            }
            return false;
        }
        catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        }
    }

    public UserWebService getUserWebService()
    {
        return userWebService;
    }

    public void setUserWebService(UserWebService userWebService)
    {
        this.userWebService = userWebService;
    }

    // public void setRmiServerPort(String rmiServerPort)
    // {
    // this.rmiServerPort = rmiServerPort;
    // }

    // private UserAdapter getUserAdapter()
    // {
    // if (userAdapter != null)
    // {
    // return userAdapter;
    // }
    // else
    // {
    // return new UserAdapter(rmiServerPort);
    // }
    // }
}
