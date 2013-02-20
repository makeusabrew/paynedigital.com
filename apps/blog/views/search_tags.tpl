{extends file='base.tpl'}
{block name='body'}
    <h2>Articles tagged with '{$search_tag}'</h2>
    <div class="articles">
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {foreachelse}
            <p>Sorry - no articles match this tag.</p>
        {/foreach}
    </div>
{/block}
