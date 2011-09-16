<div class='post'>
    <h2><a href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
    <div class='info'>
        <time>{$post->published|date_format:"d/m/y H:i"}</time> by <b>{$post->getAuthorDisplayName()}</b>,
        tagged with:
        {foreach from=$post->getTags() item="tag" name="tag_loop"}
            <a href="/tag/{$tag|lower}"{if isset($search_tag) && $search_tag == $tag} class='search-tag'{/if}>{$tag|htmlentities8}</a>{if !$smarty.foreach.tag_loop.last}, {/if}
        {/foreach}
    </div>
    <div class='content'>
        {$post->content}
    </div>
</div>
