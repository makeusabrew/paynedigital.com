Dear {$comment->name},

A new comment has been added on the article '{$post->title}'. Please feel free to visit the URL below to
see the comment on the site:

{$base_href}{$post->getUrl()}

You've received this email because you previously stated you wanted to receive notifications when
a new comment was added on this article. You instantly unsubscribe from further notifications about
this article by following the link below:

{$base_href}comment-unsubscribe/{$unsubscribe_hash}

Kind regards,

Payne Digital
--
{$base_href}
