{extends 'base.tpl'}
{block name="title"}Articles{/block}
{block name="heading"}Technical Articles{/block}
{block name='body'}

    <p>Many of these articles are relevant to the
    <a class=pjax href="/services">professional services</a> I offer, others
    less so&mdash;but one thing each article in the archive 
    has in common is that it&rsquo;s always something I&rsquo;m genuinely interested in
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
    <p>An <a href="/feed.xml">RSS feed</a> of the ten latest articles
    is available so you can keep up-to-date via the comfort of your favourite RSS reader.</p>
{/block}
