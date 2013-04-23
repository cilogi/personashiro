<#assign title="PersonaShiro Login">
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
            <a class="brand" href="/index.html">PersonaShiro</a>
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
                        <label for="password">Password</label>

                        <div class="input">
                            <input class="required xlarge" id="password" name="password" size="30" type="password"/>
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
</div>
<#include "inc/copyright.ftl">
<#include "inc/_foot.ftl">

<script>
$(document).ready(function() {

    navigator.id.watch({
      loggedInUser: shiro.user,
      onlogin: function(assertion) {
        $("#password").val(assertion);
        $("#rememberMe").prop('checked', true);
        $("#loginForm").submit();
     },
        onlogout: function() {
            shiro.status.clearStatus();
        }
    });
    navigator.id.request();

});
</script>

</body>
</html>
