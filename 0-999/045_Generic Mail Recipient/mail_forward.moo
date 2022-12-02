#45:mail_forward   this none this rxd

if (args && !this:is_usable_by(args[1]) && !args[1].wizard)
  return this:moderator_forward(@args);
elseif (typeof(mf = this.(verb)) == STR)
  return $string_utils:pronoun_sub(mf, @args);
else
  return mf;
endif
