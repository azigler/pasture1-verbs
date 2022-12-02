#0:"bf_chparent chparent"   this none this rxd

"chparent(object, new-parent) -- see help on the builtin.";
who = caller_perms();
{what, papa} = args;
if (typeof(what) != OBJ)
  retval = E_TYPE;
elseif (!valid(what))
  retval = E_INVARG;
elseif (typeof(papa) != OBJ)
  retval = E_TYPE;
elseif (!valid(papa) && papa != #-1)
  retval = E_INVIND;
elseif (!$perm_utils:controls(who, what))
  retval = E_PERM;
elseif (is_player(what) && !$object_utils:isa(papa, $player_class) && !who.wizard)
  retval = E_PERM;
elseif (is_player(what) && !$object_utils:isa(what, $player_class) && !who.wizard)
  retval = E_PERM;
elseif (children(what) && $object_utils:isa(what, $player_class) && !$object_utils:isa(papa, $player_class))
  retval = E_PERM;
elseif (is_player(what) && what in $wiz_utils.chparent_restricted && !who.wizard)
  retval = E_PERM;
elseif (what.location == $mail_agent && $object_utils:isa(what, $mail_recipient) && !$object_utils:isa(papa, $mail_recipient) && !who.wizard)
  retval = E_PERM;
elseif (!valid(papa) || ($perm_utils:controls(who, papa) || papa.f))
  retval = `chparent(@args) ! ANY';
else
  retval = E_PERM;
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
