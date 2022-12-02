#72:local_domain   this none this rxd

"given a site, try to figure out what the `local' domain is.";
"if site has a @ or a % in it, give up and return E_INVARG.";
"blank site is returned as is; try this:local_domain(this.localhost) for the answer you probably want.";
site = args[1];
if (index(site, "@") || index(site, "%"))
  return E_INVARG;
elseif (match(site, "^[0-9.]+$"))
  return E_INVARG;
elseif (!site)
  return "";
elseif (!(dot = rindex(site, ".")))
  dot = rindex(site = this.site, ".");
endif
if (!dot || !(dot = rindex(site[1..dot - 1], ".")))
  return site;
else
  domain = site[dot + 1..$];
  site = site[1..dot - 1];
  while (site && domain in this.large_domains)
    if (dot = rindex(site, "."))
      domain = tostr(site[dot + 1..$], ".", domain);
      site = site[1..dot - 1];
    else
      return tostr(site, ".", domain);
    endif
  endwhile
  return domain;
endif
