#10:"blacklisted graylisted redlisted spooflisted"   this none this rxd

":blacklisted(hostname) => is hostname on the .blacklist";
":graylisted(hostname)  => is hostname on the .graylist";
":redlisted(hostname)   => is hostname on the .redlist";
sitelist = this.(this:listname(verb));
if (!caller_perms().wizard)
  return E_PERM;
elseif ((hostname = args[1]) in sitelist[1] || hostname in sitelist[2])
  return 1;
elseif ($site_db:domain_literal(hostname))
  for lit in (sitelist[1])
    if (index(hostname, lit) == 1 && (hostname + ".")[length(lit) + 1] == ".")
      return 1;
    endif
  endfor
else
  for dom in (sitelist[2])
    if (index(dom, "*"))
      "...we have a wildcard; let :match_string deal with it...";
      if ($string_utils:match_string(hostname, dom))
        return 1;
      endif
    else
      "...tail of hostname ...";
      if ((r = rindex(hostname, dom)) && (("." + hostname)[r] == "." && r - 1 + length(dom) == length(hostname)))
        return 1;
      endif
    endif
  endfor
endif
return this:(verb + "_temp")(hostname);
