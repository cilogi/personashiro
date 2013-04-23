// Copyright (c) 2013 Cilogi. All Rights Reserved.
//
// File:        UserCounterDAO.java  (23/04/13)
// Author:      tim
//
// Copyright in the whole and every part of this source file belongs to
// Cilogi (the Author) and may not be used, sold, licenced, 
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

import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static com.googlecode.objectify.ObjectifyService.ofy;


public class UserCounterDAO {
    static final Logger LOG = LoggerFactory.getLogger(UserCounterDAO.class);

    static {
        ObjectifyService.register(UserCounter.class);
    }

    public UserCounterDAO() {}

    public void inc(final int delta) {
        ofy().transact(new VoidWork() {
            public void vrun() {
                UserCounter counter = getCounter();
                if (counter == null) {
                    counter = new UserCounter();
                }
                counter.delta(delta);
                ofy().save().entity(counter);
            }
        });
    }

    public int getCount() {
        return getCounter().getCount();
    }

    private static UserCounter getCounter() {
        return ofy().load().key(Key.create(UserCounter.class, UserCounter.COUNTER_ID)).get();
    }
}
