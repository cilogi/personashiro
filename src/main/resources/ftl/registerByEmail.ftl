<#assign title="Shiro on GAE Register by Email">
<#assign header="<h1>Register <small>your account by Email</small></h1>">
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
                ${header}
            </div>
            <div class="row">
                <div class="span12">
                    <form id="passwordSetForm" action="${userBaseUrl}/confirm" method="POST">
                        <fieldset>
                            <div class="input">
                                <input id="username" name="username" value="${RequestParameters.username}" type="hidden"/>
                            </div>
                            <legend>Please fill in the password and the retype field</legend>
                            <div class="clearfix">
                                <label for="confirmCode">Code received</label>

                                <div class="input">
                                    <input class="required xlarge" id="confirmCode" name="confirmCode"
                                           size="40" type="text" value="${RequestParameters.code}" disabled/>
                                </div>
                            </div>
                            <div class="clearfix">
                                <label for="password">Password</label>
                                <div class="input">
                                    <input class="required xlarge" id="password" name="password" size="30" type="password"/>
                                </div>
                            </div>
                            <!-- /clearfix -->
                            <div class="clearfix">
                                <label for="checkPassword">Retype Password</label>
                                <div class="input">
                                    <input class="xlarge" id="checkPassword" name="checkPassword" size="30"
                                           type="password"/>
                                </div>
                            </div>
                            <!-- /clearfix -->
                        </fieldset>
                        <div class="actions" id="resetButton">
                            <#if RequestParameters.forgot??>
                              <button id="register" type="submit" class="btn primary">Reset</button>
                             <#else>
                               <button id="register" type="submit" class="btn primary">Register</button>
                            </#if>
                        </div>
                    </form>

                </div>
            </div>
            <div class="row" id="stage3" style="display:none">
                <div class="span12">
                <#if RequestParameters.forgot??>
                  <p>Your password has been reset</p>
                 <#else>
                   <p>You have been registered</p>
                </#if>
                </div>
            </div>
        </section>
    </div>

    <footer>
        <p>&copy; Cilogi Limited 2011</p>
    </footer>

</div>


<#include "inc/modal-login-template.ftl" parse="false">

<#include "inc/_foot.ftl">

<script src="js/register.js"></script>

<script>
    shiro.forgot = false;
    $(document).ready(function() {
        $("#passwordSetForm").submit(function() {
            shiro.status.clearStatus();
        });    
    });
</script>


</body>
</html>
