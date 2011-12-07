Dear {$comment->name},

A new comment has been added on the article '{$post->title}'. Please feel free to visit the URL below to
see the comment on the site:

{$host}{$post->getUrl()}

You've received this email because you previously stated you wanted to receive notifications when
a new comment was added on this article. You instantly unsubscribe from further notifications about
this article by following the link below:

{$host}comment-unsubscribe/{$unsubscribe_hash}

Kind regards,

Payne Digital
--
{$host}
