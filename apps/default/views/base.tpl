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
        <div class="wrapper header__dolly">
            <a class="logo" href="/">
                <img src="/img/placeholder-mono.png" alt="Payne Digital Ltd" height="75" width="72" />
            </a>
            <ul class="nav  header__nav">
                <li{if $current_url == "/"} class="active"{/if}><a class=pjax href="/">Home</a></li>
                <li{if $current_url == "/about"} class="active"{/if}><a class=pjax href="/about">About</a></li>
                <li{if $current_url == "/services"} class="active"{/if}><a class=pjax href="/services">Services</a></li>
                <li{if $current_url == "/work"} class="active"{/if}><a class=pjax href="/work">Work</a></li>
                <li{if $current_url == "/articles"} class="active"{/if}><a class=pjax href="/articles">Articles</a></li>
                <li{if $current_url == "/contact"} class="active"{/if}><a class=pjax href="/contact">Contact</a></li>
            </ul>
            <div class="header__camera">
            </div>
        </div>
        {*
        <form action="/search" method="get">
            <input type="text" placeholder="Search" name="q"{if isset($smarty.get.q)} value="{$smarty.get.q|escape:'html'}"{/if} />
        </form>
        *}
    </header>
    <div class="inner">
        {block name=content}{/block}
    </div>
    <footer class="footer">
        <div class="wrapper cf">
            <div class="footer__copyright">
                &copy; 2013 Payne Digital Ltd<span class="hide--palm hide--desk">.&nbsp;</span>
            </div>
            <div class="footer__company-info hide--palm">
                Moorland Avenue, Leeds, LS20 9EQ.
                Company No. 07277912. VAT No. 991909470.
            </div>
        </div>
    </footer>


    <script src="/js/jquery.min.js"></script>

    {strip}
    {asset type="js" add="apps/default/assets/js/deps/jquery.pjax.js"}
    {asset type="js" add="apps/default/assets/js/pjaxify.js"}
    {asset type="js" add="apps/default/assets/js/linkify.js"}
    {asset type="js" add="apps/default/assets/js/forms.js"}
    {asset type="js" add="apps/blog/assets/js/gistify.js"}
    {asset type="js" file="base" min=true}
    {/strip}


    {setting assign="doPlugins" value="site.social_plugins"}
    {if $doPlugins}
        <script src="http://platform.twitter.com/widgets.js"></script>
    {/if}

    <script>
        Gistify.init();

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

{block name=content}{/block}

<div style='display:none' class='theme-identifier'>
    {block name="theme"}dark-blue{/block}
</div>
<div style='display:none' class='script'>
    {block name="script"}{/block}
</div>
{/if}
