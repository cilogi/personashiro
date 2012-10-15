<#assign title="Protected resource">
<#assign style="substyle.css">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">    
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
                <h1>Protected
                    <small>resource</small>
                </h1>
            </div>
            <div class="row">
                <div class="span3">
                    &nbsp;
                 </div>
               <div class="span6">
                   <p class="lead">This is a protected resource.  Only accessible to those
                                   who are authorised in this session.</p>
                </div>
                <div class="span3">
                    &nbsp;
                 </div>
            </div>
        </section>
    </div>
</div>
<#include "inc/copyright.ftl">
<#include "inc/_foot.ftl">
</body>
</html>
