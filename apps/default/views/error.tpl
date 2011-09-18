{extends file='base.tpl'}
{block name="title"}{$smarty.block.parent} - Error{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Oops! That's a {$code}</h2>
    </div>
    {if $code == 404}
        <p>It looks like the page you're after doesn't exist - sorry about that. The site
        has been recently relaunched so the page might have got mixed up in the move - try
        heading to the <a href="/">home page</a> and going from there. If you think this
        page should be here, please <a href="/contact">let us know</a>. Thanks!</p>
    {else}
        <p>Sorry - there's been some sort of error. It looks like it was our fault - please
        try again in a minute.</p>
    {/if}
{/block}
{block name='secondary'}
    <p>Nobody likes error pages. If going to the <a href="/">home page</a> doesn't fix things,
    why not pass the time learning something on <a title="This links to a random article on Wikipedia. Enjoy!" href="http://en.wikipedia.org/wiki/Special:Random">Wikipedia</a>?</p>
{/block}

