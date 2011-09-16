<h2><a href="/{$post->getUrl()}">{$post->title|htmlentities8}</a></h2>
<div>
    <time>{$post->published|date_format:"d/m/y H:i"}</time> by <b>{$post->getAuthorDisplayName()}</b>
</div>

{$post->content}
