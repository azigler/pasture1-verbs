#40:mail_forward   this none this rxd

if (typeof(mf = this.(verb)) == STR)
  return $string_utils:pronoun_sub(mf, @args);
else
  return mf;
endif
