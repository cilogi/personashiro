<#assign title="Shiro and Persona on GAE">
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
            <a class="brand" href="#">PersonaShiro</a>
            <ul class="nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#motivation">Motivation</a></li>
                <li><a href="#persona">Persona</a></li>
                <li><a href="#shiro">Shiro</a></li>
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

            <p>Persona is an interesting take on identity management.</p>

            <p>Shiro is good for authorization and
                we've done the needed porting, and
                provided some simple user management.</p>
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
                flexible if you ever need it.</p>
       </div>
    </div>
</section>

<section id="persona">
    <div class="page-header">
        <h1>Interfacing Persona
            <small>step by step</small>
        </h1>
    </div>
    <div class="row">
        <div class="span4">
            <h2>In Brief</h2>

            <p><a href="http://www.mozilla.org/persona">Persona</a> is a new initiative by Mozilla to provide simple identity
                management based on Email addresses.</p>
        </div>
        <div class="span9">
            <p>Persona does most of its work in JavaScript, on the client, communicating with the identity server using an
                <code>iframe</code>.  An identity <em>assertion</em> is generated
               client-side which contains all the information required to authenticate.  The assertion is passed
               from the browser to the server.  The server  verifies this assertion (with Mozilla at the moment) and
               receives back information including the verified Email associated with the token.</p>
            <p> We have provided a lightweight interface to Shiro for the token and its verification.</p>
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
            <p>Adaptation of the Shiro realm, token, and authentication classes to Persona
               are straightforward.  Control flow is simple, a token is received and if verified,
               the user is extracted and we can login.</p>
            <p>For the demo we have also introduced a user class, <code>GaeUser</code> which can
               be stored in the App Engine datastore.  We've also provided a simple way to list users.</p>
            <p>In keeping with the simple setup of App Engine's user service the demo allows any user
               in the <code>shiro.ini</code> setup file to be an admin.</p>
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
            <p>The <code>com.cilogi.shiro.gae</code>, <code>com.cilogi.shiro.persona</code>
               and <code>com.cilogi.shiro.aop</code> packages should
               be easily re-usable.  There are dependencies on Shiro, Objectify and Guava.  The Guava
               dependency could be removed with a little effort, Objectify somewhat more.</p>
            <p>The servlets in <code>com.cilogi.shiro.web</code> have parameters hard-wired and no
               I18N for strings, but the logic is re-usable.</p>
            <p>The image of the lock is by 
               <a href="http://www.flickr.com/photos/renaissancechambara/">renaissancechambara</a></p>

        </div>
    </div>
</section>
</div>
<#include "inc/copyright.ftl">
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
        shiro.status.clearStatus();
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
            if ($("html").hasClass("shiro-user-active")) {
                window.location.assign("listUsers.ftl");
            } else {
                alert("You need authentication to view the user list.")
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
            shiro.status.clearStatus();
            $.ajax({ /* <-- This example uses jQuery, but you can use whatever you'd like */
              type: 'POST',
              url: shiro.userBaseUrl+"/ajaxLogin", // This is a URL on your website.
              data: {
                  password: assertion,
                  rememberMe: true
              },
              cache: false,
              success: function(data, status, xhr) {
                  if (status == 'success') {
                      doStatus(spin, false);
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
            
            $.ajax({
              type: 'POST',
              url: '/logout', // This is a URL on your website.
              success: function(res, status, xhr) {},
              error: function(res, status, xhr) { alert("logout failure" + res); }
            });

          }
        });
    });
</script>
</html>

