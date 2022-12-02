#76:check_verb_perms   this none this rxd

value = args[1];
if (typeof(value) != STR)
  return "Must be a string composed of the characters `RWXD'.";
elseif ((stripped = $string_utils:subst(value, {{"R", ""}, {"W", ""}, {"X", ""}, {"D", ""}})) != "")
  "I know you can strip_all_but, but we want to report invalid values.";
  return tostr("Invalid permission ", $s("character", length(stripped)), ": ", stripped);
else
  return {value};
endif
