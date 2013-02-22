{extends file='default/views/base.tpl'}
{block name='title'}Web Application &amp; Mobile Development{/block}
{block name='heading'}
    Web application, mobile and real-time HTML5 game development
{/block}
{block name='body'}
    <div>
        {include file="default/views/includes/intro.tpl"}

        <p>You can find out more <a href="/about" class="pjax">about me</a>,
        discover what <a href="/services" class="pjax">services I offer</a> or
        read some of the <a href="/articles" class="pjax">technical articles</a>
        I&rsquo;ve written&mdash;the most recent of which are introduced below.</p>
    </div>
    <div class="articles">
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    {include file="default/views/includes/github.tpl"}

    <h3 class="hero">Articles by month</h3>
    {include file='blog/views/partials/archive.tpl'}
{/block}
