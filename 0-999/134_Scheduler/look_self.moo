#134:look_self   this none this rxd

lu = $list_utils;
su = $string_utils;
tu = $time_utils;
pass();
player = callers()[$][5];
ll = `player:linelen() ! ANY => 79';
if (player.wizard && ll >= 79)
  player:tell("");
  if (!this.timer_tasks && !this.cron_tasks)
    return player:tell("No tasks.");
  endif
  if (this.timer_tasks)
    player:tell(su:center("Scheduled timer tasks:", ll));
    field_length = (ll < 100 ? ll - 12 | ll - 14) / 4;
    content_length = ll < 100 ? field_length - 2 | field_length - 4;
    player:tell("");
    player:tell(su:left("ID", 14) + su:left("Next Run", field_length) + su:left("Interval", field_length) + su:left("Owner", field_length) + su:left("Verb", field_length));
    player:tell(su:space(ll, "-"));
    for t in (lu:sort_alist(this.timer_tasks, 4))
      {task_id, task_interval, task_schedule_time, task_time, task_owner, object, verb, task_args} = t;
      line = su:left(tostr(task_id), ll < 100 ? 12 | 14) + su:left(tu:dhms(task_time - time())[1..min(content_length, $)], field_length);
      line = line + su:left(task_interval ? tu:dhms(task_interval)[1..min(content_length, $)] | "", field_length);
      line = line + su:left((`task_owner:titlec() ! ANY => task_owner.name' + (field_length >= 20 ? " (" + tostr(task_owner) + ")" | ""))[1..min(content_length, $)], field_length);
      line = line + su:left(((field_length >= 20 ? $code_utils:corify_object(object) | tostr(object)) + ":" + verb + "(" + toliteral(task_args)[2..$ - 1] + ")")[1..min(field_length, $)], field_length);
      player:tell(line);
    endfor
    player:tell(su:space(ll, "-"));
    player:tell("");
  endif
  if (this.cron_tasks)
    player:tell(su:center("Scheduled Cron tasks:", ll));
    l1_field_length = (ll - (ll < 100 ? 12 | 14)) / 2;
    l1_content_length = l1_field_length - (ll < 100 ? 2 | 4);
    l2_field_length = ll / 5;
    l2_content_length = ll < 100 ? l2_field_length - 2 | l2_field_length - 4;
    player:tell("");
    player:tell(su:left("ID", 14) + su:left("Last Run", l1_field_length) + su:left("Owner", l1_field_length));
    player:tell(su:left("Minute", l2_field_length) + su:left("Hour", l2_field_length) + su:left("Day", l2_field_length) + su:left("Month", l2_field_length) + su:left("Weekday", l2_field_length));
    player:tell(su:left("Verb", ll));
    player:tell(su:space(ll, "-"));
    for ct in (this.cron_tasks)
      {task_id, task_last_run, task_minute, task_hour, task_day, task_month, task_weekday, task_owner, object, verb, task_args} = ct;
      player:tell(su:left(tostr(task_id), 14) + su:left(task_last_run ? tu:dhms(time() - task_last_run)[1..min(l1_content_length, $)] | "", l1_field_length) + su:left((`task_owner:titlec() ! ANY => task_owner.name' + " (" + tostr(task_owner) + ")")[1..min(l1_field_length, $)], l1_field_length));
      line = su:left(this:get_range_representation(task_minute)[1..min(l2_content_length, $)], l2_field_length) + su:left(this:get_range_representation(task_hour)[1..min(l2_content_length, $)], l2_field_length);
      line = line + su:left(this:get_range_representation(task_day)[1..min(l2_content_length, $)], l2_field_length) + su:left(this:get_range_representation(task_month)[1..min(l2_content_length, $)], l2_field_length);
      line = line + su:left(this:get_range_representation(task_weekday)[1..min(l2_field_length, $)], l2_field_length);
      player:tell(line);
      player:tell(su:left(($code_utils:corify_object(object) + ":" + verb + "(" + toliteral(task_args)[2..$ - 1] + ")")[1..min(ll, $)], ll));
      player:tell("");
    endfor
    player:tell(su:space(ll, "-"));
  endif
endif
"Last modified Mon Sep 11 09:14:22 2017 CDT by Jason Perino (#91@ThetaCore).";
