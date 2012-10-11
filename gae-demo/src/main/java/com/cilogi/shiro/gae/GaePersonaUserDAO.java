// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        GaePersonaUserDAO.java  (10-Oct-2012)
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


package com.cilogi.shiro.gae;

import com.cilogi.shiro.persona.IPersonaUserDAO;
import com.google.common.collect.Sets;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.Set;

public class GaePersonaUserDAO implements IPersonaUserDAO {

    private final  Provider<UserDAO> userDAOProvider;

    @Inject
    public GaePersonaUserDAO(Provider<UserDAO> userDAOProvider) {
        this.userDAOProvider = userDAOProvider;
    }

    @Override
    public void newUserIfNotExists(String principal ) {
        GaeUser user = (principal == null) ? null : dao().findUser(principal);
        if (user == null) {
            user = new GaeUser(principal, Sets.newHashSet("user"), Sets.<String>newHashSet());
            dao().saveUser(user, true);
        }
    }

    @Override
    public boolean isUserExistsAndInGoodStanding(String principal) {
        GaeUser user = dao().findUser(principal);
        return !(user == null || user.isSuspended());
    }

    @Override
    public Set<String> userRoles(String principal) {
        GaeUser user = dao().findUser(principal);
        if (user == null || user.isSuspended()) {
            return Sets.newHashSet();
        }
        return user.getRoles();
    }

    @Override
    public Set<String> userPermissions(String principal) {
        GaeUser user = dao().findUser(principal);
        if (user == null || user.isSuspended()) {
            return Sets.newHashSet();
        }
        return user.getPermissions();
    }

    private UserDAO dao() {
        return userDAOProvider.get();
    }

}