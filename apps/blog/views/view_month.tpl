{extends 'base.tpl'}
{block name='body'}
    <div class='page-header'>
        <h2>Posts from {$month|date_format:"F Y"}</h2>
    </div>
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {foreachelse}
            <p>Sorry - there are no posts for this month.</p>
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    {$smarty.block.parent}

    {include file='blog/views/partials/archive.tpl'}
{/block}
