#16:add   this none this rxd

":add(player,email[,comment])";
if (!caller_perms().wizard)
  return E_PERM;
endif
{who, email, @comment} = args;
l = this:find_exact(email);
if (l == $failed_match)
  this:insert(email, {{who, @comment}});
elseif (i = $list_utils:iassoc(who, l))
  this:insert(email, listset(l, {who, @comment}, i));
else
  this:insert(email, {@l, {who, @comment}});
endif
