{extends 'default/views/base-two-col.tpl'}
{block name='heading'}
    {if isset($search_query)}
        Search results for &lsquo;{$search_query|htmlentities8}&rsquo;
    {else}
        Search results
    {/if}
{/block}
{block name='body'}
    <div class="articles">
        {if isset($search_query)}
            {foreach from=$posts item="post" name="posts"}
                {include file='blog/views/partials/post.tpl'}
            {foreachelse}
                <p>Sorry - no articles match this query. This search facility will be
                improved over time to actually search the entire site but for now
                is limited to only searching article titles and tags.</p>
            {/foreach}
        {else}
            <p>Sorry - you must enter a query.</p>
        {/if}
    </div>
{/block}
