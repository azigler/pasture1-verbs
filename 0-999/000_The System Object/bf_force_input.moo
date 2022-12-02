#0:bf_force_input   this none this rxd

"Copied from Jay (#3920):bf_force_input Mon Jun 16 20:55:27 1997 PDT";
"force_input(conn, line [, at-front])";
"see help on the builtin for more information. This verb is called by the server when $server_options.protect_force_input exists and is true and caller_perms() are not wizardly.";
{conn, line, ?at_front = 0} = args;
if (caller_perms() != conn)
  retval = E_PERM;
elseif (conn in $login.newted)
  retval = E_PERM;
else
  retval = `force_input(@args) ! ANY';
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
