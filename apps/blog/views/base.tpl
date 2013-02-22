{extends 'default/views/base-two-col.tpl'}
{block name='theme'}green{/block}
{block name='secondary'}
    {include file='blog/views/partials/archive.tpl'}

    <h3>Tags</h3>
    <p>
        {foreach $tags as $tag}
            <a href="/tag/{$tag|lower|escape:'url'}">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a>{if !$tag@last}, {/if} 
        {/foreach}
    </p>

    <p>An <a href="/feed.xml">RSS feed</a> of the ten latest articles
    is available so you can keep up-to-date via the comfort of your favourite RSS reader.</p>
{/block}
