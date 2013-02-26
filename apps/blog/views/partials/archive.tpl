<ul>
    {foreach from=$archive item="month"}
        {assign var="formatted" value=$month|date_format:"Y/m"}
        <li{if $current_url == "/articles/`$formatted`"} class="active"{/if}><a class=pjax href="/articles/{$formatted}">{$month|date_format:"F Y"}</a></li>
    {/foreach}
</ul>
