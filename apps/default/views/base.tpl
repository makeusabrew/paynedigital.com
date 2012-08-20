{if !isset($_pjax)}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{block name='title'}{setting value="site.title"}{/block}</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/bootstrap.min.responsive.css" />
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="https://gist.github.com/stylesheets/gist/embed.css" />
    <link rel="alternate" type="application/rss+xml" title="Payne Digital RSS Feed" href="{$base_href}feed.xml"/>

    <link rel="shortcut icon" href=/favicon.png>
    {block name="head"}{/block}
    {include file='default/views/helpers/google_analytics.tpl'}
</head>
<body class='{block name="theme"}default{/block}'>
    <div class='navbar navbar-fixed-top'>
        <div class='navbar-inner'>
            <div class='container'>
                <a href='/' class=brand>Payne Digital</a>
                <a class="no-pjax btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="nav-collapse">
                    <ul class='nav'>
                        <li{if $current_url == "/"} class="active"{/if}><a href="/">Home</a></li>
                        <li{if $current_url == "/about"} class="active"{/if}><a href="/about">About</a></li>
                        <li{if $current_url == "/services"} class="active"{/if}><a href="/services">Services</a></li>
                        <li{if $current_url == "/articles"} class="active"{/if}><a href="/articles">Articles</a></li>
                        <li{if $current_url == "/contact"} class="active"{/if}><a href="/contact">Contact</a></li>
                    </ul>
                    <form action="/search" method="get" class="navbar-search pull-right supplementary">
                        <input type="text" class="search-query" placeholder="Search" name="q"{if isset($smarty.get.q)} value="{$smarty.get.q|escape:'html'}"{/if} />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div id='header'>
        <div class='container'>
            <h1>Web, Mobile, Apps &amp; Games.<span class='supplementary'> Whatever you need, we can build it.</span></h1>
        </div>
    </div>
    <div class='container'>
        <div id='inner' class='row'>
            {if isset($messages) && count($messages)}
                <div class='container'>
                    {foreach from=$messages item="message"}
                        {* other twitter styles are: error, warning, success *}
                        <div class="alert alert-info">
                            <a class="close" href="#">&times;</a>
                            <p>{$message}</p>
                        </div>
                    {/foreach}
                </div>
            {/if}
            <div class='span8'>
                {block name="body"}
                    <p>Your body content goes here.</p>
                {/block}
            </div>
            <div class='span4'>
                {block name="secondary"}
                    <div class='supplementary'>
                        <p>
                            <b>Hello!</b> Payne Digital make all sorts of things - from <a href="https://github.com/makeusabrew/paynedigital.com">websites</a>
                            (like this one),
                            web apps, mobile apps &amp; games all the way through to more <a href="https://github.com/makeusabrew/arduinode">experimental</a>
                            <a href="https://github.com/makeusabrew/goursome">demos</a> using cutting edge <a href="http://nodejs.org">software</a> and <a href="http://arduino.cc">hardware</a>.
                        </p>
                        <p>We're a young company, but don't let that put you off. We're enthusiastic and can
                        probably <a href="/services">offer you</a> more than you think.</p>
                    </div>
                {/block}
            </div>
        </div>
    </div>
    <div id='footer'>
        <div class='well'>
            <span class='copyright'>
                &copy; 2012 Payne Digital Ltd
            </span>
            <span class='company-info'>
                13 Moorland Avenue, Leeds, LS20 9EQ.
                <span class='supplementary'>Company No. 07277912. VAT No. 991909470.</span>
            </span>
        </div>
    </div>

    {setting assign="doPlugins" value="site.social_plugins"}

    <script src="/js/jquery.min.js"></script>
    <script src="/js/jquery.pjax.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/pjaxify.js"></script>
    {if $doPlugins}
        <script src="http://platform.twitter.com/widgets.js"></script>
    {/if}
    <script>
        $(function() {
            pjaxify.init();
        });
    </script>
    {block name="script"}{/block}
</body>
</html>
{else}
<title>{block name='title'}{setting value="site.title"}{/block}</title>
<div class='span8'>
    {block name="body"}{/block}
</div>
<div class='span4'>
    {block name="secondary"}
        <div class='supplementary'>
            <p>
                <b>Hello!</b> Payne Digital make all sorts of things - from <a href="https://github.com/makeusabrew/paynedigital.com">websites</a>
                (like this one),
                web apps, mobile apps &amp; games all the way through to more <a href="https://github.com/makeusabrew/arduinode">experimental</a>
                <a href="https://github.com/makeusabrew/goursome">demos</a> using cutting edge <a href="http://nodejs.org">software</a> and <a href="http://arduino.cc">hardware</a>.
            </p>
            <p>We're a young company, but don't let that put you off. We're enthusiastic and can
            probably <a href="/services">offer you</a> more than you think.</p>
        </div>
    {/block}
</div>
<div style='display:none' class='theme'>
    {block name="theme"}default{/block}
</div>
<div style='display:none' class='script'>
    {block name="script"}{/block}
</div>
{/if}
