<ul>
    <li>
        The Archive
    </li>
    {foreach from=$archive item="month"}
        {assign var="formatted" value=$month|date_format:"Y/m"}
        <li{if $current_url == "/`$formatted`"} class="active"{/if}><a class=pjax href="/{$formatted}">{$month|date_format:"F Y"}</a></li>
    {/foreach}
</ul>
