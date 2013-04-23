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
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Serialize;

import javax.persistence.Id;
import java.io.Serializable;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Cache
@Entity
public class GaeUser implements Serializable {

    @Id
    private String name;

    @Serialize
    private Set<String> roles;

    @Serialize
    private Set<String> permissions;

    @Index
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
        Preconditions.checkNotNull(name, "User name (email) can't be null");
        Preconditions.checkNotNull(roles, "User roles can't be null");
        Preconditions.checkNotNull(permissions, "User permissions can't be null");
        this.name = name;

        this.roles = Collections.unmodifiableSet(roles);
        this.permissions = Collections.unmodifiableSet(permissions);
        this.dateRegistered = new Date();
        this.isSuspended = false;
    }

    public boolean isSuspended() {
        return isSuspended;
    }

    public void setSuspended(boolean suspended) {
        isSuspended = suspended;
    }

    public Date getDateRegistered() {
        return dateRegistered;
    }

    public String getName() {
        return name;
    }

    public synchronized Set<String> getRoles() {
        return Collections.unmodifiableSet(roles);
    }

    public synchronized void setRoles(Set<String> roles) {
        this.roles.clear();
        this.roles.addAll(roles);
    }

    public synchronized Set<String> getPermissions() {
        return Collections.unmodifiableSet(permissions);
    }

    public synchronized void setPermissions(Set<String> roles) {
        this.permissions.clear();
        this.permissions.addAll(roles);
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
