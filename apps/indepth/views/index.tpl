{extends 'default/views/base.tpl'}
{block name='theme'}darkgreen{/block}
{block name='body'}
    <div class=page-header>
        <h2>In Depth</h2>
    </div>
    <p>Some things are worth exploring in that little bit more detail than
    usual&mdash;and here&rsquo;s where you&rsquo;ll find them. Expect an in-depth
    writeup to be longer and&mdash;naturally&mdash;deeper than a 
    <a href=/articles>standard article</a>.</p>

    {foreach $articles as $article}
        {$article->title}
    {/foreach}
{/block}
