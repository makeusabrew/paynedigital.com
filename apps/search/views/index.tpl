{extends file='default/views/base.tpl'}
{block name='body'}
    <div class='page-header'>
        <h2>Results for '{$search_query|htmlentities8}'</h2>
    </div>
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
