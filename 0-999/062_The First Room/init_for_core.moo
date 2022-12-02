#62:init_for_core   this none this rxd

"Copied from The Coat Closet (#11):init_for_core by Nosredna (#2487) Mon May  8 10:42:52 1995 PDT";
if (!caller_perms().wizard)
  return E_PERM;
endif
for v in ({"announce*", "emote", "button", "knob"})
  if (`verb_info($player_start, v) ! E_VERBNF => 0')
    delete_verb($player_start, v);
  endif
endfor
for p in ({"out", "quiet", "button"})
  if (p in properties($player_start))
    delete_property($player_start, p);
  endif
endfor
for p in ($object_utils:all_properties($room))
  clear_property($player_start, p);
endfor
$player_start.name = "The First Room";
$player_start.aliases = {};
$player_start.description = "This is all there is right now.";
$player_start.exits = $player_start.entrances = {};
"... at the end since $room:init_for_core moves stuff in";
pass(@args);
