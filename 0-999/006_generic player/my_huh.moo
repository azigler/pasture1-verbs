#6:my_huh   this none this rxd

"Extra parsing of player commands.  Called by $command_utils:do_huh.";
"This version of my_huh just handles features.";
permissions = caller == this || $perm_utils:controls(caller_perms(), this) && $command_utils:validate_feature(@args) ? this | $no_one;
"verb - obvious                 pass - would be args";
"plist - list of prepspecs that this command matches";
"dlist and ilist - likewise for dobjspecs, iobjspecs";
{verb, arg} = args;
if (`$server_options.support_numeric_verbname_strings ! E_PROPNF => 0' && $string_utils:is_integer(verb))
  return;
endif
pass = args[2];
plist = {"any", prepstr ? $code_utils:full_prep(prepstr) | "none"};
dlist = dobjstr ? {"any"} | {"none", "any"};
ilist = iobjstr ? {"any"} | {"none", "any"};
for fobj in (this.features)
  if (!$recycler:valid(fobj))
    this:remove_feature(fobj);
  else
    fverb = 0;
    try
      "Ask the FO for a matching verb.";
      fverb = fobj:has_feature_verb(verb, dlist, plist, ilist);
    except e (E_VERBNF)
      "Try to match it ourselves.";
      if (`valid(loc = $object_utils:has_callable_verb(fobj, verb)[1]) ! ANY => 0')
        vargs = verb_args(loc, verb);
        if (vargs[2] in plist && (vargs[1] in dlist && vargs[3] in ilist))
          fverb = verb;
        endif
      endif
    endtry
    if (fverb)
      "(got rid of notify_huh - use @find to locate feature verbs)";
      set_task_perms(permissions);
      fobj:(fverb)(@pass);
      return 1;
    endif
  endif
  if ($command_utils:running_out_of_time())
    player:tell("You have too many features.  Parsing your command runs out of ticks while checking ", fobj.name, " (", fobj, ").");
    return 1;
  endif
endfor
try
  social = $socials:match_social(verb);
  if (verb:length() >= 3 && social)
    this:do_social(social, arg != {} ? $string_utils:from_list(arg, " ") | "");
    return 1;
  endif
except e (ANY)
  return 1;
endtry
if (this.location:huh(verb, arg))
  return 1;
endif
"Last modified Tue Dec  6 09:35:27 2022 UTC by caranov (#133).";
