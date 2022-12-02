#6:emote   any any any rxd

loc = this.location;
if (isa(loc, $room) == 0)
  return this:tell("You find that you cannot do much of anything.");
endif
if (!args)
  return this:tell("What would you like to do?");
endif
emote = $string_utils:from_list(args, " ");
"nospace is a string containing either space or nothing, used after the player name if noname is 1.";
{noname = 0, nospace = " "};
if ("@me" in emote)
  noname = 1;
endif
if (emote[1] == "'")
  nospace = "";
endif
emote = $string_utils:explode(emote);
"we split the emote into words, now we loop through it and check if an at symbol is used. if so, replace the element with the shortdesc of a player, or the title of an object.";
for j, count in (emote)
  if (j[1] == "@")
    if (j[2..$] == "my")
      emote[count] = this.pp;
      continue;
    endif
    if (j[2..$] == "me")
      emote[count] = this.name;
      continue;
    endif
    item = loc:match(j[$ - 1..$] == "'s" ? j[2..$ - 2] | j[2..$]);
    if ($command_utils:object_match_failed(item, j[2..$]))
      return;
    else
      emote[count] = isa(item, $player) ? "%" + tostr(item) | item:title();
      if (j[$ - 1..$] == "'s")
        emote[count] = emote[count] + "'s";
      endif
    endif
  endif
endfor
emote = $string_utils:from_list(emote, " ");
announce = $string_utils:substitute(noname == 0 ? this.name + nospace + emote | emote, {{"%n", this.name}});
return this.location:announce_all(announce);
