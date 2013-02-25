{extends 'default/views/base-two-col.tpl'}
{block name='theme'}purple{/block}
{block name="title"}Work{/block}
{block name="heading"}Selected Work{/block}
{block name='body'}
    <p>Much of the work I undertake is on behalf of agencies and as such
    it is not always possible to divulge full project details (often including
    the name of the end-client), but as much information about each piece
    of work is given.</p>

    <p>This page also highlights a selection of my own projects, most of which
    are freely available on <a href="https://github.com">GitHub</a>.</p>

    <h2>Full website redevelopment</h2>

    <p class="bump-out milli">
        Duration: 3 months
        <span class="split-before">
            PHP5, CI, TDD, JS, LAMP, JS
        </span>

    <p>This project involved a full rewrite of a national retailer&rsquo;s
    website, in which I was employed as the sole backend and
    JavaScript developer. To ensure the utmost quality of the build over
    1,500 automated tests were written over the course of the project (both
    full-stack scenarios and unit tests), all of which are run through my
    Continuous Integration server&mdash;which also manages the automated
    release process to both the test and the live, load-balanced cluster.</p>

    <h2>Jaoss Library &amp; Web Application Framework</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 3 years (ongoing)</span>
        <a href="https://github.com/makeusabrew/jaoss">GitHub</a>
        <span class="split-before">
            PHP, MVC, OOP
        </span>
    </p>

    <p>The <a href="https://github.com/makeusabrew/jaoss">jaoss framework</a>
    is an open source MVC PHP5 framework focused on speed and testability. It
    started life in May 2010 and has since been used the vast majority of projects
    I&rsquo;ve built from quick-turnaround microsites to high-performance 
    sites supporting tens of thousands of daily visitors.</p>

    <h2>Development &amp; deployment workflow consultancy</h2>

    <p class="bump-out milli">Duration: 1 week</p>

    <p>This project was undertaken on behalf of
    <a href="http://www.getsavvy.com/">Savvy Marketing</a> to...</p>

    <h2>Bootbox.js</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 1&frac12; years (ongoing)</span>
        <a href="https://github.com/makeusabrew/bootbox">GitHub</a>
        <span class="split-before">JS</span>
    </p>

    <p>Originally a small set of wrapper functions written to scratch my own
    itch, <a href="http://bootboxjs.com/">Bootbox</a> has since grown into
    its own standalone JavaScript library with over 1,100 watchers on
    <a href="https://github.com">GitHub</a>. To support an ever-growing
    community of users and developers it has its own in-browser test suite and follows
    the <a href="http://semver.org/">Semantic Versioning</a> specification. The 
    project is also under Continuous Integration by using
    <a href="https://github.com/metaskills/mocha-phantomjs">mocha-phantomjs</a>
    to run the tests in a &lsquo;headless&rsquo; WebKit browser.</p>

    <h2>Mobile HTML5 web app</h2>

    <p class="bump-out milli">Duration: 1 month</p>

    <p>Undertaken on behalf of <a href="http://www.madebypi.co.uk/">MadeByPi</a>
    in Leeds, this project involved the development of a dedicated mobile site
    for which I was contracted as the sole front-end developer, meaning my
    remit was HTML5, CSS3 and JavaScript (unusually, no PHP!). The brief
    required avoiding pre-existing mobile libraries and as such presented
    numerous challenges involving the creation of a bespoke JavaScript
    library taking care of flyout navigation menus and iOS-style page sliding
    transitions.</p>

    <h2>faavorite.com</h2>

    <p class="bump-out milli">Duration: 3 months</p>

    <p>An out-of-hours project built with a friend to satisfy our shared
    desire for a better way of organising, sharing and discovering
    favourited tweets. Ostensibly quite a simple undertaking, the build
    of this project ended up being fairly complicated and involved learning
    a number of design patterns and technologies. I was the sole backend
    and JavaScript developer and <a href="http://faavorite.com">faavorite</a>
    was the first project in which I deployed any <a href="http://nodejs.org/">node.js</a>
    code in production to handle a huge amount of background task processing.
    
    The project also involved a number of other technologies over and above
    the typical LAMP stack including the use of <a href="http://redis.io/">redis</a>
    as both a news feed and caching mechanism along with ZeroMQ and WebSockets to
    deliver low-latency notifications to users.</p>

    <h2>Lead Software Engineer</h2>

    <p class="bump-out milli">Duration: 1 year</p>

    <p>A one year contract for <a href="http://www.sky.com/">BSkyB</a>
    working as a software engineer (later moved into the role of team lead)
    for <a href="http://www.skybet.com/">Sky Bet</a> in central Leeeds.</p>

{/block}
{block name=secondary}
    {include file="default/views/includes/github.tpl"}
{/block}
