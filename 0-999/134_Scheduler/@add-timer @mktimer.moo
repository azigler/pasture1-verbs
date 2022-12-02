#134:"@add-timer @mktimer"   any any any rxd

"Usage: @add-timer <object>:<verb>[(<args>)][ [in|every] <interval>]";
"Schedule a timer task.";
cu = $command_utils;
su = $string_utils;
lu = $list_utils;
tu = $time_utils;
player = callers()[$][5];
if (!player.wizard)
  player:tell("No.");
endif
if (!argstr)
  return player:tell("Usage: " + verb + " <object>:<verb>[(<args>)][ [in|every] <interval>]");
endif
intstr = "";
interval = 0;
preps = {" in ", " every "};
for type in [1..length(preps)]
  if (i = index(argstr, preps[type]))
    interval = tu:parse_english_time_interval(intstr = argstr[i + length(preps[type])..$]);
    argstr = argstr[1..i - 1];
    break;
  endif
endfor
if (!interval)
  return player:tell(intstr ? "Invalid time interval." | "Time interval expected.");
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
if (!argstr)
  return player:tell("<object>:<verb> expected.");
elseif (!(vr = $code_utils:parse_verbref(argstr)))
  return player:tell("Invalid verb reference.");
elseif (cu:object_match_failed(object = player:my_match_object(vr[1]), vr[1]))
  return;
elseif (!$object_utils:has_callable_verb(object, vr[2]))
  return player:tell($code_utils:corify_object(object) + ":" + vr[2] + " doesn't exist, or is uncallable.");
else
  vrb = vr[2];
endif
id = this:(type == 1 ? "schedule_timer" | "schedule_timer_every")(interval, object, vrb, vargs, player);
player:tell("Task " + tostr(id) + " scheduled.");
"Last modified Sat Sep  9 16:54:39 2017 CDT by Jason Perino (#91@ThetaCore).";
