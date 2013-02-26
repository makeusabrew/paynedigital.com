{extends file='base.tpl'}
{block name="title"}{$post->title}{/block}
{block name="heading"}{$post->title}{/block}
{if $post->head_block != ''}
    {block name="head"}
        {$smarty.block.parent}
        {$post->head_block}
    {/block}
{/if}
{block name='body'}
    {include file='partials/post.tpl' full_content=true}
    {if isset($related_posts) && count($related_posts) > 0}
        <div class='related article'>
            <h2>Related Articles</h2>
            <ul>
                {foreach from=$related_posts item="related_post"}
                    <li><a href="/{$related_post->getUrl()}">{$related_post->title|htmlentities8}</a></li>
                {/foreach}
            </ul>
        </div>
    {/if}

    {* @todo can we class this? does any JS hook into the ID? *}
    <div id="comments" class="bump-out comments">
        <h2>Comments</h2>
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
                    <p class='no-comments'>There are currently no comments{if $post->commentsEnabled()} - feel free to add one!{else}.{/if}</p>
                {/if}
            {/foreach}
            {if isset($comment_submitted)}
                <div class='alert-message success'>
                    <p><strong>Thanks!</strong> Your comment has been submitted and will be reviewed shortly.</p>
                </div>
            {/if}
        </div>
        {if !isset($comment_submitted)}
            {if $post->commentsEnabled()}
                <div id='add-comment'>
                    <h3>Add a comment</h3>
                    <div class='milli'>
                        <p>Your email address won&rsquo;t be published you&rsquo;ll never be sent any spam.
                        Your IP address is captured for auditing purposes and your comment
                        will be moderated before it appears.</p>
                    </div>
                    <form action="/{$post->getUrl()}/comment#comments" method="post">
                        <ul class="form-fields">
                            {include file='default/views/helpers/field.tpl' field='name' placeholder='Anonymous' required=false icon="icon-user"}
                            {include file='default/views/helpers/field.tpl' field='email' icon="icon-envelope"}
                            {include file='default/views/helpers/field.tpl' field='content'}
                            {include file='default/views/helpers/field.tpl' field='notifications'}
                            <li class="accessibility">
                                {if isset($_errors) && isset($_errors.details)}
                                    <p>{$_errors.details}</p>
                                {/if}
                                <label for="details">Please&mdash;don&rsquo;t fill this field in! <span class='required'>*</span></label>
                                <input type="text" name="details" id="details" value="{if isset($smarty.post.details)}{$smarty.post.details|htmlentities8}{/if}" />
                            </li>
                            <li>
                                <input type="submit" value="Send" class="btn">
                            </li>
                        </ul>
                    </form>
                </div>
            {else}
                <p>Comments are now closed.</p>
            {/if}
        {/if}
    </div>
{/block}
{block name='secondary'}
    {if isset($related_posts) && count($related_posts) > 0}
        <div class="hide--palm">
            <h2 class="gamma">Related Articles</h2>
            <div class='related'>
                <ul>
                    </li>
                    {foreach from=$related_posts item="related_post"}
                        <li><a href="/{$related_post->getUrl()}">{$related_post->title|htmlentities8}</a></li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}
{/block}
{block name='script'}
    {$smarty.block.parent}
    <script src="/js/forms.js"></script>
    <script>
        $(function() {
            Forms.handle("#comments form[method='post']", function(form) {
                $("#comments .page-header").remove();
                $(form).parents(".form-wrapper").remove();
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
