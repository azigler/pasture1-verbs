#46:"_parse_from _parse_to"   this none this rxd

":_parse_from(string with |'s in it) => object list";
":_parse_to(string with |'s in it) => object list";
"  for from:string and to:string items in :parse_message_seq";
if (verb == "_parse_to")
  match_obj = fail_obj = this;
  match_verb = "match_recipient";
  fail_verb = "match_failed";
else
  match_obj = $string_utils;
  match_verb = "match_player";
  fail_obj = $command_utils;
  fail_verb = "player_match_failed";
endif
plist = {};
for w in ($string_utils:explode(args[1], "|"))
  if (fail_obj:(fail_verb)(p = match_obj:(match_verb)(w), w))
    p = $string_utils:literal_object(w);
    if (p == $failed_match || !$command_utils:yes_or_no("Continue? "))
      return "Bad address list:  " + args[1];
    endif
  endif
  plist = setadd(plist, p);
endfor
return plist;
