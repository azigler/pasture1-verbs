#58:"@grep*all @egrep*all"   any any any rd

set_task_perms(player);
if (prepstr == "in")
  pattern = dobjstr;
  objlist = player:eval_cmd_string(iobjstr, 0);
  if (!objlist[1])
    player:notify(tostr("Had trouble reading `", iobjstr, "':  "));
    player:notify_lines(@objlist[2]);
    return;
  elseif (typeof(objlist[2]) == OBJ)
    objlist = {objlist[2..2]};
  elseif (typeof(objlist[2]) != LIST)
    player:notify(tostr("Value of `", iobjstr, "' is not an object or list:  ", toliteral(objlist[2])));
    return;
  else
    objlist = objlist[2..2];
  endif
elseif (prepstr == "from" && (player.wizard && (n = toint(toobj(iobjstr)))))
  pattern = dobjstr;
  objlist = {n};
elseif (args && player.wizard)
  pattern = argstr;
  objlist = {};
else
  player:notify(tostr("Usage:  ", verb, " <pattern> ", player.wizard ? "[in {<objectlist>} | from <number>]" | "in {<objectlist>}"));
  return;
endif
player:notify(tostr("Searching for verbs ", @prepstr ? {prepstr, " ", iobjstr, " "} | {}, verb == "@egrep" ? "matching the pattern " | "containing the string ", toliteral(pattern), " ..."));
player:notify("");
egrep = verb[2] == "e";
all = index(verb, "a");
$code_utils:(all ? egrep ? "find_verb_lines_matching" | "find_verb_lines_containing" | (egrep ? "find_verbs_matching" | "find_verbs_containing"))(pattern, @objlist);
