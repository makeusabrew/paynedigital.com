<div class='post'>
    <h2><a href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
    <div class='info'>
        <time>{$post->published|date_format:"d/m/y H:i"}</time> by <b>{$post->user->getDisplayName()}</b>,
        tagged with:
        {foreach from=$post->getTags() item="tag" name="tag_loop"}
            <a href="/tag/{$tag|lower}"{if isset($search_tag) && $search_tag == $tag} class='search-tag'{/if}>{$tag|htmlentities8}</a>{if !$smarty.foreach.tag_loop.last}, {/if}
        {/foreach}
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
