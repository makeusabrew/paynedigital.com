{extends 'default/views/base-two-col.tpl'}
{block name=title}Nodeflakes&mdash;real time tweet powered snowflakes{/block}
{block name=theme}xmas-inverted{/block}
{block name='logo-extra'}<img src="/img/xmas.png" alt="" class="logo__xmas" />{/block}
{block name=head}
    <link rel="stylesheet" href="/nodeflakes-client/css/main.css" type="text/css" />
{/block}
{block name=heading}Nodeflakes{/block}
{block name=body}

    <p>The snowflakes you can hopefully see gently floating down your screen are
    real-time representations of tweets, taken <strong>live</strong> from Twitter's
    <a href="https://dev.twitter.com/docs/streaming-api">Streaming API</a>.
    The size of each flake is loosely based on the author's follower count, and
    hovering over each flake will reveal the tweet it represents complete with
    highlighted hashtags, usernames and URLs. If you're using Chrome, Safari or
    Firefox with any luck the snowflakes will even rotate slowly as they glide
    down your screen (note that they look <strong>a lot</strong> better rendered
    in WebKit). If things get a bit juddery, try playing with some of the options
    in the bottom right hand corner of the viewport. Try a few combinations&mdash;their
    effects seem to differ not just between browsers but also operating systems too.
    If you're on a mobile, your mileage may vary.</p>

    <img src="/img/nodeflakes.png" alt="nodeflakes flow diagram" />

{/block}
{block name=secondary}
    <p>This is an <a href="https://github.com/makeusabrew/nodeflakes/">open source demo</a>
    I first put together in time for Christmas 2011; you can read the
    <a href="/2011/12/nodeflakes">original writeup</a> although the demo itself has
    now moved to its seasonal home here.</p>

    <p>It involves a number of interesting technologies and components: CSS3 transforms,
    NodeJS, WebSockets, ZeroMQ, Graphite, StatsD and a new addition for 2013, Docker.</p>

    <p>The code hasn't changed much over the past two years and in some places is certainly
    showing its age, but as long as it works and people enjoy it it'll make an appearance
    every year for the run up to Christmas.</p>

    <p>If you'd like to <a href="/contact">get in touch</a> to find out more about the
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
