#47:"not-to*: uncc*:"   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
else
  recips = this.recipients[who];
  nonmrs = {};
  mrs = {};
  for o in (recips)
    if ($object_utils:isa(o, $mail_recipient))
      mrs = {@mrs, o};
    else
      nonmrs = {@nonmrs, o};
    endif
  endfor
  for a in (args)
    if (!a)
      player:tell("\"\"?");
      return;
    elseif (valid(aobj = $mail_agent:match_recipient(a)) && aobj in recips)
    elseif ($failed_match != (aobj = $string_utils:literal_object(a)))
      if (!(aobj in recips))
        player:tell(aobj, " was not a recipient.");
        return;
      endif
    elseif (a[1] == "*" && valid(aobj = $string_utils:match(a[2..$], mrs, "aliases")))
    elseif (a[1] != "*" && valid(aobj = $string_utils:match(a, nonmrs, "aliases")))
    elseif (valid(aobj = $string_utils:match(a, recips, "aliases")))
    else
      player:tell("couldn't find \"", a, "\" in To: list.");
      return;
    endif
    recips = setremove(recips, aobj);
  endfor
  this.recipients[who] = recips;
  this:set_changed(who, 1);
  player:tell("Your message is now to ", this:recipient_names(who), ".");
endif
