<div class="well" style="padding:8px 0;">
    <ul class='nav nav-list'>
        <li class="nav-header">
            The Archive
        </li>
        {foreach from=$archive item="month"}
            <li><a href="/{$month|date_format:"Y/m"}">{$month|date_format:"F Y"}</a></li>
        {/foreach}
    </ul>
</div>
