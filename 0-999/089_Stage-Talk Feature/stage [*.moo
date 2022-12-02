#89:"stage [*"   any any any rxd

"Say something out loud, in some specific way.";
"Usage:";
"  [how]: message";
"Example:";
"  Munchkin decideds to sing some lyrics.  He types:";
"      [sings]: I am the eggman";
"  The room sees:";
"      Munchkin [sings]: I am the eggman";
player.location:announce_all(player.name + " " + verb + " " + argstr);
