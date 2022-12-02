#14:renumber   this none this rxd

":renumber([cur]) renumbers caller.messages, doing a suspend() if necessary.";
"  => {number of messages,new cur}.";
if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
{?cur = 0} = args;
this:expunge_rmm();
"... blow away @rmm'ed messages since there's no way to tell what their new numbers should be...";
if (!(msgtree = this.messages))
  return {0, 0};
endif
if (cur)
  cur = this._mgr:find_ord(msgtree, cur - 1, "_lt_msgnum") + 1;
endif
while (1)
  "...find first out-of-sequence message...";
  n = 1;
  subtree = msgtree;
  if (msgtree[3][1] == 1)
    while ((node = this.(subtree[1]))[1])
      "...subtree[3][1]==n...";
      kids = node[2];
      n = n + subtree[2];
      i = length(kids);
      while ((n = n - kids[i][2]) != kids[i][3][1])
        i = i - 1;
      endwhile
      subtree = kids[i];
    endwhile
    leaves = node[2];
    n = (firstn = n) + length(leaves) - 1;
    while (n != leaves[n - firstn + 1][2])
      n = n - 1;
    endwhile
    n = n + 1;
  endif
  "... n == first out-of-sequence ...";
  "...renumber as many messages as we have time for...";
  while (n <= msgtree[2] && !$command_utils:running_out_of_time())
    msg = this._mgr:find_nth(msgtree, n);
    msgtree = this._mgr:set_nth(msgtree, n, listset(msg, n, 2));
    n = n + 1;
  endwhile
  this.messages = msgtree;
  if (n > msgtree[2])
    return {n - 1, cur};
  endif
  player:tell("...(renumbering to ", n - 1, ")");
  suspend(0);
  "...start over... may have received new mail, rmm'ed stuff, etc...";
  "...so who knows what's there now?...";
  if (this.messages_going)
    player:tell("Renumber aborted.");
    return;
  endif
  msgtree = this.messages;
endwhile
