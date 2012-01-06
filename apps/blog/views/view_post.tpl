{extends file='base.tpl'}
{block name="title"}{$smarty.block.parent} - {$post->title}{/block}
{if $post->head_block != ''}
    {block name="head"}
        {$smarty.block.parent}
        {$post->head_block}
    {/block}
{/if}
{block name='body'}
    {include file='partials/post.tpl'}
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

    <div id="comments">
        <h3>Comments</h3>
        <div class='existing'>
            {foreach from=$comments item="comment" name="loop"}
                <div class='comment'>
                    <div class='row'>
                        <div class='span3 columns'>
                            <div class='commenter'>{$comment->name|htmlentities8}</div>
                            <time>{$comment->created|date_format:"jS F Y \a\\t H:i"}</time>
                        </div>
                        <div class='span8 columns'>
                            {$comment->content|htmlentities8}
                        </div>
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
                <div class='row'>
                    <div class='span8 columns'>
                        <form action="/{$post->getUrl()}/comment#comments" method="post">
                            {include file='default/views/helpers/field.tpl' field='name' placeholder='Anonymous' required=false}
                            {include file='default/views/helpers/field.tpl' field='email'}
                            {include file='default/views/helpers/field.tpl' field='content'}
                            {include file='default/views/helpers/field.tpl' field='notifications'}
                            <div class="actions">
                                <input type="submit" value="Send" class="btn primary" />
                            </div>
                        </form>
                    </div>
                    <div class='span3 columns'>
                        <div class='small'>
                            <p>We don't publish your email address and won't send you any spam.</p>
                            <p>Note that we do capture your IP address for auditing purposes and your comment
                            may be moderated before it appears.</p>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/block}
{block name='secondary'}
    <p>
        <strong>Hi there!</strong> We're always on the look out for good quality guest content, so if you've got an article
        you'd like to see published then of course feel free to <a href="/contact">get in touch</a> or <a href="http://twitter.com/paynedigital">send us a tweet</a>.
    </p>

    <p>
        This article was written by <a href="http://twitter.com/{$post->user->twitter_username}" title="Follow {$post->user->forename} on twitter" class="author">{$post->user->getDisplayName()}</a>.
    </p>

    <a href="https://twitter.com/{$post->user->twitter_username}" class="twitter-follow-button" data-show-count="false" data-size="large">Follow @{$post->user->twitter_username|htmlentities8}</a>
    <script src="//platform.twitter.com/widgets.js" type="text/javascript"></script>

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
    <script src="/js/forms.js"></script>
    <script>
        $(function() {
            Forms.handle("form[method='post']", function(form) {
                $("#comments .page-header").remove();
                $(form).parent().parent(".row").remove();
                $("#comments p.no-comments").remove();
                $("#comments .existing").append(
                    "<div class='alert-message success' style='display:none;'> "+
                        "<p><strong>Thanks!</strong> Your comment has been submitted and will be reviewed shortly.</p> "+
                    "</div>"
                );
                $("#comments .existing .alert-message").fadeIn('slow');
            });
        });
    </script>
    {if $post->script_block != ''}
        {$post->script_block}
    {/if}
{/block}
