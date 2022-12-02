#50:"lis*t view"   any any any rd

nonum = 0;
if (verb == "view")
  if (!args)
    l = {};
    for i in [1..length(this.active)]
      if (this.readable[i])
        l = {@l, this.active[i]};
      endif
    endfor
    if (l)
      player:tell("Players having readable texts in this editor:  ", $string_utils:names_of(l));
    else
      player:tell("No one has published anything in this editor.");
    endif
    return;
  elseif ($command_utils:player_match_result(plyr = $string_utils:match_player(args[1]), args[1])[1])
    "...no such player";
    return;
  elseif (!(who = this:loaded(plyr)) || !this:readable(who))
    player:tell(plyr.name, "(", plyr, ") has not published anything in this editor.");
    return;
  endif
  args = listdelete(args, 1);
elseif (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
endif
len = length(this.texts[who]);
ins = this.inserting[who];
window = 8;
if (len < 2 * window)
  default = {"1-$"};
elseif (ins <= window)
  default = {tostr("1-", 2 * window)};
else
  default = {tostr(window, "_-", window, "^"), tostr(2 * window, "$-$")};
endif
if (typeof(range = this:parse_range(who, default, @args)) != LIST)
  player:tell(tostr(range));
elseif (range[3] && !(nonum = "nonum" == $string_utils:trim(range[3])))
  player:tell("Don't understand this:  ", range[3]);
elseif (nonum)
  player:tell_lines(this.texts[who][range[1]..range[2]]);
else
  for line in [range[1]..range[2]]
    this:list_line(who, line);
    if ($command_utils:running_out_of_time())
      suspend(0);
      if (!(who = this:loaded(player)))
        player:tell("ack!  something bad happened during a suspend...");
        return;
      endif
    endif
  endfor
  if (ins > len && len == range[2])
    player:tell("^^^^");
  endif
endif
