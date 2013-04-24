// Copyright (c) 2011 Tim Niblett All Rights Reserved.
//
// File:        UserDAO.java  (01-Nov-2011)
// Author:      tim

//
// Copyright in the whole and every part of this source file belongs to
// Tim Niblett (the Author) and may not be used,
// sold, licenced, transferred, copied or reproduced in whole or in
// part in any manner or form or in or on any media to any person
// other than in accordance with the terms of The Author's agreement
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
import com.google.common.base.Preconditions;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;

import java.util.Set;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * This is a demonstration of how to interface a user class to Persona
 * and the App Engine datastore.  In practice the class used would have to be
 * a sub-class of GaeUser, or based on something completely different.
 */
public class UserDAO extends BaseDAO<GaeUser> implements IPersonaUserDAO {


    static {
        ObjectifyService.register(GaeUser.class);
    }

    public UserDAO() {
        super(GaeUser.class);
    }

    @Override
    public GaeUser get(String emailAddress) {
        Preconditions.checkNotNull(emailAddress, "Email address can't be null");
        return super.get(emailAddress);

    }

    @Override
    public GaeUser create(String emailAddress, Set<String> roles, Set<String> permissions) {
        GaeUser user = new GaeUser(emailAddress, roles, permissions);
        put(user);
        new UserCounterDAO().inc(1);
        return user;
    }

    public void delete(GaeUser user) {
        delete(user.getEmailAddress());
    }

}
