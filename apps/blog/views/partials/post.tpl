<div class='article{if isset($full_content)}--full{/if}'>
    {if !isset($full_content)}
        <h2 class="article__heading"><a class="pjax" href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
    {/if}
    <div class='article-meta article-options'>
        <div class='article-meta__published'>
            {assign var='comment_count' value=$post->getApprovedCommentsCount()}
            <time class="split-after">{$post->published|date_format:"jS F Y"}</time>

            {* no thanks author details...
            by <a href="http://twitter.com/{$post->user->twitter_username}" title="Follow {$post->user->forename} on twitter" class="author">{$post->user->getDisplayName()}</a>.
            *}

            <a href='/{$post->getUrl()}#comments'>{if $comment_count != 0}{$comment_count}{else}No{/if} comment{if $comment_count != 1}s{/if}</a>
            {if count($post->getTags())}
                <span class="split-before">Tags:</span>
                {foreach $post->getTags() as $tag}
                    <a class href="/tag/{$tag|lower|escape:'url'}">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a>{if !$tag@last}, {/if}
                {/foreach}
            {/if}
        </div>
    </div>
    <div class="article-content">
        {if !isset($full_content)}
            {$post->introduction}

            <p><a class="pjax go" href="/{$post->getUrl()}">Full article ({$post->getWordCount()} words)</a></p>
        {else}
            {$post->content|gistify}
        {/if}
    </div>
    {if isset($full_content)}
        <div class='article-options'>
            <a href="http://twitter.com/share"
            class="twitter-share-button"
            data-url="{$base_href}{$post->getUrl()}"
            data-text="{$post->title}"
            data-via="{$post->user->twitter_username}"
            data-related="{$post->user->twitter_username}"
            data-count="horizontal">Tweet</a>

            <a href="https://twitter.com/{$post->user->twitter_username}"
            class="twitter-follow-button"
            data-width="150px"
            data-show-count="false">Follow @{$post->user->twitter_username|htmlentities8}</a>
        </div>
    {/if}
</div>
