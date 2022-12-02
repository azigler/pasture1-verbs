#56:validate_feature   this none this rxd

":validate_feature(verb, args)";
"  (where `verb' and `args' are the arguments passed to :my_huh)";
"  returns true or false based on whether this is the same command typed by the user (comparing it against $command_utils.feature_task, set by $command_utils:do_huh).";
"  assumes that the :my_huh parsing has not suspended";
return {task_id(), @args, argstr, dobj, dobjstr, prepstr, iobj, iobjstr} == this.feature_task;
