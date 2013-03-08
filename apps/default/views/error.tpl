{extends 'default/views/base-two-col.tpl'}
{block name="title"}Error{/block}
{block name=heading}
    Oops! That's a {$code}
{/block}
{block name='body'}
    {if $code == 404}
        <p>It looks like the page you&rsquo;re after doesn&rsquo;t exist&mdash;sorry about that. Try
        heading to the <a href="/">home page</a> and going from there. If you think this
        page should be here, please <a href="/contact">let me know</a>. Thanks!</p>
    {else}
        <p>Sorry&mdash;there&rsquo;s been some sort of error. It looks like it was a server issue&mdash;please
        try again in a minute.</p>
    {/if}
{/block}
{block name='secondary'}
    <p>Nobody likes error pages. If going to the <a href="/">home page</a> doesn&rsquo;t fix things,
    why not pass the time learning something on <a title="This links to a random article on Wikipedia. Enjoy!" href="http://en.wikipedia.org/wiki/Special:Random">Wikipedia</a>?</p>
{/block}

