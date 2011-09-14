<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{block name='title'}{setting value="site.title"}{/block}</title>
    <link rel="stylesheet" href="http://twitter.github.com/bootstrap/assets/css/bootstrap-1.2.0.min.css" />
    <link rel="stylesheet" href="/css/main.css" />
</head>
<body>
    <div id='header'>
        <div class='container'>
            <h1>Payne Digital Ltd</h1>
            <p>Web Application &amp; Mobile Development</p>
        </div>
    </div>
    <div class='topbar'>
        <div class='topbar-inner'>
            <div class='container'>
                <h3><a href='/'>Payne Digital</a></h3>
                <ul class='nav'>
                    <li><a href="/">Home</a></li>
                    <li><a href="/about">About</a></li>
                    <li><a href="/services">Services</a></li>
                    <li><a href="/contact">Say Hello</a></li>
                    <form action="/search" method="get">
                        <input type="text" placeholder="Search" name="q" />
                    </form>
                </ul>
            </div>
        </div>
    </div>
    <div class='container'>
        {block name="body"}
            <p>Your body content goes here.</p>
        {/block}
    </div>

    {*
      ordinarily body will probably be wrapped with surrounding markup, so it
      makes sense to have a separate block to put script tags in
     *}
    {block name="script"}{/block}
</body>
</html>
