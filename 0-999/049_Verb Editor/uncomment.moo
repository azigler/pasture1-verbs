#49:uncomment   any any any rd

"Syntax: uncomment [<range>]";
"";
"Turns the specified range of lines from comments to, uh, not comments.";
if (caller != player && caller_perms() != player)
  return E_PERM;
elseif (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (typeof(range = this:parse_range(who, {"."}, @args)) != LIST)
  player:tell(tostr(range));
elseif (range[3])
  player:tell_lines($code_utils:verb_documentation());
else
  text = this.texts[who];
  {from, to, crap} = range;
  bogus = {};
  for line in [from..to]
    if (match(text[line], "^ *\"%([^\\\"]%|\\.%)*\";$"))
      "check from $code_utils:verb_documentation";
      if (!bogus)
        text[line] = $no_one:eval(text[line])[2];
      endif
    else
      bogus = setadd(bogus, line);
    endif
  endfor
  if (bogus)
    player:tell(length(bogus) == 1 ? "Line" | "Lines", " ", $string_utils:english_list(bogus), " ", length(bogus) == 1 ? "is" | "are", " not comments.");
    player:tell("No changes.");
    return;
  endif
  this.texts[who] = text;
  player:tell(to == from ? "Line" | "Lines", " changed.");
  this.changes[who] = 1;
  this.times[who] = time();
endif
