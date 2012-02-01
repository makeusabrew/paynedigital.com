{extends file='base.tpl'}
{block name="title"}{$smarty.block.parent} - {$post->title}{/block}
{if $post->head_block != ''}
    {block name="head"}
        {$smarty.block.parent}
        {$post->head_block}
    {/block}
{/if}
{block name='body'}
    {include file='partials/post.tpl' full_content=true}
    {if isset($related_posts) && count($related_posts) > 0}
        <div class='related well'>
            <ul class="nav nav-list">
                <li class="nav-header">
                    Related Articles
                </li>
                {foreach from=$related_posts item="related_post"}
                    <li><a href="/{$related_post->getUrl()}">{$related_post->title|htmlentities8}</a></li>
                {/foreach}
            </ul>
        </div>
    {/if}

    <div id="comments">
        <h3>Comments</h3>
        <div class='existing'>
            {foreach from=$comments item="comment" name="loop"}
                <div class='comment'>
                    <div>
                        <span class='commenter'>{$comment->name|htmlentities8}</span>
                        <time>{$comment->created|date_format:"jS F Y \a\\t H:i"}</time>
                    </div>
                    <div class='copy'>
                        {$comment->content|htmlentities8}
                    </div>
                </div>
            {foreachelse}
                {if !isset($comment_submitted)}
                    <p class='no-comments'>There are currently no comments - feel free to add one!</p>
                {/if}
            {/foreach}
            {if isset($comment_submitted)}
                <div class='alert-message success'>
                    <p><strong>Thanks!</strong> Your comment has been submitted and will be reviewed shortly.</p>
                </div>
            {/if}
        </div>
        {if !isset($comment_submitted)}
            <div id='add-comment'>
                <div class='page-header'>
                    <h3>Add Your Own</h3>
                </div>
                <div class='small'>
                    <p>We don't publish your email address and won't send you any spam.
                    We do capture your IP address for auditing purposes and your comment
                    may be moderated before it appears.</p>
                </div>
                <form class="form-horizontal" action="/{$post->getUrl()}/comment#comments" method="post">
                    {include file='default/views/helpers/field.tpl' field='name' placeholder='Anonymous' required=false icon="icon-user"}
                    {include file='default/views/helpers/field.tpl' field='email' icon="icon-envelope"}
                    {include file='default/views/helpers/field.tpl' field='content'}
                    {include file='default/views/helpers/field.tpl' field='notifications'}
                    <div class="form-actions">
                        <input type="submit" value="Send" class="btn btn-primary" />
                    </div>
                </form>
            </div>
        {/if}
    </div>
{/block}
{block name='secondary'}
    <div class="supplementary">
        <p>
            <strong>Hi there!</strong> We're always on the look out for good quality guest content, so if you've got an article
            you'd like to see published then of course feel free to <a href="/contact">get in touch</a> or <a href="http://twitter.com/paynedigital">send us a tweet</a>.
        </p>

        <p>
            This article was written by <a href="http://twitter.com/{$post->user->twitter_username}" title="Follow {$post->user->forename} on twitter" class="author">{$post->user->getDisplayName()}</a>.
        </p>

        <a href="https://twitter.com/{$post->user->twitter_username}" class="twitter-follow-button" data-show-count="false" data-size="large">Follow @{$post->user->twitter_username|htmlentities8}</a>
    </div>

    {*
    {if isset($related_posts) && count($related_posts) > 0}
        <div class='related'>
            <h3>Related Articles</h3>
            <ul>
                {foreach from=$related_posts item="related_post"}
                    <li><a href="/{$related_post->getUrl()}">{$related_post->title|htmlentities8}</a></li>
                {/foreach}
            </ul>
        </div>
    {/if}
    *}
{/block}
{block name='script'}
    {$smarty.block.parent}
    {*<script src="http://platform.twitter.com/widgets.js" rel="defer"></script>*}
    <script src="/js/forms.js"></script>
    <script>
        $(function() {
            Forms.handle("form[method='post']", function(form) {
                $("#comments .page-header").remove();
                $(form).parent().parent(".row").remove();
                $("#comments p.no-comments").remove();
                $("#comments .existing").append(
                    "<div class='alert alert-success' style='display:none;'> "+
                        "<p><strong>Thanks!</strong> Your comment has been submitted and will be reviewed shortly.</p> "+
                    "</div>"
                );
                $("#comments .existing .alert").fadeIn('slow');
            });
        });
    </script>
    {if $post->script_block != ''}
        {$post->script_block}
    {/if}
{/block}
