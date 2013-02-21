{extends file='default/views/base.tpl'}
{block name='theme'}brown{/block}
{block name="title"}Services{/block}
{block name="heading"}Professional Services{/block}
{block name='body'}
    <p>So what exactly do I have to offer you? Well, quite a lot really. Take a look:</p> 
    <ul> 
        <li>Website Development</li> 
        <li>Web Application Development</li> 
        <li>API Development</li> 
        <li>iOS Application &amp; Game Development</li>
        <li>Expert Linux, Apache, MySQL and PHP consultancy (the so called &#8216;LAMP&#8217; stack)
            <ul> 
                <li>Full UNIX server set up and maintenance including cloud server configuration</li> 
                <li>Apache set up and maintenance (Virtual Hosts, SSL certificates, module set up etc)</li> 
                <li>Robust, reusable and highly tuned PHP &amp; MySQL</li> 
            </ul> 
        </li> 
        <li>Application Testing</li> 
        <li>Test Driven Development consultancy</li> 
        <li>Continuous Integration set up &amp; consultancy</li> 
        <li>Project management consultancy (cutting edge software backed with a pragmatic agile implementation)</li> 
    </ul> 
    <p>If you&#8217;re interested in hearing any more, then please feel free to
    <a href="/contact" title="Say Hello">get in touch</a>!</p> 
{/block}
{block name='secondary'}
    {include file="default/views/includes/github.tpl"}
{/block}
