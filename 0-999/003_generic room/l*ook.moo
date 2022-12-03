#3:l*ook   any any any rxd

if (dobjstr == "" && !prepstr)
  this:look_self();
elseif (prepstr != "in" && prepstr != "on")
  if (!dobjstr && prepstr == "at")
    dobjstr = iobjstr;
    iobjstr = "";
  else
    dobjstr = dobjstr + (prepstr && (dobjstr && " ") + prepstr);
    dobjstr = dobjstr + (iobjstr && (dobjstr && " ") + iobjstr);
  endif
  " dobj = this:match_object(dobjstr);";
  dobj = player:my_match_object(dobjstr);
  if (!$command_utils:object_match_failed(dobj, dobjstr))
    dobj:look_self();
  endif
elseif (!iobjstr)
  player:tell(verb, " ", prepstr, " what?");
else
  iobj = this:match_object(iobjstr);
  if (!$command_utils:object_match_failed(iobj, iobjstr))
    if (dobjstr == "")
      iobj:look_self();
    elseif ((thing = iobj:match(dobjstr)) == $failed_match)
      player:tell("I don't see any \"", dobjstr, "\" ", prepstr, " ", iobj.name, ".");
    elseif (thing == $ambiguous_match)
      player:tell("There are several things ", prepstr, " ", iobj.name, " one might call \"", dobjstr, "\".");
    else
      thing:look_self();
    endif
  endif
endif
"Last modified Sat Dec  3 14:40:19 2022 UTC by caranov (#133).";
