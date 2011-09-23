<ul>
    {foreach from=$archive item="month"}
        <li><a href="{$month|date_format:"Y/m"}">{$month|date_format:"F Y"}</a></li>
    {/foreach}
</ul>
