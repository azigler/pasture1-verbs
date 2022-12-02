#13:_call   this none this rxd

":_call(home,verb,@vargs) calls home:verb(@vargs) with $no_one's perms";
set_task_perms($no_one);
if (caller != this)
  raise(E_PERM);
endif
{home, vb, @vargs} = args;
return home:(vb)(@vargs);
