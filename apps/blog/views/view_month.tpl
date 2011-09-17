{extends file='default/views/base.tpl'}
{block name='body'}
    <div class='page-header'>
        <h2>Posts from {$month|date_format:"F Y"}</h2>
    </div>
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
