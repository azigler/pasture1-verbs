#132:init_for_core   this none this xd

!caller_perms().wizard && raise(E_PERM);
for p in (properties(this))
  if (p[$ - 3..$] == "_log")
    delete_property(this, p);
  endif
endfor
this.max_log_length = 5000;
this.default_log_audience = 4;
this.default_log_level = 2;
level = `this.log_levels[1] ! ANY => ""';
this.log_levels = {"debug", "info", "notice", "warning", "alert", "error", "critical", "emergency"};
if (level)
  info = verb_info(this, level)[1..2];
  info = {@info, $string_utils:from_list(this.log_levels, " ")};
  set_verb_info(this, level, info);
else
  player:tell("Warning: Couldn't reset log levels on logger.");
endif
"Last modified Mon Mar 12 05:24:58 2018 CDT by Jason Perino (#91@ThetaCore).";
