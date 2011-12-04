{if !isset($coldata) && isset($columns.$field)}
    {assign var="coldata" value=$columns.$field}
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
{if !isset($required)}
    {if isset($coldata.required)}
        {assign var="required" value=$coldata.required}
    {else}
        {assign var="required" value=false}
    {/if}
{/if}
{* simplify if necessary *}
{if $type == "date" || $type == "datetime"}
    {assign var="origtype" value=$type}
    {assign var="type" value="text"}
{/if}
{* extra processing *}
{if $type == "select" || $type == "checkbox"}
    {if !isset($seloptions) && isset($coldata.options)}
        {assign var="seloptions" value=$coldata.options}
    {/if}
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
            {*
                some types will need re-formatting for display purposes. It just so
                happens that at the moment the only two types affected are those
                which get "reset" to type == text, so we have to capture their
                original types

                N.B. this will fail if the object has an invalid value which
                date_format doesn't understand... could be improved!
            *}
            {if isset($origtype)}
                {if $origtype == "datetime"}
                    {assign var="value" value=$value|date_format:"d/m/Y H:i:s"}
                {elseif $origtype == "date"}
                    {assign var="value" value=$value|date_format:"d/m/Y"}
                {/if}
            {/if}
        {/if}
    {/if}
    {* password? remove value *}
    {if $type == "password" && !isset($force_value)}
        {assign var="value" value=""}
    {/if}
{/if}

<div class="clearfix{if isset($fclass)} {$fclass}{/if}{if $error} error{/if}">
    <label for="{$field}">{$title}{if $required} <span class='required'>*</span>{/if}</label>
    <div class="input">
        {if $type == "textarea"}
            <textarea{if isset($placeholder)} placeholder="{$placeholder}"{/if}{if isset($disabled)} disabled=""{/if} id="{$field}" name="{$field}" class="xlarge{if $error} error{/if}"{if $required} required=""{/if}>{if isset($value)}{$value|htmlentities8}{/if}</textarea>
        {elseif $type == "select" && isset($seloptions)}
            <select{if isset($disabled)} disabled=""{/if} id="{$field}" name="{$field}" class="select{if $error} error{/if}"{if $required} required=""{/if}>
                {foreach from=$seloptions item="selopt" key="selkey"}
                    <option value="{$selkey}"{if isset($value) && $value == $selkey} selected=""{/if}>{$selopt}</option>
                {/foreach}
                {assign var="selopt" value=null}
                {assign var="selkey" value=null}
            </select>
        {elseif $type == "checkbox" && isset($seloptions)}
            <ul class='inputs-list'>
                {foreach from=$seloptions item="selopt" key="selkey"}
                    <li>
                        <label for="{$field}_{$selkey}">
                            <input type="checkbox"
                            {if isset($disabled)} disabled=""{/if}
                            id="{$field}_{$selkey}"
                            name="{$field}[{$selkey}]"
                            class="checkbox{if $error} error{/if}"
                            {if isset($value) && is_array($value) && isset($value[$selkey])} checked=""{/if}
                            />
                            <span>{$selopt}</span>
                        </label>
                    </li>
                {/foreach}
            </ul>
            {assign var="selopt" value=null}
            {assign var="selkey" value=null}
        {elseif $type == 'bool'}
            <select{if isset($disabled)} disabled=""{/if} id="{$field}" name="{$field}" class="select{if $error} error{/if}"{if $required} required=""{/if}>
                <option value="1"{if isset($value) && $value == true} selected=""{/if}>Yes</option>
                <option value="0"{if isset($value) && $value == false} selected=""{/if}>No</option>
            </select>
        {else}
            <input{if isset($placeholder)} placeholder="{$placeholder}"{/if}{if isset($disabled)} disabled=""{/if} type="{$type}" id="{$field}" name="{$field}" class="text{if $error} error{/if}" value="{if isset($value)}{$value|htmlentities8}{/if}"{if $required} required=""{/if} />
        {/if}
        <span id="{$field}_error" class="help-block">{if $error}{if !isset($supress_messages)}{$error}{/if}{/if}</span>
    </div>
</div>

{assign var="coldata" value=null}
{assign var="type" value=null}
{assign var="confirm" value=null}
{assign var="title" value=null}
{assign var="value" value=null}
{assign var="fclass" value=null}
{assign var="force_value" value=null}
{assign var="disabled" value=null}
{assign var="required" value=null}
{assign var="seloptions" value=null}
{assign var="origtype" value=null}
