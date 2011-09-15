{extends file='default/views/base.tpl'}
{block name="title"}{$smarty.block.parent} - Say Hello{/block}
{block name='body'}
    <div class='page-header'>
        <h2>Say Hello</h2>
    </div>
    <div class="row">
        <div class="span8 columns">
            <form action="/contact" method="post">
                {include file="default/views/helpers/field.tpl" field="name" title="Your Name"}
                {include file="default/views/helpers/field.tpl" field="email" type="email" title="Email Address"}
                {include file="default/views/helpers/field.tpl" field="content" title="Message" type="textarea"}
                <div class="actions">
                    <input type="submit" value="Send" class="btn primary" />
                </div>
            </form>
        </div>
        <div class="span8 columns">
            <p>We'd love to hear from you! No, seriously... feel free to get in touch about
            anything at all. If you're not sure why you'd want to then why not check out
            the <a href="/services">services we offer</a>?</p>
        </div>
    </div>
{/block}
