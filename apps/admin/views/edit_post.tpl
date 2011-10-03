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
            {if isset($object)}
                <div id="burn-modal" class="modal hide fade">
                    <div class="modal-header">
                        <a href="#" class="close">&times;</a>
                        <h3>Preview Link</h3>
                    </div>
                    <div class="modal-body">
                        <p><a id="burn-link"></a></p>
                    </div>
                    <div class="modal-footer">
                        <a href="#" class="btn primary">OK</a>
                    </div>
                </div>
                <a id='generate-burn-link' href="{$current_url}/generate-burn-link" class="btn">Generate Burn Link</a>
            {/if}
        </div>
    </form>
{/block}
{block name='script'}
    <script src="/js/bootstrap-modal.1.3.0.js"></script>
    <script>
        $(function() {
            $("#generate-burn-link").click(function(e) {
                var self = this;
                e.preventDefault();
                $.get($(self).attr("href"), {}, function(response) {
                    $("#burn-modal .modal-body p a").attr("href", response.identifier).html(response.identifier);
                    $("#burn-modal").modal({
                        "backdrop": true,
                        "show" : true
                    });
                });
            });
        });
    </script>
{/block}
