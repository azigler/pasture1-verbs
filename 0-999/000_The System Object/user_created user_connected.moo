#0:"user_created user_connected"   this none this rxd

"Copied from The System Object (#0):user_connected by Slartibartfast (#4242) Sun May 21 18:14:16 1995 PDT";
if (callers())
  return;
endif
$mcp:(verb)(@args);
user = args[1];
set_task_perms(user);
try
  user.location:confunc(user);
  user:confunc();
except id (ANY)
  user:tell("Confunc failed: ", id[2], ".");
  for tb in (id[4])
    user:tell("... called from ", tb[4], ":", tb[2], tb[4] != tb[1] ? tostr(" (this == ", tb[1], ")") | "", ", line ", tb[6]);
  endfor
  user:tell("(End of traceback)");
endtry
user:tell("If you are interested in recent developments, You may check the changelog with the changelog command. Help me:changelog has further information! Welcome to " + $network.moo_name + ".");
