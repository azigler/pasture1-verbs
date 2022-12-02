#121:prune_client_info   this none this rxd

{clients, users} = this.client_stats;
for x in (this.client_info)
  if (is_player(x[2]) == 0)
    if ((ind = x[3][1] in clients) == 0)
      clients = {@clients, x[3][1]};
      users = {@users, 1};
    else
      users[ind] = users[ind] + 1;
    endif
    this.client_info = setremove(this.client_info, x);
  endif
  $command_utils:suspend_if_needed(0);
endfor
this.client_stats = {clients, users};
