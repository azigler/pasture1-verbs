#16:suspicious_address   this none this rxd

"suspicious(address [,who])";
"Determine whether an address appears to be another player in disguise.";
"returns a list of similar addresses.";
"If second argument given, then if all similar addresses are held by that";
"person, let it pass---they're just switching departments at the same school";
"or something.";
"";
"at the moment,";
"  foo@bar.baz.bing.boo";
"is considered 'similar' to anything matching";
"  foo@*.bing.boo";
if (!caller_perms().wizard)
  return E_PERM;
endif
{address, ?allowed = #-1} = args;
{userid, site} = $network:parse_address(address);
exact = !site && this:find_exact(address);
if (!site)
  site = $network.site;
endif
site = $network:local_domain(site);
sitelen = length(site);
others = this:find_all_keys(userid + "@");
for other in (others)
  if (other[max(1, $ - sitelen + 1)..$] != site)
    others = setremove(others, other);
  endif
endfor
if (exact)
  others = listinsert(others, address);
endif
for x in (others)
  allzapped = 1;
  for y in (this:find_exact(x))
    if (length(y) == 2 && (y[2] == "zapped due to inactivity" || y[2] == "toaded due to inactivity") || y[1] == allowed || ($object_utils:has_property($local, "second_char_registry") && typeof(them = $local.second_char_registry:other_chars(y[1])) == LIST && allowed in them))
      "let them change to the address if it is them, or if it is a registered char of theirs.";
      "Hrm. Need typeof==LIST check because returns E_INVARG for shared characters. bleah Ho_Yan 5/8/95";
    else
      allzapped = 0;
    endif
  endfor
  if (allzapped)
    others = setremove(others, x);
  endif
endfor
return others;
