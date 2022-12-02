#72:tcp_wait   this none this rxd

"Copied from sendmail fix (#88079):tcp_wait by Lineman (#108318) Mon Feb  1 19:28:18 1999 PST";
{conn, ?timeout = 0} = args;
if (!caller_perms().wizard)
  return E_PERM;
elseif (timeout)
  fork task (timeout)
    boot_player(conn);
  endfork
endif
while (1)
  if (typeof(line = `read(conn) ! ANY') == ERR)
    break;
  elseif (match(line, "^[0-9][0-9][0-9] "))
    timeout && `kill_task(task) ! ANY';
    break;
  endif
endwhile
return line;
