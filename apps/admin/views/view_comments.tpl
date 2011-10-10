{extends file='base.tpl'}
{block name='body'}
    {foreach from=$comments item="comment"}
        <form action="{$current_url}/edit/{$comment->getId()}" method="post">
            {include file='default/views/helpers/field.tpl' field='name' object=$comment}
            {include file='default/views/helpers/field.tpl' field='email' object=$comment}
            {include file='default/views/helpers/field.tpl' field='ip' object=$comment}
            {include file='default/views/helpers/field.tpl' field='content' object=$comment fclass="editcontent"}
            {include file='default/views/helpers/field.tpl' field='approved' object=$comment}
            Submitted At: {$comment->created|date_format:"d/m/Y H:i:s"}
            <div class='actions'>
                <input type="submit" id="save-button" value="Save" class="btn primary" />
            </div>
        </form>
    {/foreach}
{/block}
