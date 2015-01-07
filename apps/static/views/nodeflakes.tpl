{extends 'default/views/base-two-col.tpl'}
{block name=title}Nodeflakes&mdash;real time tweet powered snowflakes{/block}
{block name=theme}xmas-inverted{/block}
{*
{block name='logo-extra'}<img src="{$static_path}/img/xmas.png" alt="" class="logo__xmas" />{/block}
*}
{block name=head}
    <link rel="stylesheet" href="{$static_path}/nodeflakes-client/css/main.css?v=467" type="text/css" />
{/block}
{block name=heading}Nodeflakes&mdash;real time tweet powered snowflakes{/block}
{block name=body}

    <h2 class="bump-out">7<sup>th</sup> January 2015: Nodeflakes has been decomissioned for another year; please
    check back nearer Christmas for more festive flakes!</h2>

    <div class=inactive>

    <p>The snowflakes you can see gently floating down your screen are
    real-time representations of tweets, taken <i>live</i> from
    <a href="https://dev.twitter.com/docs/streaming-api">Twitter&rsquo;s Streaming API</a>.
    The size of each flake is loosely based on its author&rsquo;s follower count, and
    hovering over each flake will reveal the tweet it represents complete with
    highlighted hashtags, usernames and URLs. If you&rsquo;re using a modern web browser
    with any luck the snowflakes will even rotate slowly as they glide
    down your screen.</p>

    <h2>Try It Out!</h2>

    <p>To avoid a total whiteout only tweets containing certain festive keywords are shown, so if
    you want to feature simply <a href="https://twitter.com/intent/tweet">send a tweet</a> including
    any of the following phrases. Your tweet will appear instantly at the top of the
    page&mdash;although it can sometimes be a little tricky to spot!</p>

    <p class="bump-out milli"><b>merry christmas, happy christmas, father christmas, christmas presents, merry xmas,
    love christmas, christmas songs, christmas shopping</b></p>

    <p>If you had trouble spotting your tweet then simply include the
    <a href="https://twitter.com/intent/tweet?text=I'm trying out %23nodeflakes - real time tweet powered snowflakes by @makeusabrew">#nodeflakes</a>
    hashtag in <i>any</i> tweet for an extra special snowflake you&rsquo;ll
    be hard pressed to miss (especially if you
    have your sound turned on!). The following Tweet button will illustrate a special gold
    nodeflake in full effect:</p>

    <a
    href="https://twitter.com/intent/tweet?button_hashtag=#nodeflakes&text=I'm trying out nodeflakes - real time tweet powered snowflakes by @makeusabrew"
    class="twitter-hashtag-button"
    data-related="makeusabrew"
    data-lang="en"
    data-size="large"
    data-url="http://paynedigital.com/nodeflakes">Tweet #nodeflakes</a>
    </p>

    </div>

    <h2>How It Works</h2>

    <p>If you&rsquo;re interested in more information about the technology powering nodeflakes
    your best bet is to head over to <a href="/articles/2011/12/nodeflakes">the original article</a>.
    The following image will give you <i>some</i> idea of what&rsquo;s going on but
    the writeup goes into <a href="/articles/2011/12/nodeflakes">far more detail</a> about each
    individual component and the frontend code.</p>

    <p class="caption">
        <img class="caption__image" src="/img/nodeflakes.jpg" alt="nodeflakes flow diagram" />
        <span class="caption__attribute">This fantastic diagram was provided courtesy of my good friend <a href="http://www.ian-thomas.net/">Ian Thomas</a></span>
    </p>

    {*
    <h2>Video Here?</h2>
    *}

    <h2>Follow-up Articles</h2>

    <ul>
        <li><a href="/articles/2011/12/nodeflakes">Original 2011 article</a></li>
        <li><a href="/articles/2012/12/beginning-to-look-like-nodeflakes">Christmas 2012 Introduction</a></li>
        <li><a href="/articles/2013/01/nodeflakes-analysis-statsd-graphite">2012 analysis using StatsD &amp; Graphite</a></li>
        <li><a href="/articles/2013/11/introduction-to-docker">Introducing Docker, Christmas 2013</a></li>
    </ul>

    <h2>Like What You See?</h2>

    <p class="hide--palm">This is a small demo I put together three years ago, but hopefully you&rsquo;ve enjoyed it nonetheless.
    If it&rsquo;s piqued your interest at all feel free to <a href="/contact">get in touch</a> to discuss it or find out
    how we may be able to work together using any of the technologies on show here, or indeed <a href="/services">anything else</a>
    I may be able to help you with.</p>

{/block}
{block name=secondary}
    <p>This is an <a href="https://github.com/makeusabrew/nodeflakes/">open source demo</a>
    I first put together in time for Christmas 2011; you can read the
    <a href="/articles/2011/12/nodeflakes">original writeup</a> although the demo itself has
    now moved to its seasonal home here.</p>

    <p>It involves a number of interesting technologies and components:
    <a href="https://github.com/makeusabrew/nodeflakes-client/blob/master/css/main.css#L67-L113">CSS3 transforms</a>,
    <a href="https://github.com/makeusabrew/nodeflakes">NodeJS</a>,
    <a href="http://en.wikipedia.org/wiki/WebSocket">WebSockets</a>,
    <a href="http://zguide.zeromq.org/page:all">ZeroMQ</a>,
    <a href="/articles/2013/01/nodeflakes-analysis-statsd-graphite">Graphite, StatsD</a>
    and <a href="/articles/2013/11/introduction-to-docker">Docker</a>.</p>

    <p>The code hasn&rsquo;t changed much over the past three years and in some places is certainly
    showing its age, but as long as it works and people enjoy it it&rsquo;ll make an appearance
    every year in the run up to Christmas.</p>

    <p>If you&rsquo;d like to <a href="/contact">get in touch</a> to find out more about the
    demo or discuss any of the technologies it uses then by all means <a href="/contact">please
    do so</a>.</p>

    <p>Enjoy the snowflakes!</p>
{/block}
{block name=script}
{*
    <script src="{$static_path}/assets/js/nodeflakes{$assetPath}.min.js"></script>
    <script>
        $(function() {
            pjaxify.disable();
            Client.start("178.62.99.226", 80);
        });
    </script>
    *}
{/block}
