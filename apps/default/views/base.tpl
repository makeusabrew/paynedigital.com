{if !isset($_pjax)}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{block name='outer-title'}{setting value="site.title"}{block name='title' hide=true}&mdash;{$smarty.block.child}{/block}{/block}</title>
    {newrelic section="header"}
    {*
    no gist CSS for now, needs a rethink
    <link rel="stylesheet" href="https://gist.github.com/stylesheets/gist/embed.css" />
    *}
    <link rel="alternate" type="application/rss+xml" title="Payne Digital RSS Feed" href="{$base_href}feed.xml"/>

    <link rel="stylesheet" href="/css/style.min.css" />
    <link rel="shortcut icon" href=/favicon.png>
    {block name="head"}{/block}
    {include file='default/views/helpers/google_analytics.tpl'}
</head>
<body class='theme theme--{block name="theme"}default{/block}'>
    <div class="wrapper">
        <header>
            <ul class='nav'>
                <li{if $current_url == "/"} class="active"{/if}><a class=pjax href="/">Home</a></li>
                <li{if $current_url == "/about"} class="active"{/if}><a class=pjax href="/about">About</a></li>
                <li{if $current_url == "/services"} class="active"{/if}><a class=pjax href="/services">Services</a></li>
                <li{if $current_url == "/articles"} class="active"{/if}><a class=pjax href="/articles">Articles</a></li>
                <li{if $current_url == "/contact"} class="active"{/if}><a class=pjax href="/contact">Contact</a></li>
            </ul>
            <form action="/search" method="get">
                <input type="text" placeholder="Search" name="q"{if isset($smarty.get.q)} value="{$smarty.get.q|escape:'html'}"{/if} />
            </form>
        </header>

        {* @todo make this per-page *}
        <h1>Web, Mobile, Apps &amp; Games.<span class='supplementary'> Whatever you need, we can build it.</span></h1>

        <div class="gw inner">
            {if isset($messages) && count($messages)}
                {foreach from=$messages item="message"}
                    {* other twitter styles are: error, warning, success *}
                    <div class="alert alert-info">
                        <a class="close" href="#">&times;</a>
                        <p>{$message}</p>
                    </div>
                {/foreach}
            {/if}
            <div class="g two-thirds">
                {block name="body"}
                    <p>Your body content goes here.</p>
                {/block}
            </div>
            <div class="g one-third">
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
    <footer class="footer">
        <span class="footer__copyright">
            &copy; 2013 Payne Digital Ltd
        </span>
        <span class="footer__company-info">
            Moorland Avenue, Leeds, LS20 9EQ.
            <span class="supplementary">Company No. 07277912. VAT No. 991909470.</span>
        </span>
    </footer>

    {setting assign="doPlugins" value="site.social_plugins"}

    <script src="/js/jquery.min.js"></script>
    <script src="/js/jquery.pjax.js"></script>
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

    {newrelic section="footer"}
</body>
</html>
{else}
<title>{block name='outer-title'}{setting value="site.title"}{block name='title' hide=true}&mdash;{$smarty.block.child}{/block}{/block}</title>
<div class="g two-thirds">
    {block name="body"}{/block}
</div>
<div class="g one-third">
    {block name="secondary"}
        <div class="supplementary">
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
<div style='display:none' class='theme-identifier'>
    {block name="theme"}default{/block}
</div>
<div style='display:none' class='script'>
    {block name="script"}{/block}
</div>
{/if}
