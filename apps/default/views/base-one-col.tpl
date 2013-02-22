{extends 'default/views/base.tpl'}
{block name=content}
    <div class="wrapper">

        <h1 class="hero">{block name='heading'}Payne Digital Ltd{/block}</h1>

        {if isset($messages) && count($messages)}
            {foreach from=$messages item="message"}
                {* other twitter styles are: error, warning, success *}
                <div class="alert alert-info">
                    <a class="close" href="#">&times;</a>
                    <p>{$message}</p>
                </div>
            {/foreach}
        {/if}
        {block name=body}{/block}
    </div>
{/block}
