// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        AbstractPersonaRealm.java  (10-Oct-2012)
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

import com.google.common.base.Preconditions;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;


public abstract class AbstractPersonaRealm extends AuthorizingRealm {

    private final IPersonaUserDAO personaUserDAO;

    protected AbstractPersonaRealm(IPersonaUserDAO personaUserDAO, CacheManager cacheManager) {
        super(cacheManager, new PersonaCredentialsMatcher());
        this.personaUserDAO = personaUserDAO;
        setAuthenticationTokenClass(PersonaAuthenticationToken.class);
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        if (token != null && token instanceof PersonaAuthenticationToken) {
            PersonaAuthenticationToken authToken = (PersonaAuthenticationToken)token;
            String credentials = (String)authToken.getCredentials();
            String principal = (String)authToken.getPrincipal();
            if (credentials == null || principal == null) {
                throw new AuthenticationException("Both credential (" + credentials + ") and principal " +
                        principal + ") must be non-null for a token to authenticate");
            }
            return new PersonaAuthenticationInfo(credentials, principal);
        } else {
            return null;
        }
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Preconditions.checkNotNull(principals, "You can't have a null collection of principals");
        String principal = (String) getAvailablePrincipal(principals);
        if (principal == null) {
            throw new NullPointerException("Can't find a principal in the collection");
        }
        if (personaUserDAO.isUserExistsAndInGoodStanding(principal)) {
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(personaUserDAO.userRoles(principal));
            info.setStringPermissions(personaUserDAO.userPermissions(principal));
            return info;
        } else {
            return null;
        }
    }

}
