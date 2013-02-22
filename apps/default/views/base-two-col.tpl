{extends 'default/views/base.tpl'}
{block name=content}
    <div class="wrapper">

        <h1 class="hero">{block name='heading'}Payne Digital Ltd{/block}</h1>

        <div class="gw">
            {if isset($messages) && count($messages)}
                {foreach from=$messages item="message"}
                    {* other twitter styles are: error, warning, success *}
                    <div class="alert alert-info">
                        <a class="close" href="#">&times;</a>
                        <p>{$message}</p>
                    </div>
                {/foreach}
            {/if}
            <div class="g two-thirds">
                {block name=body}{/block}
            </div>
            <div class="g one-third">
                {block name="secondary"}
                    {include file="default/views/includes/intro.tpl"}
                {/block}
            </div>
        </div>
    </div>
{/block}
