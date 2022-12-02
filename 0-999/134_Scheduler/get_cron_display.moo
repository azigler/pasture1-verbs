#134:get_cron_display   this none this xd

":get_cron_display(id): Returns a list of informational strings about the specified Cron task.";
{id} = args;
!caller_perms().wizard && raise(E_PERM);
su = $string_utils;
lu = $list_utils;
tu = $time_utils;
if (!(t = id in lu:slice(this.cron_tasks)))
  return {};
else
  {task_id, task_last_run, task_minute, task_hour, task_day, task_month, task_weekday, task_owner, object, verb, task_args} = this.cron_tasks[t];
  ll = `player:linelen() ! ANY => 79';
  field_length = ll / 2;
  content_length = ll < 100 ? field_length - 2 | field_length - 4;
  info = {su:left("ID: " + tostr(task_id), field_length) + su:left(("Owner: " + `task_owner:titlec() ! ANY => owner.name' + " (" + tostr(task_owner) + ")")[1..min(field_length, $)], field_length)};
  info = {@info, su:center(task_last_run ? "Last run: " + tu:dhms(time() - task_last_run) + " ago" | "Never run before", ll), su:center("When:", ll)};
  field_length = ll / 5;
  content_length = ll < 100 ? field_length - 2 | field_length - 4;
  info = {@info, su:left("Minute", field_length) + su:left("Hour", field_length) + su:left("Day", field_length) + su:left("Month", field_length) + su:left("Weekday", field_length)};
  line = su:left(this:get_range_representation(task_minute)[1..min(content_length, $)], field_length) + su:left(this:get_range_representation(task_hour)[1..min(content_length, $)], field_length);
  line = line + su:left(this:get_range_representation(task_day)[1..min(content_length, $)], field_length) + su:left(this:get_range_representation(task_month)[1..min(content_length, $)], field_length);
  line = line + su:left(this:get_range_representation(task_weekday)[1..min(field_length, $)], field_length);
  info = {@info, line};
  info = {@info, su:left(("Verb: " + $code_utils:corify_object(object) + ":" + verb + "(" + toliteral(task_args)[2..$ - 1] + ")")[1..min(ll, $)], ll), ""};
  return info;
endif
"Last modified Thu Sep 14 08:21:15 2017 CDT by Jason Perino (#91@ThetaCore).";
