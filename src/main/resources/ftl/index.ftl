<#assign title="Shiro on GAE">
<#assign style="mainstyle.css">
<!DOCTYPE html>
<html lang="en" class="shiro-none-active">
<head>
    <#include "inc/_head.ftl">
</head>

<body>

<div id="spinner" class="shiro-unset" style="position: absolute; top: 90px; left: 50%;">
</div>

<div class="topbar" data-scrollspy="scrollspy">
    <div class="topbar-inner">
        <div class="container">
            <a class="brand" href="#">Shiro on GAE</a>
            <ul class="nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#what">What</a></li>
                <li><a href="#motivation">Motivation</a></li>
                <li><a href="#shiro">Shiro</a></li>
                <li><a href="#guice">Guice</a></li>
                <li><a href="#management">Manage</a></li>
                <li><a href="#about">About</a></li>
                <li><a id="admin" class="shiro-user" style="color:red" href="/listUsers.ftl">Admin</a></li>
            </ul>
            <#include "inc/loginoutbutton.ftl">
        </div>
    </div>
</div>


<div class="container">

<!-- Main hero unit for a primary marketing message or call to action -->
<div class="hero-unit">
    <div class="semi">
        <h1>Shiro on App Engine</h1>

        <p></p>

        <p>A demonstration which shows one way of integrating <a href="http://shiro.apache.org/">Shiro security</a>
            with <a href="http://code.google.com/appengine/">App Engine</a> and
            <a href="http://code.google.com/p/google-guice/">Google Guice</a>.

        <p> Front end user registration and password management is also provided in as minimalistic
            a fashion as we could manage</p>

        <div class="shiro-guest">
            <p><a href="/register.ftl" class="btn primary large">Register &raquo;</a></p>
        </div>
    </div>
</div>

<!-- Example row of columns -->
<div class="quickstart">
    <div class="row">
        <div class="span6">
            <h6>App Engine and Shiro</h6>

            <p>We provide a Shiro Realm which works with the App Engine datastore via
                <a href="http://code.google.com/p/objectify-appengine">Objectify</a>.
                Caching comes via App Engine's memcached service.</p>
        </div>
        <div class="span5">
            <h6>Guice and Shiro</h6>

            <p>Shiro's <a href="http://shiro.apache.org/java-annotations-list.html">AOP</a> features,
               specifically the method annotations, work with Guice. Otherwise
               Shiro configuration is done with the Shiro ini file.</p>
        </div>
        <div class="span5">
            <h6>Fork on Github</h6>

            <p>Get the code, file issues, etc. on the Github repository</p>

            <p><a class="btn primary" href="https://github.com/cilogi/gaeshiro">GAEShiro on GitHub &raquo;</a></p>
        </div>
    </div>
</div>
<section id="what">
    <div class="page-header">
        <h1>What
            <small>can you do with the demo?</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>You can</h2>

            <p>Sign in as admin or user,</p>

            <p>register with an Email address,</p>

            <p>forget or change your password,</p>

            <p> and suspend users as an administrator</p>
        </div>
        <div class="span9">
            <p>You can sign in from the link at the top right.  There are two built-in accounts you
               can user, <code>zenith@acme.com</code> and <code>nadir@acme.com</code>.
                Both have password <code>pass</code>.  The <code>zenith</code> account is an admin, and
                can do more than <code>nadir</code> which is a normal user account.  The dummy accounts,
                of the form <code>userN@acme.com</code>all have the password <code>acme</code></p>
            <p>You can also register for an account.  You need to provide an Email which you control for this
               as a registration code will be sent to this Email address.  Once you're registered you can use this
               account, unless someone suspends it.</p>
            <p>If you forget your password you can reset it.  An email is sent to you with a code and a link. Either
               enter the code or follow the link to do the reset.</p>
            <p>When logged in as <code>zenith</code> you can list users and choose whether to suspend them or not.
               A suspended user cannot login.</p>
            <p>In practice all the URLs must run under <code>HTTPS</code>, since passwords are contained in the
               HTTP requests. This demo does <em>not</em> use <code>HTTPS</code> so be warned!</p>
        </div>
    </div>
</section>

<section id="motivation">
    <div class="page-header">
        <h1>Motivation
            <small>why are we doing this?</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>Take home</h2>

            <p>App Engine is great</p>

            <p>but quirky</p>

            <p>and doesn't come with a general authentication and authorization service.</p>

            <p>Shiro is good for this and
                we've done the needed porting, and</p>

            <p>provided some simple user management.</p>

            <p>Guice is used to glue things together</p>

            <p>even though it slows down startup.</p>

        </div>
        <div class="span9">
            <p>App Engine is a remarkable achievement. You can create a small free website and
                scale it indefinitely with almost no ongoing administration required. A wide range
                of useful services are available out of the box, with almost no set-up or maintenance
                needed.</p>

            <p>With scalability comes a set of restrictions and limitations. Interfaces are
                non-standard: in particular you don't get SQL (its coming), so persistent storage and retrieval are
                'different'. Application instances are started on demand, so startup must be rapid. Startup is a
                particular challenge for Java which is known to initialize with the alacrity of a drowsy snail.
                App Engine charges for resources so you need to be careful to minimise use.</p>

            <p>There is a Google accounts service, but this can't be used for an application used by a wider
               public, who don't have or don't want use a Google login. Even with a user service many sites
               also need a permissions system to decide who gets to access what.</p>

            <p><a href="http://shiro.apache.org/">Shiro</a> is a lightweight system for Authentication
                and authorization. Startup on App Engine for Shiro seems to be about 1 second (on top of other
                components of course), which is faster than for a heavier stack such as
                <a href="http://static.springsource.org/spring-security/site/">Spring Security</a>.
                The shorter the startup the easier it is to scale an app by adding
                new instances in response to demand. So, Shiro is a good fit with App Engine and its worth
                making the adaptation to the Datastore and Memcached services.</p>

            <p>If you're not using the built-in authentication system for Google email addresses then you'll
                likely want a basic system for user password management. Even if your preference is for a
                federated login you'll probably still need your own system for those users that don't want to use
                or can't use the federated system. This sample provides a basic password management system
                which can easily be extended, or used as-is</p>

            <p>The fastest way to run App Engine is with basic servlets run from <code>web.xml</code>.
                This can be quite painful, so we're using Google Guice. Guice is a lightweight dependency
                injection framework with an extension for web applications and it makes wiring an application
                together much simpler.</p>

            <p>Although Guice is considered to be lightweight (compared to Spring) it does slow down the
                startup of the application. This is because Guice does its wiring at startup, so pretty-much
                all your code will be loaded at once. With plain servlets you may be able to load classes incrementally.
                It is possible to use Guice without its AOP features, which slow down startup, but we've chosen
                to go with the whole package to show the use of Shiro annotations which require AOP.</p>

            <p>This demonstration uses a simple trick to make the startup seem faster by using a static HTML page
                as the home page and performing an Ajax call from Javascript to do the initialization. Some crufty
                animation on load takes your attention away from the 5 second start-up delay!  The startup page is
                generated from FreeMarker templates, just as the other pages, but at compile time, rather than runtime</p>
        </div>
    </div>
</section>
<section id="shiro">
    <div class="page-header">
        <h1>Adapting Shiro
            <small>what we had to do</small>
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
            <p>The Shiro components which need to be adapted to App Engine are
                <a href="http://shiro.apache.org/realm.html">realms</a>,
                the <a href="http://shiro.apache.org/caching.html">cache</a> and
                the AOP-based annotations. If the annotations aren't required then
                they can be eliminated and startup time will be reduced.

            <p>

            <p>To create a new realm only two methods need to be implemented, namely:</p>
<pre class="prettyprint" lang-java>
    AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
    AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals)
</pre>
            <p>The only sort of token handle is the <code>UsernamePasswordToken</code>, so
               the principal and credentials are simple strings, in our case a user's email
               address and password. We use an email address as the user's identifier since we
               need it anyway to change passwords securely.</p>
            <p>It is possible to set up users in the <code>IniRealm</code> and it makes sense
               to use this with our new realm -- the <code>IniRealm</code> is a good place to stash
               the administrator login for example. Our <code>DatastoreRealm</code> needs to be able to
               store an unlimited number of users persistently, so we need the datastore for
               this. Rather than using the raw datastore service we use <a href="">Objectify</a> which
               is a well designed and  lightweight layer on top of the datastore, which just
               removes the rough edges without hiding the datastore structure.</p>
            <p>Implementation of the <code>DatastoreRealm</code> is via a user object, <code>GaeUser</code>,
                which is keyed on the email address and has a single indexed field - the registration date.
                Using the email as the key means that lookup will be fast and cheap.</p>
            <p>We have also implemented a Shiro-compatible cache, based on memcached.
                The cache expiry has been set to 5 minutes which should limit any consistency problems.</p>
            <p>Since the <code>DatastoreRealm</code> is a singleton in each JVM, and since although memcached
                saves on datastore resources it is slow, we also include an in-memory cache in the realm, which
                is of limited size and evicts after 5 minutes, but is fast. A combination of in-memory
                and memcached caches is the best way to limit hits to the data store and to minimize the
                overall cost and the number of instances we need,</p>
            <p>Another database object we use is a <code>RegistrationString</code>, which contains a one-shot code
                which is sent to users by email to allow them to (a) register and (b) change passwords. This code
                is time-limited so that archived emails don't cause a problem.</p>
            <p>The final database object is a counter to keep track of the number of users we have.  Its
               too inefficient to count users when the number is large so a counter is needed.  We don't expect
               the counter to be changed very often (not more than once a second) so there's no need for fancy
               tricks like sharding.</p>
        </div>
    </div>
</section>
<section id="guice">
    <div class="page-header">
        <h1>Guice
            <small>setup and interface</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>The pith</h2>

            <p>We have adapted realms and caches.</p>

            <p>Objectify is used to interface to the datastore</p>

            <p>In memory caches are combined with memcached to keep things fast and cheap.</p>
        </div>
        <div class="span9">
            <p>There are a couple of ways to go when interfacing a system such as Shiro with Guice. We can
                do the minimum necessary to interface Guice and Shiro or we can try a deeper integration where
                Shiro can be fully configured inside Guice.</p>
            <p>Shiro 1.2 will include a Guice module which goes down the second of these routes. I may be
                missing something but I don't see much advantage to this, and the minimal approach where we
                do as much configuration as possible from the <code>shiro.ini</code> resource file does
                everything we need, which is three main functions.</p>
                <ol>
                    <li>Be unobtrusive so that I don't have to think about security when I'm coding the logic of
                        my application.
                    </li>
                    <li>Let me specify, in as declarative a manner as possible, the security for the application</li>
                    <li>Provide a simple mechanism whereby I can tailor web pages depending on who is logged in</li>
                </ol>
            <p>All of these concerns are met by the <em>standard</em> Shiro. The <code>shiro.ini</code> file
                is great -- its simple and powerful.</p>
            <p>My mind is open to persuasion on this point. I just haven't seen any reason for moving from the
                minimalist position. Here is the <code>shiro.ini</code> I'm using.</p>
<pre class="prettyprint">
[main]
gaeRealm = com.cilogi.shiro.gae.DatastoreRealm
securityManager.realms = $iniRealm, $gaeRealm

[users]
zenith@acme.com = pass, user, admin
nadir@acme.com = pass, user

[roles]
admin = *
user = browse:*

[urls]
/login.jsp = authc
/settings.html = authc, roles[user]
/logout = logout
...
</pre>
            <p>There are two ways in which we can tailor web pages. The first is to use templates and tags. The
                built in JSP tags can be used from both JSP and FreeMarker (if not others). In Freemarker you
                need the following invocation at the top of your web page:</p>
<pre class="prettyprint">
&lt;#assign shiro=JspTaglibs["META-INF/shiro.tld"]&gt;
</pre>
            with the location of the tag specification being the expression in brackets. You can then use
            tags to include text, depending on the user's status, role or permissions. The second approach,
            used on this page is to query the server, via Ajax, for your status, set class attributes depending
            on the result and use CSS rules to decide what to show.</p>
            <p>In order to configure Shiro with Guice the following was necessary (for Shiro 1.2, Shiro 1.1 will
                be a little different).</p>
            <ul>
                <li>The Shiro listener should be added to <code>web.xml</code>
<pre class="prettyprint" lang-xml linenums>
    &lt;listener&gt;
        &lt;listener-class>
          org.apache.shiro.web.env.EnvironmentLoaderListener
        &lt;/listener-class&gt;
    &lt;/listener&gt;
</pre>
                </li>
                <li>Inside the <code>configureServlets</code> method of your <code>ServletModule</code> you must
                    serve the paths you want secured with the <code>ShiroFilter</code>.
<pre class="prettyprint">
    filter("/*").through(ShiroFilter.class);
</pre>
                </li>
                <li>In your <code>configure</code> method you need to make sure that <code>ShiroFilter</code>
                    is a singleton.
<pre class="prettyprint">
    bind(ShiroFilter.class).in(Scopes.SINGLETON);
</pre>
                </li>
            </ul>
            <p>That's all it takes to configure Shiro with Guice. If you want to use the AOP annotations then
                you will need to include the Guice module <code>com.cilogi.shiro.aop.AopModule</code> which
                provides bindings for all of Shiro's AOP annotations.</p>
        </div>
    </div>
</section>
<section id="management">
    <div class="page-header">
        <h1>Manage
            <small>users and passwords</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>To summarize</h2>

            <p>Users can register, choose to change password and reset a forgetten password</p>

            <p>One-time. limited duration, tokens are used to provide links to unsecured change pages.</p>

            <p>Registration and password change use essentially the same flow</p>
        </div>
        <div class="span9">
            <p>In an ideal world applications such as our would not need to do password management. Even though
                there are now a variety of identity providers, not all users will want to use them. So, as a
                fallback applications must provide <em>traditional</em> password management.</p>

            <p>This sample provides the basics packaged so that anyone working with App Engine can incorporate
                it relatively simply, although presentational changes will be required.</p>

            <p>In describing the flow we use relative URLs to describe processes controlled by servlets.</p>

            <h2>Control flow for registration</h2>
            <ol>
                <li>Go to the <code>/register.ftl</code> URL. This loads a page with a registration form.
                    The form contains an email field.
                </li>
                <li>The form is posted to <code>/register</code>. This is done using Ajax so we stay on the same
                    page. An email message is sent to the user at the provided address. The email contains a code
                    and a link. The user can either
                    enter the code and the desired password on the page or click the link in the sent email and
                    enter the code and password at the page which comes up.
                    In either case
                    we post or get to the <code>/confirm</code> URL with the code as a parameter.
                <li>This checks the validity of the code, and if its valid
                    adds a confirmation message to the current page. The user is logged in on hte server and
                    we are done.
                </li>
            </ol>
            <h2>Control flow for forgotten password</h2>

            <p>The control flow for a forgotten password is similar to that for registration with two slight
                differences.</p>
            <ol>
                <li>If the email address is already registered we don't bail out with an error message, as the
                    presumption is that the person entering the data owns the email address.
                </li>
                <li>Some of the wording on the web pages is differed (Reset rather than Register). These
                    differences can be expressed using the same template configured with slightly different
                    arguments.
                </li>
            </ol>
        </div>
    </div>
</section>
<section id="about">
    <div class="page-header">
        <h1>About
            <small>the other tools</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>Also using</h2>

            <p>As well as Guice and Shiro</p>
            <p>the demo also uses <a href="http://twitter.github.com/bootstrap/">Bootstrap from Twitter</a>
               for its CSS framework</p>
            <p>and <a href="http://freemarker.sourceforge.net/">Freemarker</a> for templating.</p>
        </div>
        <div class="span9">
            <p>To provide a complete demo requires HTML pages.  We're using Bootstrap as the CSS framework
               (it actually uses <a href="http://lesscss.org/">less</a> to create CSS) which makes well laid out sites
               easy for those of us with no layout skills.</p>
            <p>The HTML pages are organised using the Freemarker templating language. The <code>index.html</code>
               main page for example (this one) is pre-generated using Freemarker to avoid a wait while App Engine spins
               up an instance.  This uses the Maven plugin for <a href="http://fmpp.sourceforge.net/">FMPP</a>,
               the Freemarker pre-processor</p>
            <p>All the administrative logic is done using <a href="http://jquery.com/">jQuery's</a> Ajax
               features.  This is intended to decouple the login from the presentation if we wish to produce
               a mobile version of this demo, which will require different layouts.  We also do some caching in
               JavaScript to minimise round trips to the server to determine login status.  This doesn't compromise the
               server-side security but speeds things up and helps bring down App Engine's costs.</p>
            <h3>Reuse</h3>
            <p>The <code>com.cilogi.shiro.gae</code> and <code>com.cilogi.shiro.aop</code> packages should
               be easily re-usable.  There are dependencies on Shiro, Objectify and Guava.  The Guava
               dependency could be removed with a little effort, Objectify somewhat more.</p>
            <p>The servlets in <code>com.cilogi.shiro.web</code> have parameters hard-wired and no
               I18N for strings, but the logic is re-usable.</p>
            <p>The image of the lock is by 
               <a href="http://www.flickr.com/photos/renaissancechambara/">renaissancechambara</a></p>

        </div>
    </div>
</section>

<footer>
    <p>&copy; <a href="http://www.cilogi.com">Cilogi</a> Limited 2011</p>
</footer>

</div>
<#include "inc/modal-login-template.ftl">
</body>
<#include "inc/_foot.ftl">
<script>

    function doStatus(spin) {
        shiro.status.runStatus({
            success: function(data, status) {
                spin.stop();
                if (status == 'success') {
                    $("html").removeClass("shiro-none-active");
                    if (data.message == "known") {
                        $("html").removeClass("shiro-guest-active");
                        $("html").addClass("shiro-user-active");
                        $("span.shiro-principal").text(data.name);
                        if (data.authenticated == "true") {
                            $("html").addClass("shiro-authenticated-active");
                        }
                        if (data.admin == "true") {
                            $("html").addClass("shiro-admin-active");
                        }
                    } else {
                        $("html").addClass("shiro-guest-active");
                    }
                    shiro.user = data.name;
                } else {
                    alert("status check failed: " + data.message);
                }
            },
            error: function(xhr) {
                spin.stop();
                alert("can't find status: " + xhr.responseText);
            }
        });
    }

    $(document).ready(function() {
        prettyPrint();
        var spin = shiro.spin.start($("#spinner"));
        doStatus(spin);
    });

    $(document).ready(function() {
        $("#settings").click(function(e) {
            if (!$("html").hasClass("shiro-authenticated-active")) {
                e.preventDefault();
                shiro.login(shiro.userBaseUrl+"/ajaxLogin", function() {
                    window.location.assign("settings.html");
                });
                return false;
            }
        });
        $("#admin").click(function(e) {
            e.preventDefault();
            if ($("html").hasClass("shiro-admin-active")) {
                window.location.assign("listUsers.ftl");
            } else {
                alert("You need admin privileges to view the user list.")
            }
            return false;
        });

        $("#signIn").click(function(e) {
            e.preventDefault();
            navigator.id.request();
            /*
            shiro.login(shiro.userBaseUrl+"/ajaxLogin", function() {
                window.location.reload();
            });
            */
            return false;
        });

        $("#signOut").click(function(e) {
            navigator.id.logout();
            shiro.status.clearStatus();
            return true;
        });

        navigator.id.watch({
          loggedInUser: shiro.user,
          onlogin: function(assertion) {
            // A user has logged in! Here you need to:
            // 1. Send the assertion to your backend for verification and to create a session.
            // 2. Update your UI.
            var spin = shiro.spin.start($("#spinner"));
            $.ajax({ /* <-- This example uses jQuery, but you can use whatever you'd like */
              type: 'POST',
              url: shiro.userBaseUrl+"/ajaxLogin", // This is a URL on your website.
              data: {
                  username: shiro.user,
                  password: assertion,
                  rememberMe: true
              },
              success: function(data, status, xhr) {
                  if (status == 'success') {
                      doStatus(spin);
                  } else {
                      spin.stop();
                      alert("login failed: " + data.message);
                  }
              },
              error: function(res, status, xhr) {
                  spin.stop();
                  alert("login failure" + res);
              }
            });
          },
          onlogout: function() {
            // A user has logged out! Here you need to:
            // Tear down the user's session by redirecting the user or making a call to your backend.
            // Also, make that loggedInUser will get set to null on the next page load.
            // (That's a literal JavaScript null. Not false, 0, or undefined. null.)
            shiro.status.clearStatus();
            /*
            $.ajax({
              type: 'POST',
              url: '/auth/logout', // This is a URL on your website.
              success: function(res, status, xhr) { window.location.reload(); },
              error: function(res, status, xhr) { alert("logout failure" + res); }
            });
            */
          }
        });
    });
</script>
</html>

