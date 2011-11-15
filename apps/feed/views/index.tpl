<?xml version="1.0" encoding="utf-8" ?>
<rss version="2.0">
<channel>
    <title>Payne Digital</title>
    <link>{$base_href}</link>
    <description>Web Application &amp; Mobile Development</description>
    {foreach from=$articles item="article"}
        <item>
            <title>{$article->title}</title>
        </item> 
    {/foreach}
</channel>
</rss>
