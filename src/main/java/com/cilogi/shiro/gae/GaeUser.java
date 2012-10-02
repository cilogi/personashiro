// Copyright (c) 2011 Tim Niblett All Rights Reserved.
//
// File:        GaeUser.java  (26-Oct-2011)
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

import com.google.common.base.Preconditions;
import com.googlecode.objectify.annotation.Cached;
import com.googlecode.objectify.annotation.Indexed;
import com.googlecode.objectify.annotation.Unindexed;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.SimpleByteSource;

import javax.persistence.Id;
import java.io.Serializable;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;


@Cached
@Unindexed
public class GaeUser implements Serializable {
    static final Logger LOG = Logger.getLogger(GaeUser.class.getName());

    static final int HASH_ITERATIONS = 1;
    static final String HASH_ALGORITHM = Sha256Hash.ALGORITHM_NAME;


    @Id
    private String name;

    private Set<String> roles;

    private Set<String> permissions;

    @Indexed
    private Date dateRegistered;

    private boolean isSuspended;

    /** For objectify to create instances on retrieval */
    private GaeUser() {
        this.roles = new HashSet<String>();
        this.permissions = new HashSet<String>();
    }
    
    GaeUser(String name) {
        this(name, new HashSet<String>(), new HashSet<String>());
    }
    
    public GaeUser(String name, Set<String> roles, Set<String> permissions) {
        this(name, roles, permissions, false);
    }

    GaeUser(String name, Set<String> roles, Set<String> permissions, boolean isRegistered) {
        Preconditions.checkNotNull(name, "User name (email) can't be null");
        Preconditions.checkNotNull(roles, "User roles can't be null");
        Preconditions.checkNotNull(permissions, "User permissions can't be null");
        this.name = name;

        this.roles = Collections.unmodifiableSet(roles);
        this.permissions = Collections.unmodifiableSet(permissions);
        this.dateRegistered = isRegistered ? new Date() : null;
        this.isSuspended = false;
    }

    public boolean isSuspended() {
        return isSuspended;
    }

    public void setSuspended(boolean suspended) {
        isSuspended = suspended;
    }

    public Date getDateRegistered() {
        return dateRegistered == null ? null : new Date(dateRegistered.getTime());
    }

    public boolean isRegistered() {
        return getDateRegistered() != null;
    }

    public void register() {
        dateRegistered = new Date();
    }

    public String getName() {
        return name;
    }

    public Set<String> getRoles() {
        return roles;
    }

    public Set<String> getPermissions() {
        return permissions;
    }


    @Override
    public boolean equals(Object o) {
        if (o instanceof GaeUser) {
            GaeUser u = (GaeUser)o;
            return getName().equals(u.getName());
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
