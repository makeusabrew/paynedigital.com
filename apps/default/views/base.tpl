{if !isset($_pjax)}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no" />
    <title>{block name='outer-title'}{block name='title' hide=true}{$smarty.block.child} | {/block}{setting value="site.title"}{/block}</title>

    <link rel="stylesheet" href="{$static_path}/assets/css/style{$assetPath}.min.css" />

    <script src="{$static_path}/assets/js/typekit/fva2awi.js"></script>
    <script>
        var typekitActive = false;
        try {
            Typekit.load({
                active: function() {
                    typekitActive = true;
                }
            });
        } catch (e) {}
    </script>

    <link rel="alternate" type="application/rss+xml" title="Payne Digital RSS Feed" href="{$base_href}feed.xml"/>

    <link rel="shortcut icon" href="{$static_path}/favicon.png">

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
    <div class="header">
        <div class="wrapper header__dolly">

            <form action="/search" method="get" class="search   hide--palm  hide--lap">
                <input type="text" class="search__input" placeholder="Search&hellip;" name="q"{if isset($smarty.get.q)} value="{$smarty.get.q|escape:'html'}"{/if} />
            </form>

            <a class="logo" href="/">
                {block name='logo-extra'}{/block}
                {include file="default/views/includes/logo.tpl"}
            </a>
            <ul class="nav  header__nav">
                <li{if $section eq ""} class="active"{/if}><a class=pjax href="/">Home</a></li>
                <li{if $section eq "about"} class="active"{/if}><a class=pjax href="/about">About</a></li>
                <li{if $section eq "services"} class="active"{/if}><a class=pjax href="/services">Services</a></li>
                <li{if $section eq "work"} class="active"{/if}><a class=pjax href="/work">Work</a></li>
                <li{if $section eq "articles"} class="active"{/if}><a class=pjax href="/articles">Articles</a></li>
                <li{if $section eq "contact"} class="active"{/if}><a class=pjax href="/contact">Contact</a></li>
            </ul>
            <div class="header__camera">
            </div>
        </div>
    </div>
    <div class="inner">
        {block name=content}{/block}
    </div>
    <div class="footer">
        <div class="wrapper cf">
            <div class="footer__copyright">
                &copy; 2010&ndash;2013 Payne Digital Ltd<span class="hide--palm hide--desk">.&nbsp;</span>
            </div>
            <div class="footer__company-info hide--palm">
                Company No. 07277912. VAT No. 991909470.
            </div>
        </div>
    </div>

    <script src="{$static_path}/assets/js/main{$assetPath}.min.js"></script>

    {setting assign="doPlugins" value="site.social_plugins"}
    {if $doPlugins}
    {literal}<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>{/literal}
    {/if}

    <script>
        Gistify.init();

        $(function() {
            pjaxify.init();
            linkify.init();
        });
    </script>
    {block name="script"}{/block}
</body>
</html>
{else}
<title>{block name='outer-title'}{block name='title' hide=true}{$smarty.block.child} | {/block}{setting value="site.title"}{/block}</title>

{block name=content}{/block}

<div style='display:none' class='theme-identifier'>
    {block name="theme"}dark-blue{/block}
</div>
<div style='display:none' class='script'>
    {block name="script"}{/block}
</div>
{/if}
