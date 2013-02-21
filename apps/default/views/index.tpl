{extends file='default/views/base.tpl'}
{block name='title'}Web Application &amp; Mobile Development{/block}
{block name='heading'}
    Web, Mobile, Apps &amp; Games.<span class='supplementary'> Whatever you need, we can build it.</span>
{/block}
{block name='body'}
    <div>
        <p>
            Payne Digital make
            <a href="https://github.com/makeusabrew/paynedigital.com">websites like this one</a>,
            web apps, mobile apps &amp; games through to more <a href="https://github.com/makeusabrew/arduinode">experimental</a>
            <a href="https://github.com/makeusabrew/goursome">demos</a> using cutting edge <a href="http://nodejs.org">software</a> and <a href="http://arduino.cc">hardware</a>.
        </p>
    </div>
    <div class="articles">
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    <div class='supplementary'>
        <p>You might be interested in checking out some of our experiments on <a href="https://github.com/makeusabrew">GitHub</a>.
        You'll even find <a href="https://github.com/makeusabrew/paynedigital.com">this website</a> on there.</p>

        <p>Our most active open source project is the <a href="https://github.com/makeusabrew/jaoss">jaoss</a>
        <a href="https://github.com/makeusabrew/jaoss-web-template">framework</a>, which you can find more about at <a href="http://jaoss.org">jaoss.org</a>
        (which, funnily enough, is also available <a href="https://github.com/makeusabrew/jaoss-website">on github</a>)!</p>
    </div>

    <h3 class="hero">Articles by month</h3>
    {include file='blog/views/partials/archive.tpl'}
{/block}
