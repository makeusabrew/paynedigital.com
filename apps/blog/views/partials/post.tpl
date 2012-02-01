<div class='post'>
    <h2><a href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
    <div class='info'>
        {if count($post->getTags())}
            <div class='tags supplementary'>
                <span class='label intro'>Tags:</span>
                {foreach from=$post->getTags() item="tag" name="tag_loop"}
                    <a class='label {$post->formatTagLabel($tag)}' href="/tag/{$tag|lower|escape:'url'}">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a>
                {/foreach}
            </div>
        {/if}
        <div class='published'>
            {assign var='comment_count' value=$post->getApprovedCommentsCount()}
            <time>{$post->published|date_format:"l jS F Y \a\\t H:i"}</time> by <a href="http://twitter.com/{$post->user->twitter_username}" title="Follow {$post->user->forename} on twitter" class="author">{$post->user->getDisplayName()}</a>.
            <a href='/{$post->getUrl()}#comments'>{if $comment_count != 0}{$comment_count}{else}No{/if} comment{if $comment_count != 1}s{/if}</a>.
        </div>
    </div>
    <div class='content'>
        {if !isset($full_content)}
            {$post->introduction}

            <p><a class="btn btn-small" href="/{$post->getUrl()}">Full article ({$post->getWordCount()} words)</a></p>
        {else}
            {$post->content|gistify}
        {/if}
    </div>
    <div class='options'>
        <a href="http://twitter.com/share"
        class="twitter-share-button"
        data-url="{$base_href}{$post->getUrl()}"
        data-text="{$post->title}"
        data-via="{$post->user->twitter_username}"
        data-related="{$post->user->twitter_username}"
        data-count="horizontal">Tweet</a>

        <a href="https://twitter.com/{$post->user->twitter_username}"
        class="twitter-follow-button"
        data-show-count="false">Follow @{$post->user->twitter_username|htmlentities8}</a>
    </div>
</div>
