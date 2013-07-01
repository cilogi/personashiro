<#assign title="Shiro and Persona on GAE">
<#assign style="mainstyle.css">
<!DOCTYPE html>
<html lang="en" class="shiro-none-active">
<head>
    <#include "inc/_head.ftl">
</head>

<body>

<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="navbar-inner">
        <div class="container">
            <a class="brand" href="#">PersonaShiro</a>
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#why">Why</a></li>
                    <li><a href="#how">How</a></li>
                    <li><a href="#shiro">Shiro</a></li>
                    <li><a id="user" class="shiro-user" style="color:yellow" href="/protected.ftl">User</a></li>
                    <li><a id="admin" class="shiro-user" style="color:red" href="/listUsers.ftl">Admin</a></li>
                </ul>
                <#include "inc/loginoutbutton.ftl">
            </div>
        </div>
    </div>
</div>


<div id="spinner"  style="position: absolute; top: 90px; left: 50%;">
</div>

<div class="container">


<!-- Main hero unit for a primary marketing message or call to action -->
<div class="hero-unit">
    <div class="semi">
        <h1>Shiro & Persona on GAE</h1>

        <p></p>

        <p>A demonstration which shows one way of integrating <a href="http://shiro.apache.org/">Shiro security</a>
            with <a href="http://code.google.com/appengine/">App Engine</a> and
            <a href="http://www.mozilla.org/en-US/persona//">Mozilla Persona</a>.

        <p>Identity management comes from Persona, authorization from Shiro.</p>

    </div>
</div>

<!-- Example row of columns -->
<div class="quickstart">
    <div class="row">
        <div class="span6">
            <h6>Identity Management</h6>

            <p>We provide identity management using <a href="http://www.mozilla.org/persona">Persona</a> which is as
               simple to use as the built-in User Service.</p>
        </div>
        <div class="span5">
            <h6>Persona and Shiro</h6>

            <p>Persona takes care of authentication, providing a verified Email.  Shiro
               takes care of authorization.</p>
        </div>
        <div class="span5">
            <h6>Fork on Github</h6>

            <p>Get the code, file issues, etc. on the Github repository</p>

            <p><a class="btn primary" href="https://github.com/cilogi/personashiro">PersonaShiro on GitHub &raquo;</a></p>
        </div>
    </div>
</div>


<section id="why">
    <div class="page-header">
        <h1>Why
            <small>why are we doing this?</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>Take home</h2>

            <p>A user identity service for App Engine</p>

            <p>leveraging <a href="http://www.mozilla.org/persona">Persona</a> for identity</p>

            <p>and <a href="http://shiro.apache.org/">Apache Shiro</a> for Authentication and Authorization.</p>

            <p>As simple to use as the built-in user service, but more functional.</p>
        </div>
        <div class="span9">
            <p>App Engine is a great. You can create a small free website and
                scale it indefinitely with almost no ongoing administration. A wide range
                of useful services are available out of the box.</p>

            <p>There is a Google accounts service, but this can't be used for an application used by a wider
               public, who don't have or don't want use a Google login. Even with a user service many sites
               also need a permissions system to decide who gets to access what. App Engine has one but
               its limited.</p>

            <p><a href="http://www.mozilla.org/persona">Persona</a> is an new approach to identity
               management from Mozilla.  It provides a secure way
               for users to authenticate with web sites using their Email addresses.  This (for me) is more
               convenient than OpenID, as one usually wants the Email address anyway.  Unlike other systems
               the email is the <em>only</em> information that gets given to the website.</p>

            <p><a href="http://shiro.apache.org/">Shiro</a> is a lightweight system for authentication
                and authorization. Startup on App Engine for Shiro seems to be about 1 second (on top of other
                components of course), which is faster than for a heavier stack such as
                <a href="http://static.springsource.org/spring-security/site/">Spring Security</a>.
                The shorter the startup the easier it is to scale an app by adding
                new instances in response to demand. So, Shiro is a good fit with App Engine and its worth
                making the adaptation to the Datastore and Memcached services.</p>

            <p>This sample provides an identity management system
                which can easily be extended, or used as-is.  The ease of use is the same as the built-in
                service, but you can use it with any Email address and the security framework is more
                flexible if you ever need it.  Its a lighter-weight solution than
               <a href="http://static.springsource.org/spring-security/site/">Spring Security</a></p>
       </div>
    </div>
</section>

<section id="how">
    <div class="page-header">
        <h1>How
            <small>to get started</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>In Brief</h2>

            <p><a href="https://github.com/cilogi/personashiro/wiki/The-Micro-Demo">Look at the micro-demo.</a></p>
        </div>
        <div class="span9">
            <p>To get started clone the repository at <a href="https://github.com/cilogi/personashiro">https://github.com/cilogi/personashiro</a>
            <p>We have created a <em>micro</em> demo which runs from maven and show how to get Persona working with
               Shiro as simply as possible.  Detailed instructions are <a href="https://github.com/cilogi/personashiro/wiki/The-Micro-Demo">here</a></p>
            <p>In order to run Persona and Shiro under App Engine the micro demo should work fine.  The <em>gae-demo</em>
               module shows how to (a) add a cache manager based on the App Engine Memcache service and (b) how to add some
               basic user management, with the user data being stored with the Datastore.</p>
        </div>
    </div>
</section>

<section id="shiro">
    <div class="page-header">
        <h1>Adapting Shiro
            <small>for the demo</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>In Brief</h2>

            <p>We have adapted realms and caches./p>

            <p>Objectify is used to interface to the datastore</p>

            <p>In memory caches are combined with memcached to keep things fast and cheap.</p>
        </div>
        <div class="span9">
            <p>Adaptation of the Shiro realm, token, and authentication classes to Persona
               are straightforward.  Control flow is simple, a token is received and if verified,
               the user is extracted and we can login.</p>
            <p>For the demo we have also introduced a user class, <code>GaeUser</code> which can
               be stored in the App Engine datastore.  We've also provided a simple way to list users.</p>
        </div>
    </div>
</section>
</div>
<#include "inc/copyright.ftl">
</body>
<#include "inc/_foot.ftl">
</html>

