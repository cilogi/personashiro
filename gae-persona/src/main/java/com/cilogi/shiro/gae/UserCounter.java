// Copyright (c) 2011 Tim Niblett All Rights Reserved.
//
// File:        UserCounter.java  (11-Nov-2011)
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

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import org.slf4j.LoggerFactory;

/**
 * This is a singleton, just holding a count of the number
 * of GaeUser objects we have.
 * <p> The reason for using this is that counting the number of items
 * dynamically is very inefficient, and costly.
 * <p> This counter should be changed relatively rarely (less than once a second)
 * so doesn't need to be sharded.
 */
@Cache
@Entity
class UserCounter {
    static final org.slf4j.Logger LOG = LoggerFactory.getLogger(UserCounter.class);

    static final long COUNTER_ID = 1L;

    @Id
    private long id;

    private int count;

    UserCounter() {
        id = COUNTER_ID;
    }

    int getCount() {
        return count;
    }

    void delta(int delta) {
        this.count += delta;
    }
}
