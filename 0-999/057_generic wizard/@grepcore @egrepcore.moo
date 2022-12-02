#57:"@grepcore @egrepcore"   any any any rd

set_task_perms(player);
if (!args)
  player:notify(tostr("Usage:  ", verb, " <pattern>"));
  return;
endif
pattern = argstr;
regexp = verb == "@egrepcore";
player:notify(tostr("Searching for core verbs ", regexp ? "matching the regular expression " | "containing the string ", toliteral(pattern), " ..."));
player:notify("");
$code_utils:(regexp ? "find_verbs_matching" | "find_verbs_containing")(pattern, $core_objects());
