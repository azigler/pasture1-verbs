#132:"debug info notice warning alert error critical emergency"   this none this xd

":(level)(title, msg): Write a message to a log.";
{title, msg} = args;
!caller_perms().wizard && raise(E_PERM);
level = verb in this.log_levels;
level_desc = $string_utils:capitalize(verb);
if (typeof(msg) == LIST && length(msg) == 1)
  msg = msg[1];
endif
if (!$object_utils:has_property(this, title + "_log"))
  add_property(this, title + "_log", {this.default_log_audience, {}}, {#2, ""});
endif
this.(title + "_log")[2] = {@this.(title + "_log")[2], {time(), level, msg}};
if (length(this.(title + "_log")[2]) > this.max_log_length)
  this.(title + "_log")[2] = this.(title + "_log")[2][$ - (this.max_log_length - 1)..$];
endif
audience = this:get_log_audience(title);
players = connected_players();
for p in (players)
  "Audience check.";
  if (audience == 4 && !p.wizard || (audience == 3 && !p.programmer) || (audience == 2 && !$object_utils:isa(p, $builder)) || this:get_log_level_for(p, title) > level)
    players = setremove(players, p);
  endif
endfor
if (players)
  title = $string_utils:uppercase(title);
  for x in (players)
    if (typeof(msg) == LIST)
      level != this.default_log_level && x:tell("[" + title + "] " + level_desc + ":");
      for m in (msg)
        x:tell("[" + title + "] " + m);
      endfor
    else
      x:tell("[" + title + "] " + (level != this.default_log_level ? level_desc + ": " | "") + msg);
    endif
  endfor
endif
"Last modified Mon Mar 12 04:15:34 2018 CDT by Jason Perino (#91@ThetaCore).";
