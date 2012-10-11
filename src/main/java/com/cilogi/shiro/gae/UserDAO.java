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


import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.util.DAOBase;
import org.apache.shiro.cache.Cache;

import java.util.Date;
import java.util.logging.Logger;

public class UserDAO extends DAOBase {
    static final Logger LOG = Logger.getLogger(UserDAO.class.getName());
    
    private static final long REGISTRATION_VALID_DAYS = 1;

    private final Cache<String, GaeUser> userCache;

    static {
        ObjectifyService.register(GaeUser.class);
        ObjectifyService.register(GaeUserCounter.class);
    }

    public UserDAO() {
        userCache = new MemcacheManager().getCache("GaeUser");
    }

    /**
     * Save user with authorization information
     * @param user  User
     * @param changeCount should the user count be incremented
     * @return the user, after changes
     */
    public GaeUser saveUser(GaeUser user, boolean changeCount) {
        ofy().put(user);
        userCache.remove(user.getName());
        if (changeCount) {
            changeCount(1L);
        }
        return user;
    }

    public GaeUser deleteUser(GaeUser user) {
        ofy().delete(user);
        userCache.remove(user.getName());
        changeCount(-1L);
        return user;
    }

    public GaeUser findUser(String userName) {
        try {
            GaeUser user = userCache.get(userName);
            if (user == null) {
                user = ofy().find(new Key<GaeUser>(GaeUser.class, userName));
                if (user != null) {
                    userCache.put(userName, user);
                }
            }
            return user;
        } catch (NullPointerException _) {
            return null;
        }
    }


    public long getCount() {
        GaeUserCounter count = ofy().find(GaeUserCounter.class, GaeUserCounter.COUNTER_ID);
        return (count == null) ? 0 : count.getCount();
    }

    public Date getCountLastModified() {
        GaeUserCounter count = ofy().find(GaeUserCounter.class, GaeUserCounter.COUNTER_ID);
        return (count == null) ? new Date(0L) : count.getLastModified();
    }

    /**
     * Change the user count.  Wrapped in a transaction to make sure the
     * count is accurate.
     * @param delta amount to change
     */
    private void changeCount(final long delta) {
        TransactDAO.repeatInTransaction(new TransactDAO.Transactable() {
            @Override
            public void run(TransactDAO transactDAO) {
                GaeUserCounter count = transactDAO.ofy().find(GaeUserCounter.class, GaeUserCounter.COUNTER_ID);
                if (count == null) {
                    count = new GaeUserCounter();
                }
                count.delta(delta);
                transactDAO.ofy().put(count);
            }
        });
    }
}
