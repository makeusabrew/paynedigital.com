{extends 'default/views/base-two-col.tpl'}
{block name=title}Nodeflakes&mdash;real time tweet powered snowflakes{/block}
{block name=theme}xmas-inverted{/block}
{block name='logo-extra'}<img src="/img/xmas.png" alt="" class="logo__xmas" />{/block}
{block name=head}
    <link rel="stylesheet" href="/nodeflakes-client/css/main.css" type="text/css" />
{/block}
{block name=heading}Nodeflakes&mdash;real time tweet powered snowflakes{/block}
{block name=body}

    <p>The snowflakes you can see gently floating down your screen are
    real-time representations of tweets, taken <strong>live</strong> from
    <a href="https://dev.twitter.com/docs/streaming-api">Twitter&rsquo;s Streaming API</a>.
    The size of each flake is loosely based on its author&rsquo;s follower count, and
    hovering over each flake will reveal the tweet it represents complete with
    highlighted hashtags, usernames and URLs. If you&rsquo;re using a modern web browser
    with any luck the snowflakes will even rotate slowly as they glide
    down your screen. If things get a bit juddery, try playing with some of the options
    in the bottom right-hand corner of the viewport. Try a few combinations as their
    effects seem to differ not just between browsers but also operating systems too.
    If you&rsquo;re on a mobile, your mileage may vary.</p>

    <h2>Try It Out!</h2>

    <p>To avoid a total blizzard only tweets containing certain keywords are shown, so if
    you want to feature simply <a href="https://twitter.com/intent/tweet">send a tweet</a> including
    any of the following phrases. Your tweet will appear instantly at the top of the
    page&mdash;although it can sometimes be a little tricky to spot!</p>

    <p class="bump-out milli"><b>merry christmas, happy christmas, father christmas, christmas presents, merry xmas,
    love christmas, christmas songs, christmas shopping</b></p>

    <p>If you had trouble spotting your tweet then simply include the
    <a href="https://twitter.com/intent/tweet?text=I'm trying out %23nodeflakes - real time tweet powered snowflakes by @makeusabrew">#nodeflakes</a>
    hashtag in <i>any</i> tweet for an extra special snowflake you&rsquo;ll
    be hard pressed to miss (especially if you
    have your sound turned on!). The following Tweet button will illustrate a special <b>gold</b>
    nodeflake in full effect:</p>

    <a
    href="https://twitter.com/intent/tweet?button_hashtag=#nodeflakes&text=I'm trying out nodeflakes - real time tweet powered snowflakes by @makeusabrew"
    class="twitter-hashtag-button"
    data-related="makeusabrew"
    data-lang="en"
    data-size="large"
    data-url="http://paynedigital.com/2011/12/nodeflakes"
    data-count="horizontal">Tweet #nodeflakes</a>
    </p>

    <h2>Video Here?</h2>

    <h2>How It Works</h2>

    <p>If you&rsquo;re interested in more information about the technology powering nodeflakes
    your best bet is to head over to <a href="/2011/12/nodeflakes">the original article</a>.
    The following image will give you <i>some</i> idea of what&rsquo;s going on but
    the writeup goes into <a href="/2011/12/nodeflakes">far more detail</a> about each
    individual component and the frontend code.</p>

    <p>
    <img src="/img/nodeflakes.png" alt="nodeflakes flow diagram" />
    </p>

    <h2>Follow-up Articles</h2>

    <ul>
        <li><a href="/2012/12/beginning-to-look-like-nodeflakes">Christmas 2012 Introduction</a></li>
        <li><a href="/2013/01/nodeflakes-analysis-statsd-graphite">2012 analysis using StatsD &amp; Graphite</a></li>
        <li><a href="@TODO">Introducing Docker, Christmas 2013</a></li>
    </ul>

    <h2>Like What You See?</h2>

    <p>This is small demo I put together two years ago, but hopefully you&rsquo;ve enjoyed it nonetheless.
    If you&rsquo;re interested in finding out more about me then please do <a href="/contact">get in touch</a>.</p>

{/block}
{block name=secondary}
    <p>This is an <a href="https://github.com/makeusabrew/nodeflakes/">open source demo</a>
    I first put together in time for Christmas 2011; you can read the
    <a href="/2011/12/nodeflakes">original writeup</a> although the demo itself has
    now moved to its seasonal home here.</p>

    <p>It involves a number of interesting technologies and components: CSS3 transforms,
    NodeJS, WebSockets, ZeroMQ, Graphite, StatsD and a new addition for 2013, Docker.</p>

    <p>The code hasn&rsquo;t changed much over the past two years and in some places is certainly
    showing its age, but as long as it works and people enjoy it it&rsquo;ll make an appearance
    every year in the run up to Christmas.</p>

    <p>If you&rsquo;d like to <a href="/contact">get in touch</a> to find out more about the
    demo or discuss any of the technologies it uses then by all means <a href="/contact">please
    do so</a>.</p>

    <p>Enjoy the snowflakes!</p>
{/block}
{block name=script}
    <script src="http://localhost:7979/socket.io/socket.io.js"></script>
    <script src="/nodeflakes-client/js/engine.js"></script>
    <script src="/nodeflakes-client/js/sound_manager.js"></script>
    <script src="/nodeflakes-client/js/flake.js"></script>
    <script src="/nodeflakes-client/js/client.js"></script>
    <script>
        $(function() {
            pjaxify.disable();
            Client.start("localhost", 7979);
        });
    </script>
{/block}
