#4:@unmess*age   any any any rd

"Usage:  @unmessage <message-name> [from <object>]";
"Remove a message property from an object (default is player).";
set_task_perms(player);
if (!dobjstr || length($string_utils:words(dobjstr)) > 1)
  player:notify(tostr("Usage:  ", verb, " <message-name> [from <object>]"));
  return;
endif
object = valid(iobj) ? iobj | player;
name = this:_messagify(dobjstr);
nickname = "@" + name[1..$ - 4];
try
  delete_property(object, name);
  player:notify(tostr(nickname, " message removed from ", object.name, "."));
except (E_PROPNF)
  player:notify(tostr("No ", nickname, " message found on ", object.name, "."));
except error (ANY)
  player:notify(error[2]);
endtry
