#87:check_dictionary   this none this rxd

pwd = args[1];
if (typeof(dict) == OBJ)
  "assume we're checking mr spell";
  try
    if (dict:find_exact(pwd) && !this:_is_funky_case(pwd))
      return "Dictionary words are not permitted for passwords.";
    endif
  except (ANY)
    "in case this is messed up. Just let it go and return 0;";
  endtry
endif
