#4:@newmess*age   any any any rd

"Usage:  @newmessage <message-name> [<message>] [on <object>]";
"Add a message property to an object (default is player), and optionally";
"set its value.  For use by non-programmers, who aren't allowed to add";
"properties generally.";
"To undo the effects of this, use @unmessage.";
set_task_perms(player);
dobjwords = $string_utils:words(dobjstr);
if (!dobjwords)
  player:notify(tostr("Usage:  ", verb, " <message-name> [<message>] [on <object>]"));
  return;
endif
object = valid(iobj) ? iobj | player;
name = this:_messagify(dobjwords[1]);
value = dobjstr[length(dobjwords[1]) + 2..$];
nickname = "@" + name[1..$ - 4];
e = `add_property(object, name, value, {player, "rc"}) ! ANY';
if (typeof(e) != ERR)
  player:notify(tostr(nickname, " on ", object.name, " is now \"", object.(name), "\"."));
elseif (e != E_INVARG)
  player:notify(tostr(e));
elseif ($object_utils:has_property(object, name))
  "object already has property";
  player:notify(tostr(object.name, " already has a ", nickname, " message."));
else
  player:notify(tostr("Unable to add ", nickname, " message to ", object.name, ": ", e));
endif
