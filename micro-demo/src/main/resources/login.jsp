<!DOCTYPE html>
<html>
<head>
    <title>Micro Demo Login page</title>
</head>

<body>

<h1>Logging you in</h1>
<p>Please wait a moment.</p>

<form id="loginForm" method="POST" action="" style="display:none">
    <fieldset>
       <div class="clearfix">
            <label for="token">Token</label>

            <div class="input">
                <input class="required xlarge" id="token" name="token" size="30" type="password"/>
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

<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://login.persona.org/include.js"></script>

<script>
    $(document).ready(function() {
        navigator.id.request();

        navigator.id.watch({
          onlogin: function(assertion) {
            $("#token").val(assertion);
            $("#rememberMe").prop('checked', true);
            $("#loginForm").submit();
          },
          onlogout: function() {
             shiro.status.clearStatus();
          }
        });
    });
</script>
</html>