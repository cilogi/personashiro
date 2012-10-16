# Persona and Shiro demo

A demo to show how to use Mozilla [Persona](https://login.persona.org/)
for identity and [Apache Shiro](http://shiro.apache.org/) for
authorization.

The code can be used in any servlet-based application. We are targeting App Engine.
The aim is to be as simple to use
as the built-in user service but to provide more authorization features.

There is a dependency on the [base library](https://github.com/cilogi/personashiro/tree/master/base) which should
be installed via Maven before running the demo.

## Detailed instructions

* Clone the repository at [https://github.com/cilogi/personashiro](https://github.com/cilogi/personashiro) to your local machine
* cd base; mvn install
* cd ../micro-demo; mvn install jetty:run
* Load page localhost:8080 into browser.  Play.

There is a fuller demo, with a better interface [here](http://personashiro.appspot.com/). The code is included in this repo
in the _gae-demo_ sub-module.





