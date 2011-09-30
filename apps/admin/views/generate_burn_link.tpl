{extends file='admin/views/base.tpl'}
{block name='body'}
    Link: <a id="burn-link" href="{setting value="site.base_href"}/burn-after-reading/{$preview->identifier}">{setting value="site.base_href"}/burn-after-reading/{$preview->identifier}</a>
{/block}
