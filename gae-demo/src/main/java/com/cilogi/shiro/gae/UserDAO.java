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
import com.googlecode.objectify.VoidWork;

import java.util.Set;
import java.util.logging.Logger;

import static com.googlecode.objectify.ObjectifyService.ofy;


public class UserDAO implements IPersonaUserDAO {
    static final Logger LOG = Logger.getLogger(UserDAO.class.getName());
    

    static {
        ObjectifyService.register(GaeUser.class);
        ObjectifyService.register(GaeUserCounter.class);
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
        save(user, true);
        return user;
    }

    public GaeUser save(GaeUser user, boolean isChangeCount) {
        ofy().save().entity(user).now();
        if (isChangeCount) {
            changeCount(1L);
        }
        return user;
    }

    public GaeUser delete(GaeUser user) {
        ofy().delete().keys(Key.create(GaeUser.class, user.getEmailAddress()));
        changeCount(-1L);
        return user;
    }

    public long getCount() {
        GaeUserCounter count = getCounter();
        return (count == null) ? 0 : count.getCount();
    }

    /**
     * Change the user count.  Wrapped in a transaction to make sure the
     * count is accurate.
     * @param delta amount to change
     */
    private void changeCount(final long delta) {
        ofy().transact(new VoidWork() {
            public void vrun() {
                GaeUserCounter counter = getCounter();
                if (counter == null) {
                    counter = new GaeUserCounter();
                }
                counter.delta(delta);
                ofy().save().entity(counter);
            }
        });
    }

    private static GaeUserCounter getCounter() {
        return ofy().load().key(Key.create(GaeUserCounter.class, GaeUserCounter.COUNTER_ID)).get();
    }

}
