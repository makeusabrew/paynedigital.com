{extends 'default/views/base.tpl'}
{block name='title'}Web Application &amp; Mobile Development{/block}
{block name='content'}
    <div class="wrapper hero">
        <h1 class="hero__title">
            Web application, mobile and real-time HTML5 game development
        </h1>
        <div class="hero__copy">
            {include file="default/views/includes/intro.tpl"}

            <p>You can find out more <a href="/about" class="pjax">about me</a>,
            discover what <a href="/services" class="pjax">services I offer</a> or
            read some of the <a href="/articles" class="pjax">technical articles</a>
            I&rsquo;ve written.</p>
        </div>
    </div>
{/block}
