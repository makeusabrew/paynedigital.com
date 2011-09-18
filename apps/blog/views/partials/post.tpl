<div class='post'>
    <div class='page-header'>
        <h2><a href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
    </div>
    <div class='info'>
        <time>{$post->published|date_format:"jS F Y \a\\t H:i"}</time> by <a href="http://twitter/{$post->user->twitter_username}" class="author">{$post->user->getDisplayName()}</a>,
        {if count($post->getTags())}
            tagged with:
            {foreach from=$post->getTags() item="tag" name="tag_loop"}
                <a href="/tag/{$tag|lower|escape:'url'}">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a>{if !$smarty.foreach.tag_loop.last}, {else}.{/if}
            {/foreach}
        {/if}
        {assign var='comment_count' value=$post->getApprovedCommentsCount()}
        <a href='/{$post->getUrl()}#comments'>{if $comment_count != 0}{$comment_count}{else}No{/if} comment{if $comment_count != 1}s{/if}</a>.
    </div>
    <div class='content'>
        {$post->content}
    </div>
    <div class='options'>
        <a href="http://twitter.com/share"
        class="twitter-share-button"
        data-url="{$base_href}{$post->getUrl()}"
        data-text="{$post->title}"
        data-via="{$post->user->twitter_username}"
        data-count="horizontal">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    </div>
</div>
