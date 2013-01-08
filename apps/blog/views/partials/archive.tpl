<div class="well" style="padding:8px 0;">
    <ul class='nav nav-list'>
        <li class="nav-header">
            The Archive
        </li>
        {foreach from=$archive item="month"}
            {assign var="formatted" value=$month|date_format:"Y/m"}
            <li{if $current_url == "/`$formatted`"} class="active"{/if}><a class=pjax href="/{$formatted}">{$month|date_format:"F Y"}</a></li>
        {/foreach}
    </ul>
</div>
