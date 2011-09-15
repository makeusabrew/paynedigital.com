{if isset($columns.$field)}
    {assign var="coldata" value=$columns.$field}
{else}
    {assign var="coldata" value=null}
{/if}
{* any errors? *}
{if isset($_errors) && isset($_errors.$field)}
    {assign var="error" value=$_errors.$field}
{else}
    {assign var="error" value=false}
{/if}
{* input type *}
{if !isset($type)}
    {if isset($coldata.type)}
        {assign var="type" value=$coldata.type}
    {else}
        {assign var="type" value="text"}
    {/if}
{/if}
{* simplify if necessary *}
{if $type == "date"}
    {assign var="type" value="text"}
{/if}
{* field title please *}
{if !isset($title)}
    {if isset($coldata.title)}
        {assign var="title" value=$coldata.title}
    {else}
        {assign var="title" value=$field|ucfirst}
    {/if}
{/if}
{* any value? *}
{if isset($no_value) && $no_value == true}
    {assign var="value" value=""}
{else}
    {if !isset($value)}
        {if isset($smarty.post.$field)}
            {assign var="value" value=$smarty.post.$field}
        {elseif isset($object) && $object->$field != null}
            {assign var="value" value=$object->$field}
        {/if}
    {/if}
    {* password? remove value *}
    {if $type == "password" && !isset($force_value)}
        {assign var="value" value=""}
    {/if}
{/if}

<div class="clearfix{if isset($fclass)} {$fclass}{/if}{if $error} error{/if}">
    <label for="{$field}">{$title}{if $error}<span id="{$field}_error" class="error">{if !isset($supress_messages)}{$error}{/if}{/if}</span></label>
    <div class="input">
        {if $type == "textarea"}
            <textarea {if isset($disabled)} disabled=""{/if} id="{$field}" name="{$field}" class="xlarge{if $error} error{/if}">{if isset($value)}{$value|htmlentities8}{/if}</textarea>
        {else}
            <input{if isset($disabled)} disabled=""{/if} type="{$type}" id="{$field}" name="{$field}" class="text{if $error} error{/if}" value="{if isset($value)}{$value|htmlentities8}{/if}" />
        {/if}
    </div>
</div>

{assign var="type" value=null}
{assign var="confirm" value=null}
{assign var="title" value=null}
{assign var="value" value=null}
{assign var="fclass" value=null}
{assign var="force_value" value=null}
{assign var="disabled" value=null}
