{extends 'base.tpl'}
{block name='heading'}
    Articles from {$month|date_format:"F Y"}
{/block}
{block name='body'}
    <div class="articles">
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {foreachelse}
            <p>Sorry - there are no articles for this month.</p>
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    {$smarty.block.parent}

    {include file='blog/views/partials/archive.tpl'}
{/block}
