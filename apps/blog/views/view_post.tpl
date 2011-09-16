{extends file='default/views/base.tpl'}
{block name="title"}{$smarty.block.parent} - {$post->title}{/block}
{block name='body'}
    {include file='partials/post.tpl'}
    <div id="comments">
        <h3>Comments</h3>
        <div class='existing'>
            {foreach from=$comments item="comment" name="loop"}
                <div class='comment'>
                    {$comment->content}
                </div>
            {foreachelse}
                <p>There are currently no comments - feel free to add one!</p>
            {/foreach}
        </div>
        <h3>Add Your Own</h3>
        <form action="{$current_url}/comment" method="post">
            <p>We don't publish your email address and won't send you any spam.</p>
            {include file='default/views/helpers/field.tpl' field='name' placeholder='Anonymous'}
            {include file='default/views/helpers/field.tpl' field='email'}
            {include file='default/views/helpers/field.tpl' field='content'}
            <div class="actions">
                <input type="submit" value="Send" class="btn primary" />
            </div>
        </form>
    </div>
{/block}
