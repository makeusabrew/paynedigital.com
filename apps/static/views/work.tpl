{extends 'default/views/base-two-col.tpl'}
{block name='theme'}faded-blue{/block}
{block name="title"}Work{/block}
{block name="heading"}Selected Work &amp; Roles{/block}
{block name='body'}
    <p>Much of the work I undertake is on behalf of agencies and as such
    it is not always possible to divulge full project details (often including
    the name of the end-client), but as much information about each piece
    of work is given. An asterisk(*) next to a project title indicates
    such a restriction. This page also highlights a selection of my own projects,
    most of which
    are freely available on <a href="https://github.com">GitHub</a>.</p>

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>JavaScript Developer (2013)</h2>

    <p class="bump-out milli">
        Duration: 6 months
        <span class="split-before">
            JavaScript
        </span>
    </p>

    <p>A six month contract for <a href="http://www.skysports.com/">Sky Sports</a>
    working as part of an Agile team architecting &amp; implementing a responsive
    website&mdash;also set to double up as a replacement to several native apps
    upon launch&mdash;for one of the brand&rsquo;s flagship products. The app-heavy
    focus of the project led to the site being developed as a
    <a href="http://en.wikipedia.org/wiki/Single-page_application">Single-page application</a>
    using <a href="http://angularjs.org/">AngularJS</a>.</p>


    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Retail website rebuild* (2012&ndash;2013)</h2>

    <p class="bump-out milli">
        Duration: 3 months
        <span class="split-before">
            PHP5, CI, TDD, JavaScript, LAMP, MySQL, Redis
        </span>
    </p>

    <p>This project involved a full rewrite of a national retailer&rsquo;s
    website, in which I was employed as the sole backend developer. In additition,
    all frontend JavaScript was my responsibility.
    To ensure the utmost quality of the build over
    1,500 automated tests were written over the course of the project: both
    unit tests and full-stack scenarios, the latter of which amount to over
    7,000 lines of tests written in <a href="http://coffeescript.org/">CoffeeScript</a>
    and run using <a href="http://zombie.labnotes.org/">ZombieJS</a>. All tests
    are run through my
    Continuous Integration server&mdash;which also manages the automated
    release process to both the test and the live, load-balanced cluster. The backend
    architecture is a fairly typical LAMP stack except for the use of
    <a href="http://redis.io/">Redis</a> a session storage mechanism and key-value
    cache store.</p>

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Jaoss Library &amp; Web Application Framework (2010&ndash;2013)</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 3 years (ongoing)</span>
        GitHub Repositories:
        <a href="https://github.com/makeusabrew/jaoss">Library</a>,
        <a href="https://github.com/makeusabrew/jaoss-web-template">Framework</a>
        <span class="split-before">
            PHP, MVC, OOP, TDD
        </span>
    </p>

    <p>The <a href="https://github.com/makeusabrew/jaoss">jaoss library</a>
    is an open source MVC PHP5 framework focused on speed and testability. It
    started life in May 2010 and has since been used in the vast majority of projects
    I&rsquo;ve built from quick-turnaround microsites to high-performance 
    sites supporting tens of thousands of daily visitors. Although the library
    is a <a href="https://github.com/makeusabrew/jaoss">standalone project</a>
    it is more commonly used as part of the <a href="https://github.com/makeusabrew/jaoss-web-template">jaoss web template</a>
    which includes the library as a
    <a href="/2011/10/introduction-to-git-submodules">git submodule</a>.</p>

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Development &amp; deployment workflow consultancy (2012)</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 1 week</span>
        LAMP setup, SCM setup, Jenkins CI setup, Shell Scripting
    </p>

    <p>This project was undertaken on behalf of
    <a href="http://www.getsavvy.com/">Savvy Marketing</a> to implement the
    foundations of a best-practice development and deployment process within
    Savvy&rsquo;s web team. The work involved:</p>
    <ul>
        <li>Build &amp; configuration of two web servers, an <abbr title="Source Control Management">SCM</abbr> server
        and a CI server</li>
        <li>Installation and configuration of <a href="https://www.chiliproject.org/">Chiliproject</a>,
        a web-based project management system</li>
        <li>Configuration of multiple SCM mirrors and regular mirrored MySQL backups</li>
        <li>Creation &amp; implementation of an automated project deployment process.</li>
    </ul>

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Bootbox.js (2011&ndash;2013)</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 1&frac12; years (ongoing)</span>
        <a href="https://github.com/makeusabrew/bootbox">GitHub Repository</a>
        <span class="split-before">JavaScript, CoffeeScript</span>
    </p>

    <p>Originally a small set of wrapper functions written to scratch my own
    itch, <a href="http://bootboxjs.com/">Bootbox</a> has since grown into
    its own standalone JavaScript library with over 1,500 watchers on
    <a href="https://github.com">GitHub</a>. To support an ever-growing
    community of users and developers it has its own comprehensive test suite
    written in CoffeeScript and providing full code coverage. The project follows
    the <a href="http://semver.org/">Semantic Versioning</a> specification and
    is also under Continuous Integration by using
    <a href="https://github.com/metaskills/mocha-phantomjs">mocha-phantomjs</a>
    to run the tests in a &lsquo;headless&rsquo; WebKit browser.</p>

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Mobile HTML5 app* (2012)</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 1 month</span>
        HTML, CSS, JavaScript
    </p>

    <p>Undertaken on behalf of <a href="http://www.madebypi.co.uk/">MadeByPi</a>
    in Leeds, this project involved the development of a dedicated mobile site
    for which I was contracted as the sole frontend developer, meaning my
    remit was HTML5, CSS3 and JavaScript (unusually, no PHP!). The brief
    required avoiding pre-existing mobile libraries and as such presented
    numerous challenges involving the creation of a bespoke JavaScript
    library taking care of flyout navigation menus and iOS-style page sliding
    transitions.</p>

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Faavorite (2012)</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 3 months</span>
        PHP, JavaScript, MySQL, Redis, WebSockets, ZeroMQ, NodeJS
        <span class="split-before"></span><a href="http://faavorite.com">faavorite.com</a>
        <span class="split-before"></span><a href="/2012/04/faavorite-tech-stack">writeup</a>
    </p>

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

    <hr class="rule    rule--ornament rule--dotted" />

    <h2>Lead Software Engineer (2010&ndash;2011)</h2>

    <p class="bump-out milli">
        <span class="split-after">Duration: 1 year</span>
        PHP, JavaScript, MySQL, HTML, CSS
    </p>

    <p>A one year contract for <a href="http://www.sky.com/">BSkyB</a>
    working as a software engineer (later moved into the role of team lead)
    for <a href="http://www.skybet.com/">Sky Bet</a> in central Leeds.</p>
{/block}
{block name=secondary}
    {include file="default/views/includes/github.tpl"}
{/block}
