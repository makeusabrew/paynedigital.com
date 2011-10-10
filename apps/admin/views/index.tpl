{extends file='admin/views/base.tpl'}
{block name='body'}
    <p>Hi <strong>{$adminUser->forename}</strong>.</p>
    <ul>
        <li><a href="/admin/posts/add">New Post</a></li>
    </ul>
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Status</th>
                <th>Published</th>
                <th>Comments</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$posts item="post"}
                <tr>
                    <td><a href="/admin/posts/edit/{$post->getId()}">{$post->title|htmlentities8}</a></td>
                    <td>{$post->status|htmlentities8}</td>
                    <td>{$post->published|htmlentities8}</td>
                    <td><a href="/admin/posts/{$post->getId()}/comments">{$post->getApprovedCommentsCount()} ({$post->getUnapprovedCommentsCount()})</a></td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{/block}

