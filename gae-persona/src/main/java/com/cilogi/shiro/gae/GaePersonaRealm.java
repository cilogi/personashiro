// Copyright (c) 2013 Cilogi. All Rights Reserved.
//
// File:        GaePersonaRealm.java  (23/04/13)
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

import com.cilogi.shiro.persona.PersonaRealm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class GaePersonaRealm extends PersonaRealm {
    static final Logger LOG = LoggerFactory.getLogger(GaePersonaRealm.class);

    public GaePersonaRealm() {
        super(new UserDAO(), new MemcacheManager());
    }
}
