{extends 'base.tpl'}
{block name="title"}{$smarty.block.parent} - Articles{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Articles</h2>
    </div>

    <p>We like writing about things. Some are relevant to many of the
    <a href="/services">professional services</a> we have to offer, others
    less so &#8212; but one thing each article in the archive 
    has in common is that it's always something we're genuinely interested in
    or passionate about.</p>

    <div class='page-header'>
        <h3>By Month</h3>
    </div>
    {include file='blog/views/partials/archive.tpl'}

    <div class='page-header'>
        <h3>By Tag</h3>
    </div>
    <p>
        {foreach from=$tags item="tag" name="tag_loop"}
            <a href="/tag/{$tag|lower|escape:'url'}" class="label {$post->formatTagLabel($tag)}">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a> 
        {/foreach}
    </p>
{/block}
{block name='secondary'}
    <p><b>Did you know?</b> An <a href="/feed.xml">RSS feed</a> of the ten latest articles 
    is available so you can keep up-to-date via the comfort of your favourite RSS reader.</p>
{/block}
