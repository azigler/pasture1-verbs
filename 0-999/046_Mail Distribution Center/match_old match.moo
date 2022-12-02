#46:"match_old match"   this none this rxd

":match(string) => mailing list object in here that matches string.";
":match(string,player) => similar but also matches against player's private mailing lists (as kept in .mail_lists).";
if (!(string = args[1]))
  return $nothing;
elseif (string[1] == "*")
  string = string[2..$];
endif
if (valid(o = $string_utils:literal_object(string)) && $mail_recipient in $object_utils:ancestors(o))
  return o;
elseif (rp = this:reserved_pattern(string))
  return rp[2]:match_mail_recipient(string);
else
  if (valid(who = {@args, player}[2]) && typeof(use = `who.mail_lists ! E_PROPNF, E_PERM') == LIST)
    use = {@this.contents, @use};
  else
    use = this.contents;
  endif
  partial = 1;
  string = strsub(string, "_", "-");
  for l in (use)
    if (string in l.aliases)
      return l;
    endif
    if (partial != $ambiguous_match)
      for a in (l.aliases)
        if (index(a, string) == 1 && !index(a, " "))
          if (partial)
            partial = l;
          elseif (partial != l)
            partial = $ambiguous_match;
          endif
        endif
        $command_utils:suspend_if_needed(0);
      endfor
    endif
  endfor
  return partial && $failed_match;
endif
