#57:@status*-all   none none none rxd

"An extensive report on the status of the MOO's internal state.";
if (!player.wizard)
  player:tell("Nope.");
  return E_PERM;
endif
{load_avg, user_time, system_time, reclaims, faults, blocked_input, blocked_output, voluntary, involuntary, signals} = usage();
magic_number = 65536.0;
for x in [1..length(load_avg)]
  load_avg[x] = $math_utils:precision(tofloat(load_avg[x]) / magic_number, 2);
endfor
size = $math_utils:precision(tofloat(db_disk_size()) / 1024.0 / 1024.0, 2);
mem = call_function("memory_usage");
garbage = {};
try
  for x in (mapkeys(gc = call_function("gc_stats")))
    garbage = {@garbage, tostr(x, ": ", gc[x])};
  endfor
except (ANY)
endtry
mem_total = $string_utils:bytes_to_human(mem[1] * 4.0 * 1024.0);
mem_resident = $string_utils:bytes_to_human(mem[2] * 4.0 * 1024.0);
"---";
player:tell($network.moo_name, " Exhaustive Status Report");
player:tell("");
ret = {};
ret = {@ret, {"Server Version", server_version()}};
ret = {@ret, {"Uptime", $time_utils:english_time(time() - $server["last_restart_time"])}};
ret = {@ret, {"Current Load Averages", $string_utils:english_list(load_avg, "n/a", " ")}};
ret = {@ret, {"Total CPU Time Used", tostr("User: ", $math_utils:precision(user_time, 2), " seconds, System: ", $math_utils:precision(system_time, 2), " seconds")}};
ret = {@ret, {"Estimated Lag", tostr($login:current_lag(), " seconds")}};
ret = {@ret, {"Memory Usage", tostr("Total: ", mem_total, ", Resident: ", mem_resident)}};
ret = {@ret, {"Database Disk Size", tostr(size, " MB")}};
ret = {@ret, {"Blocked IO", tostr("Input: ", blocked_input, ", Output: ", blocked_output)}};
ret = {@ret, {"Context Switches", tostr(voluntary, " voluntary, ", involuntary, " involuntary")}};
ret = {@ret, {"Signals", tostr(signals)}};
ret = {@ret, {"Page", tostr(reclaims, " reclaims, ", faults, " faults")}};
ret = {@ret, {"Garbage Collection", $string_utils:english_list(garbage, "n/a", " ")}};
ret = {@ret, {"Total Waifs", tostr($string_utils:group_number(waif_stats()["total"]))}};
if ($code_utils:verbname_match("@status-all", verb))
  ret = {@ret, {"Object Count", tostr($string_utils:group_number(toint(max_object())))}};
  ret = {@ret, {"Players", tostr(length(players()))}};
  ret = {@ret, {"SQLite Handles", $string_utils:english_list(sqlite_handles())}};
  ret = {@ret, {"File Handles", $string_utils:english_list(file_handles())}};
  ret = {@ret, {"Active Threads", $string_utils:english_list(threads())}};
endif
player:tell_lines($string_utils:autofit(ret));
