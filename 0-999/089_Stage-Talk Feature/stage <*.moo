#89:"stage <*"   any any any rxd

"Point to yourself.";
"Usage:";
"  <message";
"Example:";
"  Muchkin decides he's being strange. He types:";
"    <being strange.";
"  The room sees:";
"    Munchkin <- being strange.";
player.location:announce_all(player.name + " <- " + verb[2..$] + " " + argstr);
