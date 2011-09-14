<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{setting value="site.title"}{if isset($title)}: - {$title}{/if}</title>
</head>
<body>
    {block name="body"}<p>Your body content goes here.</p>{/block}

    {*
      ordinarily body will probably be wrapped with surrounding markup, so it
      makes sense to have a separate block to put script tags in
     *}
    {block name="script"}{/block}
</body>
</html>
