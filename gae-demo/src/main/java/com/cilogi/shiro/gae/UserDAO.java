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


public class UserDAO implements IPersonaUserDAO {


    static {
        ObjectifyService.register(GaeUser.class);
    }

    public UserDAO() {}

    @Override
    public GaeUser get(String emailAddress) {
        Preconditions.checkNotNull(emailAddress, "Email address can't be null");
        GaeUser db = ofy().load().key(Key.create(GaeUser.class, emailAddress)).get();
        return db;

    }

    @Override
    public GaeUser create(String emailAddress, Set<String> roles, Set<String> permissions) {
        GaeUser user = new GaeUser(emailAddress, roles, permissions);
        save(user);
        new UserCounterDAO().inc(1);
        return user;
    }

    /**
     * Save a user.  Its assumed that the user isn't currently in the database, otherwise
     * the counts will be off
     * @param user  the user to save
     * @return  A pointer to the user, for chaining.
     */
    public GaeUser save(GaeUser user) {
        Preconditions.checkNotNull(user, "User can't be null");
        ofy().save().entity(user).now();
        return user;
    }

    public GaeUser delete(GaeUser user) {
        Preconditions.checkNotNull(user, "User can't be null");
        ofy().delete().keys(Key.create(GaeUser.class, user.getEmailAddress()));
        new UserCounterDAO().inc(-1);
        return user;
    }
}
