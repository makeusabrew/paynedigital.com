{extends file='default/views/base.tpl'}
{block name='title'}{$smarty.block.parent} - Web Application &amp; Mobile Development{/block}
{block name='body'}
    <div class='welcome alert-message block-message'>
        <h2>Hello!</h2>
        <p>
            Payne Digital make all sorts of things: <a href="https://github.com/makeusabrew/paynedigital.com">websites
            like this one</a>,
            web apps, mobile apps &amp; games all the way through to more <a href="https://github.com/makeusabrew/arduinode">experimental</a>
            <a href="https://github.com/makeusabrew/goursome">demos</a> using cutting edge <a href="http://nodejs.org">software</a> and <a href="http://arduino.cc">hardware</a>.
            We're a relatively young company, but don't let that put you off. We're enthusiastic and can
            probably <a href="/services">offer you</a> more than you think.
        </p>
        <p>We also like writing about things&mdash;a recent selection of which you can see below. For
        more, check out the <a href="/articles">articles</a> section.</p>
    </div>
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    <p>You might be interested in checking out some of our experiments on <a href="https://github.com/makeusabrew">GitHub</a>.
    You'll even find <a href="https://github.com/makeusabrew/paynedigital.com">this website</a> on there.</p>

    <p>Our most active open source project is the <a href="https://github.com/makeusabrew/jaoss">jaoss</a>
    <a href="https://github.com/makeusabrew/jaoss-web-template">framework</a>, which you can find more about at <a href="http://jaoss.org">jaoss.org</a>
    (which, funnily enough, is also available <a href="https://github.com/makeusabrew/jaoss-website">on github</a>)!</p>

    <h3>The Archive</h3>
    {include file='blog/views/partials/archive.tpl'}
{/block}
{block name='script'}
    {$smarty.block.parent}
{/block}
