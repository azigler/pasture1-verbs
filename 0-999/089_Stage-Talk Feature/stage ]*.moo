#89:"stage ]*"   any any any rxd

"Perform some physical, non-verbal, action.";
"Usage:";
"  ]third person action";
"Example:";
"  Munchkin has annoyed some would-be tough guy.  He types:";
"      ]hides behind the reactor.";
"  The room sees:";
"      [Munchkin hides behind the reactor.]";
player.location:announce_all("[", player.name + " " + verb[2..$] + (argstr ? " " + argstr | "") + "]");
