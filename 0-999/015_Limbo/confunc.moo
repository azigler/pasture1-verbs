#15:confunc   this none this rxd

caller == #0 || raise(E_PERM);
{who} = args;
"this:eject(who)";
if (!$recycler:valid(home = who.home))
  clear_property(who, "home");
  home = who.home;
  if (!$recycler:valid(home))
    home = who.home = $player_start;
  endif
endif
"Modified 08-22-98 by TheCat to foil people who manually set their home to places they shouldn't.";
if (!home:acceptable(who) || !home:accept_for_abode(who))
  home = $player_start;
endif
try
  move(who, home);
except (ANY)
  move(who, $player_start);
endtry
who.location:announce_all_but({who}, who.name, " has connected.");
