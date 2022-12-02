#90:|*   any any any rxd

"Echo a line prefaced by a vertical bar.";
"Usage:";
"  |message";
"Example:";
"  Hacker wants to echo to the room what he just saw. He enters (either by hand, or with Emacs or a windowing system):";
"      |Haakon has disconnected.";
"  The room sees:";
"      Hacker | Haakon has disconnected.";
player.location:announce_all(player.name + " | " + verb[2..$] + " " + argstr);
