{extends file='default/views/base.tpl'}
{block name='body'}
    <div id='posts'>
        {foreach from=$posts item="post" name="posts"}
            {include file='blog/views/partials/post.tpl'}
        {/foreach}
    </div>
{/block}
{block name='secondary'}
    {$smarty.block.parent}
    <h3>Post Archive</h3>
    <ul>
        {foreach from=$archive item="month"}
            <li><a href="{$month|date_format:"Y/m"}">{$month|date_format:"F Y"}</a></li>
        {/foreach}
    </ul>
{/block}
