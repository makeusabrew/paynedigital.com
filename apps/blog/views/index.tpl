{extends 'base.tpl'}
{block name="title"}Articles{/block}
{block name="heading"}Articles{/block}
{block name='body'}
    <p>We like writing about things. Some are relevant to many of the
    <a class=pjax href="/services">professional services</a> we have to offer, others
    less so&mdash;but one thing each article in the archive 
    has in common is that it's always something we're genuinely interested in
    or passionate about.</p>

    <h2 class="hero">By Month</h2>
    {include file='blog/views/partials/archive.tpl'}

    <h2 class="hero">By Tag</h2>
    <p>
        {foreach $tags as $tag}
            <a href="/tag/{$tag|lower|escape:'url'}">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a>{if !$tag@last}, {/if} 
        {/foreach}
    </p>
{/block}
{block name='secondary'}
    <p><b>Did you know?</b> An <a href="/feed.xml">RSS feed</a> of the ten latest articles 
    is available so you can keep up-to-date via the comfort of your favourite RSS reader.</p>
{/block}
