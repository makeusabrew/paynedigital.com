{extends 'default/views/base-two-col.tpl'}
{block name='theme'}mustard{/block}
{block name='title'}Say Hello{/block}
{block name='heading'}Say Hello{/block}
{block name='body'}
    <div id='content-wrapper'>
        <p>Please feel free to get in touch about anything from a simple &lsquo;hello&rsquo;
        to availability enquiries. I&rsquo;ll make every effort to get back to you as soon as possible. If
        you&rsquo;d prefer you can always contact me on <a href="http://twitter.com/makeusabrew">on twitter</a> instead.</p>

        <form action="/contact" method="post" class="form" novalidate>
            <ul class="form-fields">
                {include file="default/views/helpers/field.tpl" field="name" icon="icon-user"}
                {include file="default/views/helpers/field.tpl" field="email" icon="icon-envelope"}
                {include file="default/views/helpers/field.tpl" field="content"}
                <li>
                    <input type="submit" value="Send" class="btn btn-primary" />
                </li>
            </ul>
        </form>
    </div>
{/block}
{block name='secondary'}
    <div class="hide--palm">
        {$smarty.block.parent}
    </div>
{/block}
{block name='script'}
    <script>
        $(function() {
            Forms.handle("form[method='post']", function(form) {
                $("#content-wrapper").html(
                    "<div class='alert alert--success bump-out' style='display:none;'> "+
                        "<strong>Thanks!</strong> I appreciate you getting in touch and will get back to you shortly. "+
                    "</div>"
                );
                $("#content-wrapper .alert").fadeIn('slow');
            });
        });
    </script>
{/block}
