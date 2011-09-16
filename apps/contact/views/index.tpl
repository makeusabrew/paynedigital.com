{extends file='default/views/base.tpl'}
{block name="title"}{$smarty.block.parent} - Say Hello{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Say Hello</h2>
    </div>

    <div id='content-wrapper'>
        <p>We'd love to hear from you! No, seriously... feel free to get in touch about
        anything at all. If you're not sure why you'd want to then why not check out
        the <a href="/services">services we offer</a>?</p>
        <form action="/contact" method="post">
            {include file="default/views/helpers/field.tpl" field="name"}
            {include file="default/views/helpers/field.tpl" field="email"}
            {include file="default/views/helpers/field.tpl" field="content"}
            <div class="actions">
                <input type="submit" value="Send" class="btn primary" />
            </div>
        </form>
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
                    $("#content-wrapper").html(
                        "<div class='alert-message success' style='display:none;'> "+
                            "<p><strong>Thanks!</strong>We appreciate you getting in touch and will get back to you shortly.</p> "+
                        "</div>"
                    );
                    $("#content-wrapper .alert-message").fadeIn('slow');
                }, "json");
            });
        });
    </script>
{/block}
