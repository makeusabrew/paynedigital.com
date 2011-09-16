{extends file='default/views/base.tpl'}
{block name='body'}
    <div class='row'>
        <div class='span10 columns'>
            <div id='posts'>
                {foreach from=$posts item="post" name="posts"}
                    {include file='blog/views/partials/post.tpl'}
                {/foreach}
            </div>
        </div>
        <div class='span6 columns'>
            <p>Some intro blurb here, possibly a list of past months with
            blog posts...</p>
            <p>
            Phasellus malesuada vulputate sem, in vestibulum enim mattis a.
            Aliquam a elit dolor, et pharetra ipsum. Nullam ut eros in odio vehicula
            hendrerit ut in nibh. Duis nec lacus quis justo pharetra commodo. Quisque
            ullamcorper neque sit amet ante semper nec ornare metus facilisis. 
            </p>
        </div>
    </div>
{/block}
