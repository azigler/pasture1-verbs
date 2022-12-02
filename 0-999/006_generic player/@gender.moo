#6:@gender   any none none rd

set_task_perms(valid(caller_perms()) ? caller_perms() | player);
if (!args)
  player:notify(tostr("Your gender is currently ", this.gender, "."));
  player:notify($string_utils:pronoun_sub("Your pronouns:  %s,%o,%p,%q,%r,%S,%O,%P,%Q,%R"));
  player:notify(tostr("Available genders:  ", $string_utils:english_list($gender_utils.genders, "", " or ")));
else
  result = this:set_gender(args[1]);
  quote = result == E_NONE ? "\"" | "";
  player:notify(tostr("Gender set to ", quote, this.gender, quote, "."));
  if (typeof(result) != ERR)
    player:notify($string_utils:pronoun_sub("Your pronouns:  %s,%o,%p,%q,%r,%S,%O,%P,%Q,%R"));
  elseif (result != E_NONE)
    player:notify(tostr("Couldn't set pronouns:  ", result));
  else
    player:notify("Pronouns unchanged.");
  endif
endif
