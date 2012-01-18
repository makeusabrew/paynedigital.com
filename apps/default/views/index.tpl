{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Web Application &amp; Mobile Development{/block}
{block name='body'}
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    {$smarty.block.parent}
    <h3>The Archive</h3>
    {include file='blog/views/partials/archive.tpl'}
{/block}
