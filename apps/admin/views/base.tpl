<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{block name='title'}{setting value="site.title"}{/block}</title>
    <link rel="stylesheet" href="/css/bootstrap-1.2.0.min.css" />
    <link rel="stylesheet" href="/css/main.css" />
</head>
<body>
    <div class='topbar'>
        <div class='topbar-inner'>
            <div class='container'>
                <h3><a href='/admin'>Administration</a></h3>
                <ul class='nav'>
                    <li><a href="/admin">Home</a></li>
                </ul>
            </div>
        </div>
    </div>
    {block name='body'}
    {/block}
</body>
</html>
