#124:program_verb   this none this rxd

{object, verbname, state} = args;
ret = 0;
try
  set_task_perms(player);
  simpleedit = $mcp.registry:match_package("dns-org-mud-moo-simpleedit");
  if (result = set_verb_code(object, verbname, typeof(simpleedit) == ERR ? state.text | simpleedit:verbcode_external_to_internal(state.text)))
    player:notify_lines(result);
    player:notify(tostr(length(result), " error(s)."));
    player:notify("Verb not programmed.");
    state.traceback = result;
    line_error = $string_utils:match_string(result[1], "Line *: *");
    if (line_error != 0)
      line_error = toint(line_error[1]);
      state.traceback_line = line_error;
      if (this:get_option("jump_to_error") && line_error != 0)
        if (line_error > 0 && line_error <= length(state.text) + 1)
          state.ins = line_error;
        endif
      endif
    endif
  else
    player:notify("0 errors.");
    player:notify(tostr(object, ":", verbname, " successfully compiled."));
    if ($code_utils:update_last_modified(object, verbname))
      player:notify("** Time-stamping failed.");
    endif
  endif
except error (ANY)
  player:notify(error[2]);
  player:notify("Verb not programmed.");
endtry
"Last modified Fri Dec  2 22:22:46 2022 UTC by Saeed (#128).";
