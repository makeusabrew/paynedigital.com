{extends file='default/views/base.tpl'}
{block name="title"}{$smarty.block.parent} - {$post->title}{/block}
{block name='body'}
    {include file='partials/post.tpl'}
    <div id="comments">
        <h3>Comments</h3>
        <div class='existing'>
            {if isset($comment_submitted)}
                <div class='submitted'>
                    Thanks! Your comment has been submitted and will be reviewed shortly.
                </div>
            {/if}
            {foreach from=$comments item="comment" name="loop"}
                <div class='comment'>
                    <div class='row'>
                        <div class='span4 columns'>
                            <b>{$comment->name|htmlentities8}</b><br />
                            <time>{$comment->created|date_format:"jS F Y \a\\t H:i"}</time>
                        </div>
                        <div class='span12 columns'>
                            {$comment->content|htmlentities8}
                        </div>
                    </div>
                </div>
            {foreachelse}
                {if !isset($comment_submitted)}
                    <p class='no-comments'>There are currently no comments - feel free to add one!</p>
                {/if}
            {/foreach}
        </div>
        {if !isset($comment_submitted)}
            <div class='page-header'>
                <h3>Add Your Own</h3>
            </div>
            <div class='row'>
                <div class='span8 columns'>
                    <form action="/{$post->getUrl()}/comment#comments" method="post">
                        {include file='default/views/helpers/field.tpl' field='name' placeholder='Anonymous' required=false}
                        {include file='default/views/helpers/field.tpl' field='email'}
                        {include file='default/views/helpers/field.tpl' field='content'}
                        <div class="actions">
                            <input type="submit" value="Send" class="btn primary" />
                        </div>
                    </form>
                </div>
                <div class='span8 columns'>
                    <p>We don't publish your email address and won't send you any spam. Note
                    that we do capture your IP address for auditing purposes.</p>
                </div>
            </div>
        {/if}
    </div>
{/block}
{block name='script'}
    <script>
        $(function() {
            $("form[method='post']").submit(function(e) {
                var self = this;
                e.preventDefault();

                $(self).find("input[type='submit']").attr("disabled", "");
                // clear out any error states we had before
                $(self).find(".clearfix.error").removeClass("error");
                $(self).find("span.help-block").html("");
                $.post($(self).attr("action"), $(self).serialize(), function(response) {
                    $(self).find("input[type='submit']").removeAttr("disabled");
                    if (response._errors != null) {
                        // deal with em
                        for (var i in response._errors) {
                            $(self).find("span#"+i+"_error").html(
                                response._errors[i]
                            ).parents("div.clearfix").addClass("error");
                        }
                        return;
                    }
                    // all good then!
                    $("#comments .page-header").remove();
                    $(self).parent().parent(".row").remove();
                    $("#comments p.no-comments").remove();
                    $("#comments .existing").prepend(
                        "<div class='submitted'> "+
                            "Thanks! Your comment has been submitted and will be reviewed shortly. "+
                        "</div>"
                    );
                }, "json");
            });
        });
    </script>
{/block}
