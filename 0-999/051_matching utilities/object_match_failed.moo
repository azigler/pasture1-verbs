#51:object_match_failed   this none this rx

"Usage: object_match_failed(object, string[, ambigs])";
"Prints a message if string does not match object.  Generally used after object is derived from a :match_object(string).";
"ambigs is an optional list of the objects that were matched upon.  If given, the message printed will list the ambiguous among them as choices.";
{match_result, string, ?ambigs = 0} = args;
tell = 0 && $perm_utils:controls(caller_perms(), player) ? "notify" | "tell";
if (index(string, "#") == 1 && $code_utils:toobj(string) != E_TYPE)
  "...avoid the `I don't know which `#-2' you mean' message...";
  if (!valid(match_result))
    player:(tell)(tostr("There is no \"", string, "\" that you can see."));
  endif
  return !valid(match_result);
elseif (match_result == $nothing)
  player:(tell)("You must give the name of some object.");
elseif (match_result == $failed_match)
  player:(tell)(tostr("There is no \"", string, "\" that you can see."));
elseif (match_result == $ambiguous_match)
  if (typeof(ambigs) != LIST)
    player:(tell)(tostr("I don't know which \"", string, "\" you mean."));
    return 1;
  endif
  ambigs = $match_utils:match_list(string, ambigs);
  ambigs = $list_utils:map_property(ambigs, "name");
  if (length($list_utils:remove_duplicates(ambigs)) == 1 && $object_utils:isa(player.location, this.matching_room))
    player:(tell)(tostr("I don't know which \"", string, "\" you mean.  Try using \"first ", string, "\", \"second ", string, "\", etc."));
  else
    player:(tell)(tostr("I don't know which \"", string, "\" you mean: ", $string_utils:english_list(ambigs, "nothing", " or "), "."));
  endif
  return 1;
elseif (!valid(match_result))
  player:(tell)(tostr("The object you specified does not exist.  Seeing ghosts?"));
else
  return 0;
endif
return 1;
