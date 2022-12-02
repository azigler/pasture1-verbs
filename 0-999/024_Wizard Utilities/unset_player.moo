#24:unset_player   this none this rxd

":unset_player(victim[,newowner])  => 1 or error";
"Reset victim's player flag, chown victim to newowner (if given), remove all of victim's names and aliases from $player_db.";
{victim, ?newowner = 0} = args;
if (!caller_perms().wizard)
  return E_PERM;
elseif (!valid(victim))
  return E_INVARG;
elseif (!is_player(victim))
  return E_NONE;
endif
if (typeof(newowner) == OBJ)
  $wiz_utils:set_owner(victim, newowner);
endif
victim.programmer = 0;
victim.wizard = 0;
set_player_flag(victim, 0);
if ($object_utils:has_property($local, "second_char_registry"))
  $local.second_char_registry:delete_player(victim);
  `$local.second_char_registry:delete_shared(victim) ! ANY';
endif
if ($player_db.frozen)
  player:tell("Warning:  player_db is in the middle of a :load().");
endif
$player_db:delete2(victim.name, victim);
for a in (victim.aliases)
  $player_db:delete2(a, victim);
  "I don't *think* this is bad---we've already toaded the guy.  And folks with lots of aliases screw us. --Nosredna";
  $command_utils:suspend_if_needed(0);
endfor
return 1;
"Paragraph (#122534) - Sat Nov 5, 2005 - Remove any shared character registry listings for `victim'.";
