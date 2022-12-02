#58:"@ksearch @kid-search"   any (for/about) any xd

"Usage:  @kid-search <object> for <string>";
"Performs a search through descendants of <object> with the string <string> in its name.";
if (!player.programmer || player != this)
  return $command_utils:do_huh();
endif
if (!dobjstr || !iobjstr)
  return player:tell("Usage:  ", verb, " <object> for <search string>");
endif
OBJ = player:my_match_object(dobjstr);
if ($command_utils:Object_match_failed(OBJ, dobjstr))
  return;
endif
string = iobjstr;
descendants = descendants(OBJ);
if (!descendants)
  return player:tell(OBJ:nn(), " doesn't have any descendants.");
else
  player:tell("Searching for descendants of ", $string_utils:nn(OBJ), " with the name '", string, "'...");
  results = $object_utils:locate_by_name(string, OBJ);
  if (!results)
    player:tell("No objects found.");
  else
    for x in (results)
      player:tell($string_utils:nn(x));
    endfor
    player:tell();
    player:tell(length(results), " objects found.");
  endif
endif
