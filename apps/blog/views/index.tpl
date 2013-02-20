{extends 'base.tpl'}
{block name="title"}Articles{/block}
{block name="heading"}Articles{/block}
{block name='body'}
    <p>We like writing about things. Some are relevant to many of the
    <a class=pjax href="/services">professional services</a> we have to offer, others
    less so&mdash;but one thing each article in the archive 
    has in common is that it's always something we're genuinely interested in
    or passionate about.</p>

    <h3>By Month</h3>
    {include file='blog/views/partials/archive.tpl'}

    <h3>By Tag</h3>
    <p>
        {foreach from=$tags item="tag" name="tag_loop"}
            <a href="/tag/{$tag|lower|escape:'url'}" class="label">{if isset($search_tag) && $search_tag == $tag|lower}<mark>{/if}{$tag|htmlentities8}{if isset($search_tag) && $search_tag == $tag|lower}</mark>{/if}</a> 
        {/foreach}
    </p>
{/block}
{block name='secondary'}
    <p><b>Did you know?</b> An <a href="/feed.xml">RSS feed</a> of the ten latest articles 
    is available so you can keep up-to-date via the comfort of your favourite RSS reader.</p>
{/block}
