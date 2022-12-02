#1:do_examine   this none this rxd

"do_examine(examiner)";
"the guts of examine";
"call a series of verbs and report their return values to the player";
who = args[1];
"if (caller == this || caller == who)";
if (caller == who)
  "set_task_perms();";
  who:notify_lines(this:examine_names(who) || {});
  "this:examine_names(who);";
  who:notify_lines(this:examine_owner(who) || {});
  "this:examine_owner(who);";
  who:notify_lines(this:examine_desc(who) || {});
  "this:examine_desc(who);";
  who:notify_lines(this:examine_key(who) || {});
  "this:examine_key(who);";
  who:notify_lines(this:examine_contents(who) || {});
  who:notify_lines(this:examine_verbs(who) || {});
else
  return E_PERM;
endif
