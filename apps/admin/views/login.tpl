{extends file='admin/views/base.tpl'}
{block name='body'}
    <h2>Login</h2>
    <form action='/admin/login' method='post'>
        {include file="default/views/helpers/field.tpl" field="email"}
        {include file="default/views/helpers/field.tpl" field="password"}
        <div class="actions">
            <input type="submit" value="Login" class="btn primary" />
        </div>
    </form>
{/block}
