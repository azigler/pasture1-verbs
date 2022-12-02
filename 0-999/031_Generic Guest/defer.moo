#31:defer   this none this rxd

"Called by #0:connect_player when this object is about to be used as the next guest character.  Usually returns `this', but if for some reason some other guest character should be used, that player object is returned instead";
if (!caller_perms().wizard)
  "...caller is not :do_login_command; doesn't matter what we return...";
  return this;
elseif ($login:blacklisted($string_utils:connection_hostname(player)))
  return #-2;
elseif (!(this in connected_players()))
  "...not logged in, no problemo...";
  return this;
endif
longest = 900;
"...guests get 15 minutes before they can be dislodged...";
candidate = #-1;
free = {};
for g in ($object_utils:leaves($guest))
  if (!is_player(g))
    "...a toaded guest?...";
  elseif (!(con = g in connected_players()) && g.free_to_use)
    "...yay; found an unused guest...and their last :disfunc is complete";
    free = {@free, g};
  elseif (con && (t = connected_seconds(g)) > longest)
    longest = t;
    candidate = g;
  endif
endfor
if (free)
  candidate = free[random($)];
elseif (valid(candidate))
  "...someone's getting bumped...";
  candidate:boot();
endif
return candidate;
