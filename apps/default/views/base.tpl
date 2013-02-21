{if !isset($_pjax)}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{block name='outer-title'}{setting value="site.title"}{block name='title' hide=true}&mdash;{$smarty.block.child}{/block}{/block}</title>

    <script type="text/javascript" src="//use.typekit.net/fva2awi.js"></script>
    <script type="text/javascript">try{ Typekit.load(); }catch(e) { }</script>

    {newrelic section="header"}

    <link rel="alternate" type="application/rss+xml" title="Payne Digital RSS Feed" href="{$base_href}feed.xml"/>

    <link rel="stylesheet" href="/css/style.min.css" />
    <link rel="shortcut icon" href=/favicon.png>

    {block name="head"}{/block}

    {setting value="analytics.enabled" assign="stats_enabled"}
    {if $stats_enabled}
        <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', '{setting value="analytics.account_no"}']);
            _gaq.push(['_setDomainName', 'none']);
            _gaq.push(['_setAllowLinker', true]);
            _gaq.push(['_trackPageview']);
            _gaq.push(['_trackPageLoadTime']);

            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();

        </script>
    {/if}
</head>
<body class="theme theme--{block name="theme"}dark-blue{/block}">
    <header class="header">
        <div class="wrapper">
            <a class="logo" href="/">
                <img src="/img/placeholder-mono.png" alt="Payne Digital Ltd" height="75" />
            </a>
            <div class="header__dolly">
                <ul class="nav  header__nav">
                    <li{if $current_url == "/"} class="active"{/if}><a class=pjax href="/">Home</a></li>
                    <li{if $current_url == "/about"} class="active"{/if}><a class=pjax href="/about">About</a></li>
                    <li{if $current_url == "/services"} class="active"{/if}><a class=pjax href="/services">Services</a></li>
                    <li{if $current_url == "/articles"} class="active"{/if}><a class=pjax href="/articles">Articles</a></li>
                    <li{if $current_url == "/contact"} class="active"{/if}><a class=pjax href="/contact">Contact</a></li>
                </ul>
                <div class="header__camera">
                </div>
            </div>
        </div>
        {*
        <form action="/search" method="get">
            <input type="text" placeholder="Search" name="q"{if isset($smarty.get.q)} value="{$smarty.get.q|escape:'html'}"{/if} />
        </form>
        *}
    </header>
    <div class="inner">
        <div class="wrapper">

            <h1 class="hero">{block name='heading'}Payne Digital Ltd{/block}</h1>

            <div class="gw">
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
                        {include file="default/views/includes/intro.tpl"}
                    {/block}
                </div>
            </div>
        </div>
    </div>
    <footer class="footer">
        <div class="wrapper">
            <span class="footer__copyright">
                &copy; 2013 Payne Digital Ltd
            </span>
            <span class="footer__company-info">
                Moorland Avenue, Leeds, LS20 9EQ.
                <span class="supplementary">Company No. 07277912. VAT No. 991909470.</span>
            </span>
        </div>
    </footer>

    {setting assign="doPlugins" value="site.social_plugins"}

    <script src="/js/jquery.min.js"></script>
    <script src="/js/jquery.pjax.js"></script>
    <script src="/js/pjaxify.js"></script>
    <script src="/js/linkify.js"></script>
    {if $doPlugins}
        <script src="http://platform.twitter.com/widgets.js"></script>
    {/if}
    <script>
        $(function() {
            pjaxify.init();
            linkify.init();
        });
    </script>
    {block name="script"}{/block}

    {newrelic section="footer"}
</body>
</html>
{else}
<title>{block name='outer-title'}{setting value="site.title"}{block name='title' hide=true}&mdash;{$smarty.block.child}{/block}{/block}</title>

<h1 class="hero">{block name='heading'}Payne Digital Ltd{/block}</h1>

<div class="gw">
    <div class="g two-thirds">
        {block name="body"}{/block}
    </div>
    <div class="g one-third">
        {block name="secondary"}
            {include file="default/views/includes/intro.tpl"}
        {/block}
    </div>
</div>
<div style='display:none' class='theme-identifier'>
    {block name="theme"}dark-blue{/block}
</div>
<div style='display:none' class='script'>
    {block name="script"}{/block}
</div>
{/if}
