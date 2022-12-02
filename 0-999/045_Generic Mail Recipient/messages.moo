#45:messages   this none this rxd

"NOTE:  this routine is obsolete, use :messages_in_seq()";
":messages(num) => returns the message numbered num.";
":messages()    => returns the entire list of messages (can be SLOW).";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
elseif (!args)
  return this:messages_in_seq({1, this:length_all_msgs() + 1});
elseif (!(n = this:exists_num_eq(args[1])))
  return E_RANGE;
else
  return this:messages_in_seq(n)[2];
endif
