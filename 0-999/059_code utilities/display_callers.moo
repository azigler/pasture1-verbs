#59:display_callers   this none this rxd

":display_callers([callers() style list]) - displays the output of the given argument, assumed to be a callers() output. See `help callers()' for details. Will use callers() explicitly if no argument is passed.";
call = caller_perms() == player ? "notify_lines" | "tell_lines";
player:(call)(this:callers_text(@args));
