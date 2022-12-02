#134:get_timer_display   this none this xd

":get_timer_display(id): Returns a list of informational strings about the specified timer task.";
{id} = args;
!caller_perms().wizard && raise(E_PERM);
su = $string_utils;
lu = $list_utils;
tu = $time_utils;
if (!(t = id in lu:slice(this.timer_tasks)))
  return {};
else
  {task_id, task_interval, task_schedule_time, task_time, task_owner, object, verb, task_args} = this.timer_tasks[t];
  ll = `player:linelen() ! ANY => 79';
  field_length = ll / 2;
  content_length = ll < 100 ? field_length - 2 | field_length - 4;
  info = {su:left("ID: " + tostr(task_id), field_length) + su:left(("Owner: " + `task_owner:titlec() ! ANY => owner.name' + " (" + tostr(task_owner) + ")")[1..min(field_length, $)], field_length)};
  info = {@info, su:left(("Next run: " + tu:dhms(task_time - time()))[1..min(content_length, $)], field_length) + su:left(task_interval ? ("Interval: " + tu:dhms(task_interval))[1..min(field_length, $)] | "", field_length)};
  info = {@info, su:left(("Verb: " + $code_utils:corify_object(object) + ":" + verb + "(" + toliteral(task_args)[2..$ - 1] + ")")[1..min(ll, $)], ll), ""};
  return info;
endif
"Last modified Thu Sep 14 08:20:53 2017 CDT by Jason Perino (#91@ThetaCore).";
