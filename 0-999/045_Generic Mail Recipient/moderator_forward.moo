#45:moderator_forward   this none this rxd

if (typeof(mf = this.(verb)) == STR)
  return $string_utils:pronoun_sub(mf, args ? args[1] | $player);
else
  return mf;
endif
