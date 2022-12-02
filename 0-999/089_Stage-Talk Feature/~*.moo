#89:~*   any any any rxd

name = verb[2..$];
argstr = $code_utils:argstr(verb, args, argstr);
player.location:announce_all(player.name, " [", name, "]: ", argstr);
