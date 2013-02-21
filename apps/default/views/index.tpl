{extends file='default/views/base.tpl'}
{block name='title'}Web Application &amp; Mobile Development{/block}
{block name='heading'}
    Web application, mobile and real-time HTML5 game development
{/block}
{block name='body'}
    <div>
        {include file="default/views/includes/intro.tpl"}
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
