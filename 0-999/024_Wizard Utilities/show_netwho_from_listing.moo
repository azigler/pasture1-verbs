#24:show_netwho_from_listing   this none this rxd

":show_netwho_from_listing(tell,site)";
"@net-who from hoststring prints all players who have connected from that host or host substring.  Substring can include *'s, e.g. @net-who from *.foo.edu.";
if (!caller_perms().wizard)
  return E_PERM;
endif
{tellwho, where} = args;
su = $string_utils;
if (!index(where, "*"))
  "Oh good... search for users from a site... the fast way.  No wild cards.";
  nl = 0;
  bozos = {};
  sites = $site_db:find_all_keys(where);
  while (sites)
    s = sites;
    sites = {};
    for domain in (s)
      "Temporary kluge until $site_db is repaired. --Nosredna";
      for b in ($site_db:find_exact(domain) || {})
        $command_utils:suspend_if_needed(0, "..netwho..");
        if (typeof(b) == STR)
          sites = setadd(sites, b + "." + domain);
        else
          bozos = setadd(bozos, b);
          nl = max(length(tostr(b, valid(b) && is_player(b) ? b.name | "*** recreated ***")), nl);
        endif
      endfor
    endfor
  endwhile
  if (bozos)
    tellwho:notify(tostr(su:left("  Player", nl + 7), "From"));
    tellwho:notify(tostr(su:left("  ------", nl + 7), "----"));
    for who in (bozos)
      st = su:left(tostr(valid(who) && is_player(who) ? (who.programmer ? "% " | "  ") + who.name | "", " (", who, ")"), nl + 7);
      comma = 0;
      if ($object_utils:isa(who, $player) && is_player(who))
        for p in ({$wiz_utils:get_email_address(who) || "*Unregistered*", @who.all_connect_places})
          if (comma && length(p) >= 78 - length(st))
            tellwho:notify(tostr(st, ","));
            st = su:space(nl + 7) + p;
          else
            st = tostr(st, comma ? ", " | "", p);
          endif
          comma = 1;
          $command_utils:suspend_if_needed(0);
        endfor
      else
        st = st + (valid(who) ? "*** recreated ***" | "*** recycled ***");
      endif
      tellwho:notify(st);
    endfor
    tellwho:notify("");
    tellwho:notify(tostr(length(bozos), " player", length(bozos) == 1 ? "" | "s", " found."));
  else
    tellwho:notify(tostr("No sites matching `", where, "'"));
  endif
else
  "User typed 'from'.  Go search for users from this site.  (SLOW!)";
  howmany = 0;
  for who in (players())
    $command_utils:suspend_if_needed(0);
    matches = {};
    for name in (who.all_connect_places)
      if (index(where, "*") && su:match_string(name, where) || (!index(where, "*") && index(name, where)))
        matches = {@matches, name};
      endif
    endfor
    if (matches)
      howmany = howmany + 1;
      tellwho:notify(tostr(who.name, " (", who, "): ", su:english_list(matches)));
    endif
  endfor
  tellwho:notify(tostr(howmany || "No", " matches found."));
endif
