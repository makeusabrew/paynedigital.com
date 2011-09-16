{extends file='default/views/base.tpl'}
{block name='body'}
    <div class='page-header'>
        <h2>Posts tagged with '{$search_tag}'</h2>
    </div>
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
