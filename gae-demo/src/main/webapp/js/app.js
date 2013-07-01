define(['jquery', 'spin', 'status', 'personaWatch', 'log', 'jquery.blockUI', 'persona'], function ($, spinner, runStatus, personaWatch, log) {
    var spin = null;

    function stopSpin() {
        if (spin) {
            spin.stop();
            spin = null;
        }
    }

    function startSpin() {
        spin = spinner.start($("#spinner"));
    }

    function setCSS(data) {
        var html = $("html");
        html.removeClass("shiro-none-active");
        if (data.email) {
            html.removeClass("shiro-guest-active");
            html.addClass("shiro-user-active");
            $("span.shiro-principal").text(data.email);
            if (data.isAdmin == "true") {
                html.addClass("shiro-admin-active");
            }
        } else {
            html.removeClass("shiro-user-active");
            html.removeClass("shiro-admin-active");
            html.addClass("shiro-guest-active");
        }
    }

    function doBlock() {
        $.blockUI({
            message: null,
            css: {backgroundColor: "transparent", padding: 0, "border-style": "none"},
            overlayCSS: {backgroundColor: "transparent"}
        });
    }

    function init() {

        $(document).ajaxStart(doBlock).ajaxStop($.unblockUI);

        startSpin();

        runStatus({
            success: function(data) {
                var email = data.email;
                personaWatch.setCurrentUser(email);
                personaWatch.watch({setCSS: setCSS, finalize: stopSpin});
                setCSS({email: email});
                stopSpin();
            },
            error: function(xhr) {
                log("Can't get status");
                stopSpin();
                setCSS({email: null})
                navigator.id.logout();
            }
        });

        $("#admin").click(function (e) {
            e.preventDefault();
            startSpin();
            if ($("html").hasClass("shiro-user-active")) {
                window.location.assign("listUsers.ftl");
            } else {
                alert("You need authentication to view the user list.")
            }
            return false;
        });

        $("#signIn").click(function (e) {
            e.preventDefault();
            startSpin();
            personaWatch.setCurrentUser(null);
            navigator.id.request({
                siteName: "Cilogi"
            });
            return false;
        });

        $("#signOut").click(function (e) {
            e.preventDefault();
            startSpin();
            personaWatch.setCurrentUser(null);
            navigator.id.logout();
            return false;
        });

    };

    return init;

});