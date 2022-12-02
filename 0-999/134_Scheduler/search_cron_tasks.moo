#134:search_cron_tasks   this none this xd

":search_cron_tasks(what): Searches the scheduled Cron tasks for tasks matching the query.";
"Query may be a task ID, the trailing digits of a task ID (prepended with a percent character (%)), an <object>:<verb> reference, or a player name.";
"Multiple queries may be included by separating each with a comma (,).";
{what} = args;
!caller_perms().wizard && raise(E_PERM);
cu = $command_utils;
su = $string_utils;
tasklist = {};
for s in (su:explode(what, ","))
  if (su:is_integer(s))
    tasklist = setadd(tasklist, toint(s));
  elseif (s[1] == "%" && su:is_integer(`s[2..$] ! E_RANGE => ""'))
    for t in (this.cron_tasks)
      if (tostr(t[1])[$ - (length(s) - 2)..$] == s[2..$])
        tasklist = setadd(tasklist, t[1]);
      endif
    endfor
  elseif (index(s, ":"))
    vr = $code_utils:parse_verbref(s);
    if (!vr)
      return player:tell("Invalid verb reference: \"" + what + "\"");
    elseif (cu:object_match_failed(object = player:my_match_object(vr[1]), vr[1]))
      continue;
    else
      for t in (this.cron_tasks)
        if (t[9..10] == {object, vr[2]})
          tasklist = setadd(tasklist, t[1]);
        endif
      endfor
    endif
  else
    if (cu:player_match_failed(plr = su:match_player(s), s))
      continue;
    endif
    for t in (this.cron_tasks)
      if (t[8] == plr)
        tasklist = setadd(tasklist, t[1]);
      endif
    endfor
  endif
endfor
return tasklist;
"Last modified Thu Sep 14 08:24:42 2017 CDT by Jason Perino (#91@ThetaCore).";
