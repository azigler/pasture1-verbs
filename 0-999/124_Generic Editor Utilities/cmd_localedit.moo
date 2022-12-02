#124:cmd_localedit   this none this rxd

{state} = args;
oldoption = this:get_option("default_editor");
this:set_option(player, "default_editor", 0);
$verb_editor:invoke(tostr(state.extra[1][1]) + ":" + state.extra[1][2], "@program", state.text);
this:set_option(player, "default_editor", oldoption);
kill_task(task_id());
