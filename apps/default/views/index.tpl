{extends file='default/views/base.tpl'}
{block name='body'}
    {foreach from=$posts item="post" name="posts"}
        <div class='post'>
            {include file='blog/views/partials/post.tpl'}
        </div>
    {/foreach}
{/block}
