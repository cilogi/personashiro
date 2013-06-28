shiro.personaWatch =

(function () {
    var currentUser = null,
        isWatching = false;

    function setCurrentUser(name) {
        currentUser = (name == "") ? null : name;
    }

    function getCurrentUser() {
        return currentUser;
    }

    function watch(options) {
        if (!isWatching) {
            doWatch(options);
            isWatching = true;
        }
    }

    function doWatch(options) {
        navigator.id.watch({
            onlogin: function (assertion) {
                if (currentUser) {
                    // login is ignored if currentUser isn't null
                    options.setCSS({email: currentUser});
                } else {
                    postLogin(assertion, options)
                }
            },
            onlogout: function() {
                if (currentUser) {
                    options.setCSS({email: currentUser});
                } else {
                    postLogout(options);
                }
            }
        });
    }

    function postLogin(assertion, options) {
        $.ajax({
            type: 'POST',
            url: "/login",
            data: {
                password: assertion,
                rememberMe: true
            },
            dataType: "json",
            cache: false,
            success: function (data, status, xhr) {
                options.setCSS(data);
                options.finalize();
            },
            error: function (res, status, xhr) {
                options.finalize();
                navigator.id.logout();
                alert("login failure" + res);
            }
        });
    }

    function postLogout(options) {
        $.ajax({
            type: 'POST',
            url: '/logout',
            success: function (res, status, xhr) {
                options.setCSS({email: null});
                options.finalize();
            },
            error: function (res, status, xhr) {
                options.setCSS({email: null});
                options.finalize();
                navigator.id.logout();
                alert("logout failure" + res);
            }
        });
    }

    return {
        getCurrentUser: getCurrentUser,
        setCurrentUser: setCurrentUser,
        watch: watch
    }

})();