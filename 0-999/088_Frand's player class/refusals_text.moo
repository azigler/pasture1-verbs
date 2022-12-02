#88:refusals_text   this none this rxd

"'refusals_text (<player>, [<filter verb name>])' - Return text describing the given player's refusals. The filter verb name is optional; if it is given, this verb takes an origin and a list of actions and returns any actions which should be included in the refusals text. This verb works only if <player> is a player who has the refusals facility; it does not check for this itself.";
who = args[1];
"Used to allow you to supply the filter verb name, but that introduced a security hole. --Nosredna";
filter_verb = "default_refusals_text_filter";
text = {};
for i in [1..length(who.refused_origins)]
  origin = who.refused_origins[i];
  actions = this:(filter_verb)(origin, who.refused_actions[i]);
  if (actions)
    line = "";
    for action in (actions)
      line = line + " " + action;
    endfor
    line = this:refusal_origin_to_name(origin) + ": " + line;
    line = ctime(who.refused_until[i]) + " " + line;
    text = {@text, line};
  endif
endfor
if (!text)
  text = {"No refusals."};
endif
return text;
