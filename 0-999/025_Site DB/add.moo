#25:add   this none this rxd

":add(player,site)";
if (!caller_perms().wizard)
  return E_PERM;
endif
{who, domain} = args;
if (this:domain_literal(domain))
  "... just enter it...";
  l = this:find_exact(domain);
  if (l == $failed_match)
    this:insert(domain, {who});
  elseif (!(who in l))
    this:insert(domain, setadd(l, who));
  endif
else
  "...an actual domain name; add player to list for that domain...";
  "...then add domain itself to list for the next larger domain; repeat...";
  "...  Example:  domain == foo.bar.edu:  ";
  "...            enter #who  on foo.bar.edu list";
  "...            enter `foo' on bar.edu list";
  "...            enter `bar' on edu list";
  if (!(dot = index(domain, ".")))
    dot = length(domain) + 1;
    domain = tostr(domain, ".", this.domain);
  endif
  prev = who;
  while ($failed_match == (l = this:find_exact(domain)))
    this:insert(domain, {prev});
    if (dot)
      prev = domain[1..dot - 1];
      domain = domain[dot + 1..$];
    else
      return;
    endif
    dot = index(domain, ".");
  endwhile
  if (!(prev in l))
    this:insert(domain, {@l, prev});
  endif
  return;
endif
