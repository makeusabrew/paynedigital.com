{extends file='default/views/base.tpl'}
{block name='body'}
    <h2><a href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
    <div>
        {$post->published|date_format:"d/m/y H:i"}
    </div>

    {$post->content}
{/block}
