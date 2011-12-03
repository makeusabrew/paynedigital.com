<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{block name='title'}{setting value="site.title"}{/block}</title>
    <link rel="stylesheet" href="/css/bootstrap-1.4.0.min.css" />
    <link rel="stylesheet" href="/admin/css/main.css" />
</head>
<body>
    {if isset($messages) && count($messages)}
        <div class='container'>
            {foreach from=$messages item="message"}
                {* other twitter styles are: error, warning, success *}
                <div class="alert-message info">
                    <a class="close" href="#">&times;</a>
                    <p>{$message}</p>
                </div>
            {/foreach}
        </div>
    {/if}
    <div class='topbar'>
        <div class='topbar-inner'>
            <div class='container'>
                <h3><a href='/admin'>Payne Digital - Admin</a></h3>
                <ul class='nav'>
                    <li><a href="/admin">Home</a></li>
                    <li><a href="/admin/posts/add">New Post</a></li>
                    <li><a href="/admin/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class='container'>
        <div class='page-header'>
            <h1>Administration Area</h1>
        </div>
        {block name='body'}
        {/block}
    </div>
    <script src="/js/jquery.min.js"></script>
    {block name='script'}
    {/block}
</body>
</html>
