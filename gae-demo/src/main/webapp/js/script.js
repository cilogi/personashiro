
function goodLogin(data) {
    $("html").removeClass("shiro-none-active");
    if (data.email) {
        $("html").removeClass("shiro-guest-active");
        $("html").addClass("shiro-user-active");
        $("span.shiro-principal").text(data.name);
        if (data.isAdmin == "true") {
            $("html").addClass("shiro-admin-active");
        }
    } else {
        $("html").addClass("shiro-guest-active");
    }
    shiro.user = data.email;
}

function doStatus(spin) {
    console.log("running status");
    shiro.status.runStatus({
        success: function(data) {
            spin.stop();
            goodLogin(data);
        },
        error: function(xhr) {
            spin.stop();
            alert("can't find status: " + xhr.responseText);
        }
    });
}

$(document).ready(function() {
    var spin = null;

    function doBlock() {
        $.blockUI({
            message: null,
            css: {backgroundColor: "transparent", padding: 0, "border-style": "none"},
            overlayCSS: {backgroundColor: "transparent"}
        });
    }

    $(document).ajaxStart(doBlock).ajaxStop($.unblockUI);

    startSpin();
    shiro.status.clearStatus();
    doStatus(spin);


    function stopSpin() {
        if (spin) {
            spin.stop();
            spin = null;
        }
    }

    function startSpin() {
        spin = shiro.spin.start($("#spinner"));
    }

    $("#admin").click(function(e) {
        e.preventDefault();
        startSpin();
        if ($("html").hasClass("shiro-user-active")) {
            window.location.assign("listUsers.ftl");
        } else {
            alert("You need authentication to view the user list.")
        }
        return false;
    });

    $("#signIn").click(function(e) {
        e.preventDefault();
        startSpin();
        navigator.id.request({
            siteName: "Cilogi"
        });
        return false;
    });

    $("#signOut").click(function(e) {
        e.preventDefault();
        startSpin();
        navigator.id.logout();
        shiro.status.clearStatus();
        return false;
    });

    navigator.id.watch({
      onlogin: function(assertion) {
        shiro.status.clearStatus();
        $.ajax({
          type: 'POST',
          url: "/login",
          data: {
              password: assertion,
              rememberMe: true
          },
          dataType: "json",
          cache: false,
          success: function(data, status, xhr) {
              goodLogin(data);
              stopSpin();
          },
          error: function(res, status, xhr) {
              stopSpin();
              navigator.id.logout();
              alert("login failure" + res);
          }
        });
      },
      onlogout: function() {
        shiro.status.clearStatus();

        $.ajax({
          type: 'POST',
          url: '/logout',
          success: function(res, status, xhr) {
              $("html").removeClass("shiro-none-active");
              $("html").removeClass("shiro-user-active");
              $("html").addClass("shiro-guest-active");
              stopSpin();
          },
          error: function(res, status, xhr) {
              stopSpin();
              navigator.id.logout();
              alert("logout failure" + res);
          }
        });
      }
    });
});
