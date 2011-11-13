{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Feed{/block}
{block name='body'}
    <h1>Welcome to your new application!</h1>
    <p>You've created a new application which can be found in <code>/var/www/nick/paynedigital.com/apps/feed</code>.</p>

    <p>Your application has been created with a basic controller with one action (this one). It
    can be found at <code>/var/www/nick/paynedigital.com/apps/feed/controllers/feed.php</code>.</p>

    <p>You can edit this template at <code>/var/www/nick/paynedigital.com/apps/feed/views/index.tpl</code>.</p>

    <p>You can add, edit and remove this path from the paths file located at <code>/var/www/nick/paynedigital.com/apps/feed/paths.php</code>.</p>

    {/block}
