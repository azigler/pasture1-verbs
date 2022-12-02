#87:check_against_moo   this none this rxd

pwd = args[1];
moo = $network.MOO_Name;
if (this:_is_funky_case(pwd))
  return;
endif
if (pwd == moo)
  return "The MOO's name is not secure as a password.";
endif
if (moo[$ - 2..$] == "MOO")
  if (pwd == moo[1..$ - 3])
    return "The MOO's name is not secure as a password.";
  endif
endif
