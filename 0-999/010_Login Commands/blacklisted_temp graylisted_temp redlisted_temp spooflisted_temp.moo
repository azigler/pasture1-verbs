#10:"blacklisted_temp graylisted_temp redlisted_temp spooflisted_temp"   this none this rxd

":blacklisted_temp(hostname) => is hostname on the .blacklist...";
":graylisted_temp(hostname)  => is hostname on the .graylist...";
":redlisted_temp(hostname)   => is hostname on the .redlist...";
":spooflisted_temp(hostname) => is hostname on the .spooflist...";
"";
"... and the time limit hasn't run out.";
lname = this:listname(verb);
sitelist = this.("temporary_" + lname);
if (!caller_perms().wizard)
  return E_PERM;
elseif (entry = $list_utils:assoc(hostname = args[1], sitelist[1]))
  return this:templist_expired(lname, @entry);
elseif (entry = $list_utils:assoc(hostname, sitelist[2]))
  return this:templist_expired(lname, @entry);
elseif ($site_db:domain_literal(hostname))
  for lit in (sitelist[1])
    if (index(hostname, lit[1]) == 1 && (hostname + ".")[length(lit[1]) + 1] == ".")
      return this:templist_expired(lname, @lit);
    endif
  endfor
else
  for dom in (sitelist[2])
    if (index(dom[1], "*"))
      "...we have a wildcard; let :match_string deal with it...";
      if ($string_utils:match_string(hostname, dom[1]))
        return this:templist_expired(lname, @dom);
      endif
    else
      "...tail of hostname ...";
      if ((r = rindex(hostname, dom[1])) && (("." + hostname)[r] == "." && r - 1 + length(dom[1]) == length(hostname)))
        return this:templist_expired(lname, @dom);
      endif
    endif
  endfor
endif
return 0;
