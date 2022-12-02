#40:display_message   this none this rxd

":display_message(preamble,msg) --- prints msg to player.";
vb = this._mail_task == task_id() || caller == $mail_editor ? "notify_lines_suspended" | "tell_lines_suspended";
preamble = args[1];
player:(vb)({@typeof(preamble) == LIST ? preamble | {preamble}, @args[2], "--------------------------"});
