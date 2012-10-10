<#assign title="Shiro on GAE Login">
<#assign style="substyle.css">

<!DOCTYPE html>
<html lang="en">
<head>
    <#include "inc/_head.ftl">
</head>

<body>

<div class="topbar">
    <div class="topbar-inner">
        <div class="container">
            <a class="brand" href="/index.html">Shiro on GAE</a>
            <ul class="nav">
                <li class="active"><a href="/index.html">Home</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="container">

    <div class="content">
        <section>
            <div class="page-header">
                <h1>Login
                    <small>to the Shiro GAE demo</small>
                </h1>
            </div>
            <div class="row">
                <div class="span3">
                    &nbsp;
                 </div>
               <div class="span6">
                   <p class="lead">You need to login during this session in order to access
                                   sensitive data.  Your current login information is remembered
                                   from an old session, so isn't very secure.</p>
                </div>
                <div class="span3">
                    &nbsp;
                 </div>
            </div>
            <form id="loginForm" method="POST" action="" style="display:none">
                <fieldset>
                    <div class="clearfix">
                        <label for="username">Email Address</label>
                        <div class="input">
                            <input class="required email xlarge" id="username" name="username" value="tim.niblett@cilogi.com"
                                   size="30" type="text"/>
                        </div>
                    </div>
                    <div class="clearfix">
                        <label for="password">Password</label>

                        <div class="input">
                            <input class="required xlarge" id="password" name="password" size="30" type="password" value="password"/>
                        </div>
                    </div>
                  <!-- /clearfix -->
                    <div class="clearfix">
                        <label for="rememberMe" style="padding-top: 0;">Remember me</label>
                        <div class="input">
                            <input id="rememberMe" name="rememberMe" type="checkbox" selected="true"/>
                        </div>
                    </div>
                </fieldset>
                <div class="actions">
                    <button id="modalLogin" type="submit" class="btn primary">Login</button>
                </div>
            </form>
        </section>
    </div>

    <footer>
        <p>&copy; Cilogi Limited 2012</p>
    </footer>

</div>
<#include "inc/copyright.ftl">
<#include "inc/_foot.ftl">

<script>
$(document).ready(function() {
    navigator.id.logout();
    navigator.id.request();

    navigator.id.watch({
      loggedInUser: shiro.user,
      onlogin: function(assertion) {
        // A user has logged in! Here you need to:
        // 1. Send the assertion to your backend for verification and to create a session.
        // 2. Update your UI.
        $("#username").val(shiro.user || "user@foo.com");
        $("#password").val(assertion);
        $("#rememberMe").prop('checked', true);
        $("#loginForm").submit();
        /*
        $.ajax({
          type: 'POST',
          url: '/login.jsp', // This is a URL on your website.
          data: {
              username: shiro.user,
              password: assertion,
              rememberMe: true
          },
          success: function(data, status, xhr) {
              if (status == 'success') {
                  console.log("succeeded in posting data");
              } else {
                  alert("login failed: " + data.message);
              }
          },
          error: function(res, status, xhr) {
              alert("login failure" + res);
          }
        });
        */
      },
        onlogout: function() {
            shiro.status.clearStatus();
        }
    });


});
</script>

</body>
</html>
