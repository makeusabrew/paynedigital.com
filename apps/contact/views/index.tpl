{extends 'default/views/base.tpl'}
{block name='theme'}orange{/block}
{block name='title'}Say Hello{/block}
{block name='heading'}Say Hello{/block}
{block name='body'}
    <div id='content-wrapper'>
        <p>We'd love to hear from you! No, seriously... feel free to get in touch about
        anything at all. If you're not sure why you'd want to then why not check out
        the <a href="/services">services we offer</a>?</p>
        <form action="/contact" method="post">
            {include file="default/views/helpers/field.tpl" field="name" icon="icon-user"}
            {include file="default/views/helpers/field.tpl" field="email" icon="icon-envelope"}
            {include file="default/views/helpers/field.tpl" field="content"}
            <div>
                <input type="submit" value="Send" class="btn btn-primary" />
            </div>
        </form>
    </div>
{/block}
{block name='secondary'}
    {$smarty.block.parent}
    <p>You might get just as quick a response <a href="http://twitter.com/makeusabrew">on twitter</a> instead.</p>
{/block}
{block name='script'}
    <script src="/js/forms.js"></script>
    <script>
        $(function() {
            Forms.handle("form[method='post']", function(form) {
                $("#content-wrapper").html(
                    "<div class='alert alert--success' style='display:none;'> "+
                        "<p><strong>Thanks!</strong> We appreciate you getting in touch and will get back to you shortly.</p> "+
                    "</div>"
                );
                $("#content-wrapper .alert").fadeIn('slow');
            });
        });
    </script>
{/block}
