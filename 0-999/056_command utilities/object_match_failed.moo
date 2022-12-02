#56:object_match_failed   this none this rxd

"Usage: object_match_failed(object, string, allow invalid)";
"Prints a message if string does not match object.  Generally used after object is derived from a :match_object(string).";
"If allow invalid is true, invalid objects > #0 are not considered a failure.";
{match_result, string, ?allow_invalid = 0} = args;
tell = $perm_utils:controls(caller_perms(), player) ? "notify" | "tell";
if (index(string, "#") == 1 && $code_utils:toobj(string) != E_TYPE)
  "...avoid the `I don't know which `#-2' you mean' message...";
  if (allow_invalid && match_result > #0 && !valid(match_result))
    return 0;
  elseif (!valid(match_result))
    player:(tell)(tostr(string, " does not exist."));
  endif
  return !valid(match_result);
elseif (match_result == $nothing)
  player:(tell)("You must give the name of some object.");
elseif (match_result == $failed_match)
  player:(tell)(tostr("I see no \"", string, "\" here."));
elseif (match_result == $ambiguous_match)
  player:(tell)(tostr("I don't know which \"", string, "\" you mean."));
elseif (!allow_invalid && !valid(match_result))
  player:(tell)(tostr(match_result, " does not exist."));
else
  return 0;
endif
return 1;
