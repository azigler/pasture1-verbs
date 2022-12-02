#134:"@add-cron @mkcron"   any any any rxd

"Usage: @mkcron  <minute> <hour> <day> <month> <weekday> <object>:<verb>[(<args>)]";
cu = $command_utils;
su = $string_utils;
player = callers()[$][5];
if (!player.wizard)
  return player:tell("No.");
endif
if (!argstr)
  return player:tell("Usage: " + verb + " <minute> <hour> <day> <month> <weekday> <object>:<verb>[(<args>)]");
endif
vargs = {};
if (argstr[$] == ")" && (i = index(argstr, "(")) && i < length(argstr) - 1)
  vargstr = argstr[i + 1..$ - 1];
  argstr = argstr[1..i - 1];
  vargs = eval("return {" + vargstr + "};");
  if (!vargs[1])
    return player:tell("Invalid verb arguments.");
  else
    vargs = vargs[2];
  endif
endif
when = su:explode(argstr, " ");
if (!when || length(when) != 6)
  return player:tell("<minute> <hour> <day> <month> <weekday> <object>:<verb> expected.");
endif
refstr = when[6];
if (!(vr = $code_utils:parse_verbref(refstr)))
  return player:tell("Invalid verb reference.");
elseif (cu:object_match_failed(object = player:my_match_object(vr[1]), vr[1]))
  return;
elseif (!$object_utils:has_callable_verb(object, vr[2]))
  return player:tell($code_utils:corify_object(object) + ":" + vr[2] + " doesn't exist, or is uncallable.");
else
  vrb = vr[2];
endif
if (!(minute = this:parse_range_representation(when[1])) || !this:validate_range(minute, 0, 59))
  return player:tell("Invalid minute spec.");
elseif (!(hour = this:parse_range_representation(when[2])) || !this:validate_range(hour, 0, 23))
  return player:tell("Invalid hour spec.");
elseif (!(day = this:parse_range_representation(when[3])) || !this:validate_range(day, 1, 31))
  return player:tell("Invalid day spec.");
elseif (!(month = this:parse_range_representation(when[4])) || !this:validate_range(month, 1, 12))
  return player:tell("Invalid month spec.");
elseif (!(weekday = this:parse_range_representation(when[5])) || !this:validate_range(weekday, 0, 6))
  return player:tell("Invalid weekday spec.");
endif
id = this:schedule_cron(minute, hour, day, month, weekday, object, vrb, vargs, player);
player:tell("Cron task " + tostr(id) + " scheduled.");
"Last modified Sat Sep  9 21:27:01 2017 CDT by Jason Perino (#91@ThetaCore).";
