#61:news_display_seq_full   this none this rxd

":news_display_seq_full(msg_seq) => {cur, last-read-date}";
"Display the given msg_seq as a collection of news items";
set_task_perms(caller_perms());
desc = this:description();
player:notify(typeof(desc) == LIST ? desc[1] | desc);
player:notify("");
msgs = this:messages_in_seq(args[1]);
for i in [-(n = length(msgs))..-1]
  x = msgs[-i];
  player:notify_lines(this:to_text(@x[2]));
  player:notify("");
  $command_utils:suspend_if_needed(0);
endfor
player:notify("(end)");
return {msgs[n][1], msgs[n][2][1]};
