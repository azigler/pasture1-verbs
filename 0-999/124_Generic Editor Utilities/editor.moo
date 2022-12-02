#124:editor   this none this rxd

{?text = {}, ?prompt = "[Type lines of input; use `.' to end.]", ?commandchar = this:get_opt("cmd_char", player), ?verb = 0, ?extra = {}} = args;
"Arguments:";
"  text: The text to be edited.";
"  prompt: The prompt displayed to the player to ask for input.";
"  commandchar: The character used to indicate an editor command vs text to be added.";
"  verb: A flag indicating whether or not this is verb code, which will add editor commands for compilation and commenting.";
"  extra: Extra information passed in, primarily for verb info to use with the compile command.";
if (typeof(text) == STR)
  text = {text};
elseif (typeof(text) != LIST)
  return raise(E_TYPE, "Invalid datatype");
endif
this:log_last_edit(player, task_id());
state = $edit_state:new(text, verb, extra);
"NOTE: The waif is created AND destroyed in-verb. It is NOT persistant!";
player:tell(prompt);
if (state.verb && state.extra)
  verb_name = tostr($string_utils:nn(state.extra[1][1]), ":", state.extra[1][2]);
  player:tell("Now editing ", verb_name, ".");
  state.verb_name = verb_name;
endif
state.ins = length(state.text) + 1;
player:tell("Insertion point is before line ", state.ins, ".");
if (this:get_option("expert") == 0)
  player:tell();
  player:tell("Type '", commandchar, "help' for assistance, '", commandchar, "abort' to abandon.");
endif
while loop (1)
  try
    if (!player:is_listening())
      return;
    endif
    cont = 1;
    !this:get_option("no_line_notifies") && player:tell("  >");
    line = read(player);
    if (typeof(line) != STR)
      return state.text;
    endif
    if (line == "@abort")
      player:tell(">> Command Aborted <<");
      kill_task(task_id());
    elseif (line == "..")
      line = ".";
    elseif (line == ".")
      line = this:get_option("cmd_char") + "done";
    endif
    if (`line[1] ! ANY' == commandchar)
      cmd = $string_utils:explode(line[2..$]);
      if (commandchar == "." && !cmd)
        line = this:get_option("cmd_char") + "done";
      elseif (!cmd)
        player:tell("You must enter a command. (", commandchar, "help for help.)");
        continue;
      endif
      state.command = cmd[1];
      state.arg = cmd[2..$];
      if (state.command in {"insert", "ins", "inse", "inser"})
        this:cmd_insert(state);
      elseif (state.command in {"previous", "prev", "p"})
        this:cmd_previous(state);
      elseif (state.command in {"next", "n"})
        this:cmd_next(state);
      elseif (state.command in {"paste", "load"})
        this:cmd_load(state);
      elseif (state.command in {"copy", "save"})
        this:cmd_save(state);
      elseif (state.command == "pass")
        this:cmd_pass(state);
      elseif (state.command in {"reload", "rehash"})
        return this:cmd_reload(@args, state);
      elseif (state.command in {"change", "changeline"})
        this:cmd_changeline(state);
      elseif (state.command in {"replace", "repl", "re"})
        this:cmd_replace(state);
      elseif (state.command in {"find", "search", "GREP", "f", "s"})
        this:cmd_grep(state);
      elseif (state.command in {"done", "quit", "q"})
        if (typeof(ret = this:cmd_quit(state)) == ERR)
          continue;
        else
          return state.text;
        endif
      elseif (state.command in {"abort", "abandon", "q!"})
        player:tell(">> Command Aborted <<");
        kill_task(task_id());
      elseif (state.verb && state.extra && state.command in {"what", "verb"})
        player:tell("Currently editing: ", state.extra[1][1]:nn(), ":", state.extra[1][2], ".");
      elseif (state.verb && state.extra && state.command in {"compile", "w", "send"})
        {object, verbname} = state.extra[1];
        program = this:program_verb(object, verbname, state);
      elseif (state.verb && state.command[1] == "/")
        "Assume they want to make a verb comment.";
        line = "\"" + line[3..$] + "\";";
        cont = 0;
      elseif (state.command == "import")
        this:cmd_paste_letter(state);
      elseif (state.command == "set")
        this:options($string_utils:from_list(state.arg, " "));
      elseif (state.command in {"del", "dele", "delet", "delete", "erase", "rm"})
        this:cmd_delete(state);
      elseif (state.command in {"list", "l", "view"})
        this:cmd_list(state);
      elseif (state.verb && state.command in {"comment", "commentify"})
        this:cmd_commentify(state);
      elseif (state.verb && state.command in {"uncomment", "uncommentify"})
        this:cmd_uncommentify(state);
      elseif (state.command in {"spellcheck", "spell"})
        state.text = $spell:interactive_spellcheck(state.text);
        player:tell("Spell check completed.");
      elseif (state.command == "count")
        this:cmd_count(state);
      elseif (state.verb && state.command in {"tb", "jtb"})
        this:cmd_traceback(state);
      elseif (state.verb && state.command in {"ptb", "print_traceback"})
        this:cmd_print_traceback(state);
      elseif (state.verb && state.command in {"local", "localedit"})
        this:cmd_localedit(state);
      elseif (state.command in {"format", "form"})
        this:cmd_format(state);
      elseif (state.command in {"help", "?"})
        this:cmd_help(state);
      elseif (state.command in {"clipboard", "saved", "clip"})
        this:cmd_show_clipboard(state);
      else
        player:tell("Unrecognized command. (", commandchar, "help for help.)");
      endif
      if (cont != 0)
        continue;
      endif
    endif
    this:do_add_line(state, line);
  except error (ANY)
    player:tell("Something has gone wrong...");
    player:tell(toliteral(error));
    break;
    continue;
  endtry
endwhile
