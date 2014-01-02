{extends 'default/views/base.tpl'}
{block name='title'}Running 2014{/block}
{block name='theme'}paper{/block}
{block name='content'}
    <div class='running wrapper'>
        <h1>Running 2014: Coming Soon</h1>

        <p>In the mean time, you can check out the 2013
        challenge <a href="/running/2013">in the archive</a>.</p>
    </div>
{/block}
{block name=script}
    <script>
        $(function() {
            pjaxify.disable();
        });
    </script>
{/block}
