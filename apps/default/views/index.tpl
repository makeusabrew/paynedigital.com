{extends 'default/views/base.tpl'}
{block name='title'}Web Application &amp; Mobile Development{/block}
{block name='theme'}green{/block}
{block name='content'}
    <div class="wrapper hero">
        <h1 class="hero__title">
            High performance web application and real-time game development
        </h1>
        <div class="hero__copy">
            {include file="default/views/includes/intro.tpl"}

            <p>You can find out more <a href="/about" class="pjax">about me</a>,
            discover what <a href="/services" class="pjax">services I offer</a>,
            check out <a href="/work" class="pjax">some of my work</a> or
            read some of the <a href="/articles" class="pjax">articles</a>
            I&rsquo;ve written.</p>
        </div>
    </div>
{/block}
