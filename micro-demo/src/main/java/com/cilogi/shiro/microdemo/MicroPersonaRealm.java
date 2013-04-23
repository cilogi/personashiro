// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        MicroPersonaRealm.java  (11-Oct-2012)
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


package com.cilogi.shiro.microdemo;

import com.cilogi.shiro.persona.PersonaRealm;
import com.cilogi.shiro.persona.DefaultPersonaUserDAO;

/**
 * A realm that doesn't hook up with any persistence mechanism to
 * store user names, properties, permissions, etc.  In practice
 * one would record information about the users one has seen.
 */
public class MicroPersonaRealm  extends PersonaRealm {

    public MicroPersonaRealm() {
        super(new DefaultPersonaUserDAO(), null);
    }
}
