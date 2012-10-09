// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        OAuthRealm.java  (07-Oct-2012)
// Author:      tim
//
// Copyright in the whole and every part of this source file belongs to
// Tim Niblett (the Author) and may not be used, sold, licenced, 
// transferred, copied or reproduced in whole or in part in 
// any manner or form or in or on any media to any person other than 
// in accordance with the terms of The Author's agreement
// or otherwise without the prior written consent of The Author.  All
// information contained in this source file is confidential information
// belonging to The Author and as such may not be disclosed other
// than in accordance with the terms of The Author's agreement, or
// otherwise, without the prior written consent of The Author.  As
// confidential information this source file must be kept fully and
// effectively secure at all times.
//


package com.cilogi.shiro.persona;

import com.cilogi.shiro.gae.GaeUser;
import com.cilogi.shiro.gae.MemcacheManager;
import com.cilogi.shiro.gae.UserDAO;
import com.cilogi.shiro.gae.UserDAOProvider;
import com.google.common.base.Preconditions;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import java.util.logging.Logger;


public class PersonaRealm extends AuthorizingRealm {
    static final Logger LOG = Logger.getLogger(PersonaRealm.class.getName());

    public PersonaRealm() {
        super(new MemcacheManager(), new PersonaCredentialsMatcher());
        setAuthenticationTokenClass(PersonaAuthenticationToken.class);
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        if (token != null && token instanceof PersonaAuthenticationToken) {
            PersonaAuthenticationToken authToken = (PersonaAuthenticationToken)token;
            return new PersonaAuthenticationInfo((String)authToken.getCredentials(), (String)authToken.getPrincipal());
        } else {
            return null;
        }
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Preconditions.checkNotNull(principals, "You can't have a null collection of principals");
        String userName = (String) getAvailablePrincipal(principals);
        if (userName == null) {
            throw new NullPointerException("Can't find a principal in the collection");
        }
        LOG.fine("Finding authorization info for " + userName + " in DB");
        GaeUser user = dao().findUser(userName);
        if (user == null || user.isSuspended()) {
            return null;
        }
        LOG.fine("Found " + userName + " in DB");
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(user.getRoles());
        info.setStringPermissions(user.getPermissions());
        return info;
    }

    private static UserDAO dao() {
        return UserDAOProvider.get();
    }
}
