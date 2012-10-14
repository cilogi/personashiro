# A demonstration of Apache Shiro running on Google App Engine with Mozilla Persona

App Engine comes with a very good identity solution (the <code>User
Service</code>), based on Google Login.  The API is very simple and it
solves the authentication and authorization problem for a lot of
applications elegantly.

There are two problems with the `User Service`.

* It is restricted to users with Google accounts.  A significant
  number of potential users may not wish to register for a Google
  Account just to use a single application. OpenID logins are
  available, but this is not a general solution at present.
* The authorization model, having users and admins and allowing access
  to selected resources only to admins is too restrictive for many
  applications.

We are providing an identity and authorization solution for Java on
App Engine which is as easy to code with as the <code>User
Service</code> but which allows anyone with an Email account to log in
to applications, and which provides a more sophisticated authorization
model.  The solution makes use of [http://shiro.apache.org](Shiro
security) and
[Mozilla Persona](http://www.mozilla.org/en-US/persona/).

## How does it work?

You include some JavaScript code on the client side.  This is
described [https://developer.mozilla.org/en-US/docs/Persona](here).
The  user is asked for Email address (and possibly password) on the
client side, and when logged in a token is provided which you send to
the server and verify with a call to a secure address.  The
verification step returns an Email which you use as the identity of
the User.

Our interface requires you to make one call which looks like this:

    PersonaAuthenticationToken personaToken 
        = new PersonaAuthenticationToken(token, <host:port>, true);
    personaLogin.login(personaToken);

where _host_ and _port_ are the hard-coded host name and port of your
server. 

Once this is done Shiro takes care of everything.  To find the current
user for example just use the following code anywhere:

    Subject subject = SecurityUtils.getSubject();
    String emailAddress = (String)subject.getPrincipal();

The simplest way to configure Shiro is to create a _shiro.ini_
file. Our micro demo provides a simple example.

    [main]
    shiro.loginUrl = /login
    personaRealm = com.cilogi.shiro.microdemo.MicroPersonaRealm
    securityManager.realms = $personaRealm

    [users]
    tim.niblett@cilogi.com = password, admin

    [roles]
    admin = *

    [urls]
    /login = authc
    /sensitive.html = authc
    /onlyadmin.html = authc, roles[admin]
    /logout = logout

In the `[main]` section the line `shiro.loginUrl = /login` defines the URL to which
unauthorised requests (and other login requests) are redirected.  The
line defining `personaRealm` says that we're Persona to
authenticate. The next line installs the `PersonaRealm`as the security
realm.

The `[urls]` section is similar to the security constraints used by the
_User Service_ as defined in `web.xml`.  The `authc` filter says
that a user must be authenticated _in this session_ to access the
resource.  A laxer filter is `user` which also allows a user who has
is _remembered_ via a cookie in the browser.

The `[users]` and `[roles]` section together state that only
`tim.niblett@cilogi.com` can access _admin_ level resources of which
`onlyadmin.html` is the example shown here.

These capabilities duplicate those of the built-in _User Service_ but
allow for any email address and for more sophisticated authorization
if you so desire.

## Setting up the demo

Once you've downloaded the demo you can use `maven` to set it
up. There are 3 modules: _persona-shiro_ is the library which
interfaces Persona with Shiro; _gae-demo_ shows how _perona-shiro_ can
be integrated App Engine, and includes some basic user handling

## Please give feedback

This solution isn't ready for prime time yet as Persona is still in
beta, and has a long way to go.  For those who us who'd like to
integrate a lighweight identity and authorization system without the
nightmare of dealing with user and password management it looks like a
good bet.  Certainly the more of us that use it the better.


