#24:set_player   this none this rxd

":set_player(victim[,nochown]) => 1 or error";
"Set victim's player flag, (maybe) chown to itself, add name and aliases to $player_db.";
" E_NONE == already a player,";
" E_NACC == player_db is frozen,";
" E_RECMOVE == name is unavailable";
{victim, ?nochown = 0} = args;
if (!caller_perms().wizard)
  return E_PERM;
elseif (!(valid(victim) && $object_utils:isa(victim, $player)))
  return E_INVARG;
elseif (is_player(victim))
  return E_NONE;
elseif ($player_db.frozen)
  return E_NACC;
elseif (!$player_db:available(name = victim.name))
  return E_RECMOVE;
else
  set_player_flag(victim, 1);
  if (0 && $object_utils:isa(victim, $prog))
    victim.programmer = 1;
  else
    victim.programmer = $player.programmer;
  endif
  if (!nochown)
    $wiz_utils:set_owner(victim, victim);
  endif
  $player_db:insert(name, victim);
  for a in (setremove(aliases = victim.aliases, name))
    if (index(a, " "))
      "..ignore ..";
    elseif ($player_db:available(a) in {this, 1})
      $player_db:insert(a, victim);
    else
      aliases = setremove(aliases, a);
    endif
  endfor
  victim.aliases = setadd(aliases, name);
  return 1;
endif
