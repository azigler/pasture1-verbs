#10:"co*nnect @co*nnect"   any none any rxd

"$login:connect(player-name [, password])";
" => 0 (for failed connections)";
" => objnum (for successful connections)";
caller == #0 || caller == this || raise(E_PERM);
"=================================================================";
"=== Check arguments, print usage notice if necessary";
try
  {name, ?password = 0} = args;
  name = strsub(name, " ", "_");
except (E_ARGS)
  notify(player, tostr("Usage:  ", verb, " <existing-player-name> <password>"));
  return 0;
endtry
try
  "=================================================================";
  "=== Is our candidate name invalid?";
  if (!valid(candidate = orig_candidate = this:_match_player(name)))
    raise(E_INVARG, tostr("`", name, "' matches no player name."));
  endif
  "=================================================================";
  "=== Is our candidate unable to connect for generic security";
  "=== reasons (ie clear password, non-player object)?";
  if (`is_clear_property(candidate, "password") ! E_PROPNF' || !$object_utils:isa(candidate, $player))
    server_log(tostr("FAILED CONNECT: ", name, " (", candidate, ") on ", connection_name(player), $string_utils:connection_hostname(player) in candidate.all_connect_places ? "" | "******"));
    raise(E_INVARG);
  endif
  "=================================================================";
  "=== Check password";
  if (typeof(cp = candidate.password) == STR)
    "=== Candidate requires a password";
    if (password)
      "=== Candidate requires a password, and one was provided";
      if (!argon2_verify(cp, password))
        "=== Candidate requires a password, and one was provided, which was wrong";
        server_log(tostr("FAILED CONNECT: ", name, " (", candidate, ") on ", connection_name(player), $string_utils:connection_hostname(player) in candidate.all_connect_places ? "" | "******"));
        raise(E_INVARG, "Invalid password.");
      else
        "=== Candidate requires a password, and one was provided, which was right";
      endif
    else
      "=== Candidate requires a password, and none was provided";
      set_connection_option(player, "binary", 1);
      notify(player, "Password: ");
      set_connection_option(player, "binary", 0);
      set_connection_option(player, "client-echo", 0);
      this:add_interception(player, "intercepted_password", candidate);
      return 0;
    endif
  elseif (cp == 0)
    "=== Candidate does not require a password";
  else
    "=== Candidate has a nonstandard password; something's wrong";
    raise(E_INVARG);
  endif
  "=================================================================";
  "=== Is the player locked out?";
  if (this.no_connect_message && !candidate.wizard)
    notify(player, this.no_connect_message);
    server_log(tostr("REJECTED CONNECT: ", name, " (", candidate, ") on ", connection_name(player)));
    return 0;
  endif
  "=================================================================";
  "=== Check guest connections";
  if ($object_utils:isa(candidate, $guest) && !valid(candidate = candidate:defer()))
    if (candidate == #-2)
      server_log(tostr("GUEST DENIED: ", connection_name(player)));
      notify(player, "Sorry, guest characters are not allowed from your site at the current time.");
    else
      notify(player, "Sorry, all of our guest characters are in use right now.");
    endif
    return 0;
  endif
  "=================================================================";
  "=== Check newts";
  if (candidate in this.newted)
    if (entry = $list_utils:assoc(candidate, this.temporary_newts))
      if ((uptime = this:uptime_since(entry[2])) > entry[3])
        "Temporary newting period is over.  Remove entry.  Oh, send mail, too.";
        this.temporary_newts = setremove(this.temporary_newts, entry);
        this.newted = setremove(this.newted, candidate);
        fork (0)
          player = this.owner;
          $mail_agent:send_message(player, $newt_log, tostr("automatic @unnewt ", candidate.name, " (", candidate, ")"), {"message sent from $login:connect"});
        endfork
      else
        notify(player, "");
        notify(player, this:temp_newt_registration_string(entry[3] - uptime));
        boot_player(player);
        return 0;
      endif
    else
      notify(player, "");
      notify(player, this:newt_registration_string());
      boot_player(player);
      return 0;
    endif
  endif
  "=================================================================";
  "=== Connection limits based on lag";
  if (!candidate.wizard && !(candidate in this.lag_exemptions) && (howmany = length(connected_players())) >= (max = this:max_connections()) && !$object_utils:connected(candidate))
    notify(player, $string_utils:subst(this.connection_limit_msg, {{"%n", tostr(howmany)}, {"%m", tostr(max)}, {"%l", tostr(this:current_lag())}, {"%t", candidate.last_connect_attempt ? ctime(candidate.last_connect_attempt) | "not recorded"}}));
    candidate.last_connect_attempt = time();
    server_log(tostr("CONNECTION LIMIT EXCEEDED: ", name, " (", candidate, ") on ", connection_name(player)));
    boot_player(player);
    return 0;
  endif
  "=================================================================";
  "=== Log the player on!";
  if (candidate != orig_candidate)
    notify(player, tostr("Okay,... ", name, " is in use.  Logging you in as `", candidate.name, "'"));
  endif
  this:record_connection(candidate);
  return candidate;
except (E_INVARG)
  notify(player, "Either that player does not exist, or has a different password.");
  return 0;
endtry
