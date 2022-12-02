#10:server_started   this none this rxd

"Called by #0:server_started when the server restarts.";
if (caller_perms().wizard)
  this.lag_samples = {0, 0, 0, 0, 0};
  this.downtimes = {{time(), this.last_lag_sample}, @this.downtimes[1..min($, 100)]};
  this.intercepted_players = this.intercepted_actions = {};
  this.name_lookup_players = {};
  this.checkpoint_in_progress = 0;
  this.current_numcommands = [];
endif
