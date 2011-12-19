{extends file='admin/views/base.tpl'}
{block name='body'}
    {foreach from=$related_posts item="related_post"}
        <form action="{$current_url}/edit/{$related_post->getId()}" method="post">
            {include file='default/views/helpers/field.tpl' field='sort_order' object=$related_post}
            {include file='default/views/helpers/field.tpl' field='related_post_id' object=$related_post}
            <div class='actions'>
                <input type="submit" value="Update" class="btn primary" />
                <a href="{$current_url}/delete/{$related_post->getId()}" class="btn danger">Delete</a>
            </div>
        </form>
    {/foreach}
    <h2>Add Related Article</h2>
    <form action="{$current_url}/add" method="post">
        {include file='default/views/helpers/field.tpl' field='sort_order'}
        {include file='default/views/helpers/field.tpl' field='related_post_id'}
        <div class='actions'>
            <input type="submit" value="Add" class="btn success" />
        </div>
    </form>
{/block}
{block name='script'}
    <script>
        $(function() {
            $("a.danger").click(function(e) {
                return confirm("Are you sure?");
            });
        });
    </script>
{/block}
