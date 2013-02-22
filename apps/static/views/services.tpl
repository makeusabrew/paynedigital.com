{extends file='default/views/base-two-col.tpl'}
{block name='theme'}brown{/block}
{block name="title"}Services{/block}
{block name="heading"}Professional Services{/block}
{block name='body'}
    <div class="service">
        <p>&hellip;</p>
    </div>

    <div class="service">
        <h2>Web Application Development</h2>
        <p>&hellip;</p>
    </div>

    <div class="service">
        <h2>API Development</h2>
        <p>&hellip;</p>
    </div>
    <div class="service">
        <h2>iOS Application &amp; Game Development</h2>
        <p>&hellip;</p>
    </div>
    <div class="service">
        <h2>Linux, Apache, MySQL and PHP consultancy (the &#8216;LAMP&#8217; stack)</h2>
        <ul> 
            <li>Full UNIX server set up and maintenance including cloud server configuration</li> 
            <li>Apache set up and maintenance (Virtual Hosts, SSL certificates, module set up etc)</li> 
            <li>Robust, reusable and highly tuned PHP &amp; MySQL</li> 
        </ul> 
    </div>
    <div class="service">
        <h2>Application Testing</h2>
        <p>&hellip;</p>
    </div>
    <div class="service">
        <h2>Test Driven Development consultancy</h2>
        <p>&hellip;</p>
    </div>
    <div class="service">
        <h2>Continuous Integration set up &amp; consultancy</h2>
        <p>&hellip;</p>
    </div>
    <div class="service">
        <h2>Project management consultancy (cutting edge software backed with a pragmatic agile implementation)</h2>
        <p>&hellip;</p>
    </div>

    <p>If you&rsquo;re interested in hearing any more, then please feel free to
    <a href="/contact" title="Say Hello">get in touch</a>!</p> 
{/block}
{block name='secondary'}
    {include file="default/views/includes/github.tpl"}
{/block}
