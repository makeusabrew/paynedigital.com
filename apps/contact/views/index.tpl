{extends file='default/views/base.tpl'}
{block name='body'}
    <h2>Say Hello</h2>
    <form action="/contact" method="post">
        {include file="default/views/helpers/field.tpl" field="name" title="Your Name"}
        {include file="default/views/helpers/field.tpl" field="email" type="email"}
        {include file="default/views/helpers/field.tpl" field="content" title="Message" type="textarea"}
        <div class="actions">
            <input type="submit" value="Send" class="btn primary" />
        </div>
    </form>
{/block}
