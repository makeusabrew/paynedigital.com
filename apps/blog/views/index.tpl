{extends 'base.tpl'}
{block name="title"}Articles{/block}
{block name="heading"}Technical Articles{/block}
{block name='body'}

    <p>Many of these articles are relevant to the
    <a class=pjax href="/services">professional services</a> I offer, others
    less so&mdash;but one thing each article
    has in common is that it&rsquo;s always something I&rsquo;m genuinely interested in
    or passionate about.</p>

    {foreach $posts as $post}
        {include file="blog/views/partials/post.tpl"}
    {/foreach}

{/block}
