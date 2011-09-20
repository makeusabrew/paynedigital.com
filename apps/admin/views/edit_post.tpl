{extends file='admin/views/base.tpl'}
{block name='body'}
    <form action="{$current_url}" method="post">
        {include file='default/views/helpers/field.tpl' field='title'}
        {include file='default/views/helpers/field.tpl' field='url'}
        {include file='default/views/helpers/field.tpl' field='status'}
        {include file='default/views/helpers/field.tpl' field='published'}
        {include file='default/views/helpers/field.tpl' field='content' fclass="editcontent"}
        {include file='default/views/helpers/field.tpl' field='tags'}
        <div class="actions">
            <input type="submit" value="Save" class="btn primary" />
        </div>
    </form>
{/block}
