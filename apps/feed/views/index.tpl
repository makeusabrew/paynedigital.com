<?xml version="1.0" encoding="utf-8" ?>

<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
    <atom:link href="{$full_url}" rel="self" type="application/rss+xml" />
    <title>Payne Digital</title>
    <link>{$base_href}</link>
    <description>Web Application &amp; Mobile Development</description>
{foreach from=$articles item="article"}
    <item>
        <title>{$article->title}</title>
        <link>{$base_href}articles/{$article->getUrl()}</link>
        <description>
            <![CDATA[
                {$article->content}
            ]]>
        </description>
        <guid>{$base_href}{$article->getUrl()}</guid>
        <pubDate>{$article->published|date_format:"D, d M Y H:i:s O"}</pubDate>
    </item>
{/foreach}
</channel>
</rss>
