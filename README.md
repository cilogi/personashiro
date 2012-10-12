# A demonstration of Apache Shiro running on Google App Engine with Mozilla Persona

App Engine comes with a very good identity solution (the <code>User
Service</code>), based on Google Login.  The API is very simple and it
solves the authentication and authorization problem for a lot of
applications very simply.

There are two potential problems with the <code>User Service</code>.

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




A demonstration which shows one way of integrating
[http://shiro.apache.org](Shiro security) with
[http://code.google.com/appengine](App Engine) and
[http://code.google.com/p/google-guice](Google Guice), running under
[Mozilla Persona](http://www.mozilla.org/en-US/persona/).

The demo, running on App Engine, can be found
[here](http://personashiro.appspot.com).
