<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cilogi.shiro.microdemo.JSPAssist" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String user = JSPAssist.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Micro Demo</title>
</head>
<style>
    .hide {
        display: none;
    }
<</style>
<body>




<h1>Micro demo</h1>
<p>With the micro demo you can login, logout and access a sensitive resource, <code>sensitive.html</code></p>
<p>When you are logged in we show you your name.</p>
<p>If you try to access the sensitive resource, either directly in the browser bar, or via the link, then
   you'll need to be logged in, and you'll get a login dialog when you try.</p>
<p><button id="login" class="hide">Login</button>
   <span id="logout-span" class="hide"><button id="logout">Logout</button> <span id="name">${fn:escapeXml(user)}</span></span></p>
<p><a href="sensitive.html">sensitive resource you need to be logged in to access</a></p>
<p><a href="onlyadmin.html">sensitive resource you need to be logged in to <em>and</em> with admin privileges to access</a></p>
<p>The full-bore demo <a href="http://personashiro.appspot.com">here</a> show more capabilities of Shiro and Persona,
   and looks better to boot.</p>
<p>You can find more information at the <a href="https://github.com/cilogi/personashiro">PersonaShiro on GitHub</a> site</p>
</body>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://login.persona.org/include.js"></script>
<script src="js/postGet.js"></script>

<script>
    $(document).ready(function() {
        function log() {
            if((typeof console !== 'undefined')) {
                console.log(Array.prototype.slice.call(arguments, 0));
            }
        }

        $("#login").click(function() {
            navigator.id.request();
        });

        $("#logout").click(function() {
            navigator.id.logout();
        });

        navigator.id.watch({
          onlogin: function(assertion) {
            $.ajax({
              type: 'POST',
              url: '/login',
              data: {token: assertion},
              success: function(res, status, xhr) {
                  log("success posting to login");
                  $("#name").text(res);
                  $("#logout-span").removeClass("hide");
                  $("#login").addClass("hide");
[]              },
              error: function(res, status, xhr) {
                  alert("login failure" + res);
              }
            });
          },

          onlogout: function() {
            $.ajax({
              type: 'POST',
              url: '/logout',
              success: function(res, status, xhr) {
                  log("success posting to logout");
                  $("#logout-span").addClass("hide");
                  $("#login").removeClass("hide");
              },
              error: function(res, status, xhr) {
                  alert("logout failure" + res);
              }
            });
          }
        });
    });
</script>
</html>