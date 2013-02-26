{extends file='default/views/base-two-col.tpl'}
{block name='theme'}brown{/block}
{block name="title"}Services{/block}
{block name="heading"}<span class="hide--palm">Professional</span> Services{/block}
{block name='body'}
    <div class="service">
        <h2>Web<span class="hide--palm">site</span> Development</h2>

        <p>Everything from small microsites to high-traffic, load-balanced systems
        all built bespoke on the open source
        <a href="https://github.com/makeusabrew/jaoss">jaoss framework</a>,
        covered by <a href="http://en.wikipedia.org/wiki/Test_automation">automated tests</a>
        and securely &amp; automatically deployed by a <a href="http://en.wikipedia.org/wiki/Continuous_integration">Continuous Integration</a>
        server. Bespoke doesn&rsquo;t necessarily mean expensive&mdash;especially
        with years&rsquo; worth of reusable modules including a fully functional
        <abbr title="Content Management System">CMS</abbr>&mdash;but it <i>does</i>
        mean fast, flexible and perfectly suited.</p>

        <p>Whilst I do usually work with my own battle-hardened PHP framework
        which has been in
        <a href="https://github.com/makeusabrew/jaoss">active,
        open source development for three years</a>, I am happy
        to work with a variety of systems and languages depending on requirements.</p>
    </div>

    <div class="service">
        <h2>Web Application Development</h2>

        <p>Web applications are typically more focused around allowing users
        to perform actions rather than simply deliver content (think
        Twitter, Facebook, Gmail et al) and consequently usually benefit
        far more from bespoke development built to solve their individual
        requirements. The server-side logic is often more complex
        than a typical website and as such the benefits of Test Driven Development,
        Continuous Integration and automated deployment&mdash;all offered as
        part of the service&mdash;are enormous.</p>

    </div>

    <div class="service">
        <h2>Automated Testing<span class="hide--palm"> Consultancy</span></h2>

        <p>Every project I build is covered by its own 
        comprehensive automated test suite. The core
        <a href="https://github.com/makeusabrew/jaoss">jaoss library</a>
        has a base of 300 tests and it is not uncommon for each
        project which uses it to end up with well over 1,000 tests in total,
        ranging from small &lsquo;unit&rsquo; tests to end-to-end, &lsquo;full-stack&rsquo;
        tests which test user journeys using state-of-the-art tools to
        ensure that each application is incredibly robust.</p>

        <p>Whilst the actual implementation of automated testing is not a
        service I offer per-se, it is something I am incredibly passionate
        about and am always happy to discuss on a case-by-case basis.</p>
    </div>

    <div class="service">
        <h2>API Development</h2>
        <p>Modern web applications often end up needing to expose a web-based
        API for their users to consume, and without due consideration the development
        of an API can be a time-consuming, error-prone process which can all too easily
        slip out-of-sync with the underlying application it serves. I have
        years of experience of both API consumption and development and
        can provide advice or implementation of best-practice API designs.</p>
    </div>

    <div class="service">
        <h2>Linux, Apache, MySQL &amp; PHP consultancy</h2>
        <ul> 
            <li>Full UNIX server set up and maintenance including cloud server configuration</li> 
            <li>Apache set up and maintenance (Virtual Hosts, SSL certificates, module set up etc)</li> 
            <li>Robust, reusable and highly tuned PHP &amp; MySQL</li> 
        </ul> 
    </div>

    <div class="service">
        <h2>Continuous Integration set up &amp; consultancy</h2>

        <p>I can provide the build and set up of a <a href="http://jenkins-ci.org/">Jenkins</a> server,
        the world&rsquo;s leading Continuous Integration server, which can be
        configured to suit your company&rsquo;s development and deployment process or
        implement one if it does not formally exist. Continuous Integration in combination
        with automated testing is an industry standard mechanism for improving the
        quality and reliability of software development.</p>

    </div>

    <p>If you&rsquo;re interested in hearing any more, then please feel free to
    <a href="/contact" title="Say Hello">get in touch</a>!</p> 

{/block}
{block name='secondary'}
    <p>Whilst most of these services avoid mention of programming languages
    it is worth noting that my expertise is primarily in PHP and
    JavaScript (both browser-based and server-side using
    <a href="http://nodejs.org/">node.js</a>). I also have vast experience
    designing and tuning MySQL databases and more recently have built
    projects using MongoDB and an entirely redis-backed
    real time HTML5 game.</p>
{/block}
