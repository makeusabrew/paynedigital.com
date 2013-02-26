{extends file='base.tpl'}
{block name='heading'}
    Articles tagged with &lsquo;{$search_tag}&rsquo;
{/block}
{block name='body'}
    <div class="articles">
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {foreachelse}
            <p>Sorry&mdash;no articles match this tag.</p>
        {/foreach}
    </div>
{/block}
