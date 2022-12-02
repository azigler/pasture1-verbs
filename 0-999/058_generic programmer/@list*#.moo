#58:@list*#   any any any rd

"@list <obj>:<verb> [<dobj> <prep> <iobj>] [with[out] paren|num] [all] [ranges]";
set_task_perms(player);
bynumber = verb == "@list#";
pflag = player:prog_option("list_all_parens");
nflag = !player:prog_option("list_no_numbers");
permflag = player:prog_option("list_show_permissions");
aflag = 0;
argspec = {};
range = {};
spec = args ? $code_utils:parse_verbref(args[1]) | E_INVARG;
args = spec ? listdelete(args, 1) | E_INVARG;
while (args)
  if (args[1] && (index("without", args[1]) == 1 || args[1] == "wo"))
    "...w,wi,wit,with => 1; wo,witho,withou,without => 0...";
    fval = !index(args[1], "o");
    if (`index("parentheses", args[2]) ! ANY' == 1)
      pflag = fval;
      args[1..2] = {};
    elseif (`index("numbers", args[2]) ! ANY' == 1)
      nflag = fval;
      args[1..2] = {};
    else
      player:notify(tostr(args[1], " WHAT?"));
      args = E_INVARG;
    endif
  elseif (index("all", args[1]) == 1)
    if (bynumber)
      player:notify("Don't use `all' with @list#.");
      args = E_INVARG;
    else
      aflag = 1;
      args[1..1] = {};
    endif
  elseif (index("0123456789", args[1][1]) || index(args[1], "..") == 1)
    if (E_INVARG == (s = $seq_utils:from_string(args[1])))
      player:notify(tostr("Garbled range:  ", args[1]));
      args = E_INVARG;
    else
      range = $seq_utils:union(range, s);
      args = listdelete(args, 1);
    endif
  elseif (bynumber)
    player:notify("Don't give args with @list#.");
    args = E_INVARG;
  elseif (argspec)
    "... second argspec?  Not likely ...";
    player:notify(tostr(args[1], " unexpected."));
    args = E_INVARG;
  elseif (typeof(pas = $code_utils:parse_argspec(@args)) == LIST)
    argspec = pas[1];
    if (length(argspec) < 2)
      player:notify(tostr("Argument `", @argspec, "' malformed."));
      args = E_INVARG;
    else
      argspec[2] = $code_utils:full_prep(argspec[2]) || argspec[2];
      args = pas[2];
    endif
  else
    "... argspec is bogus ...";
    player:notify(tostr(pas));
    args = E_INVARG;
  endif
endwhile
if (args == E_INVARG)
  if (bynumber)
    player:notify(tostr("Usage:  ", verb, " <object>:<verbnumber> [with|without parentheses|numbers] [ranges]"));
  else
    player:notify(tostr("Usage:  ", verb, " <object>:<verb> [<dobj> <prep> <iobj>] [with|without parentheses|numbers] [all] [ranges]"));
  endif
  return;
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  return;
endif
shown_one = 0;
for what in ({object, @$object_utils:ancestors(object)})
  if (bynumber)
    vname = $code_utils:toint(spec[2]);
    if (vname == E_TYPE)
      return player:notify("Verb number expected.");
    elseif (vname < 1 || `vname > length(verbs(what)) ! E_PERM => 0')
      return player:notify("Verb number out of range.");
    endif
    code = `verb_code(what, vname, pflag) ! ANY';
  elseif (argspec)
    vnum = $code_utils:find_verb_named(what, spec[2]);
    while (vnum && `verb_args(what, vnum) ! ANY' != argspec)
      vnum = $code_utils:find_verb_named(what, spec[2], vnum + 1);
    endwhile
    vname = vnum;
    code = !vnum ? E_VERBNF | `verb_code(what, vnum, pflag) ! ANY';
  else
    vname = spec[2];
    code = `verb_code(what, vname, pflag) ! ANY';
  endif
  if (code != E_VERBNF)
    if (shown_one)
      player:notify("");
    elseif (what != object)
      player:notify(tostr("Object ", object, " does not define that verb", argspec ? " with those args" | "", ", but its ancestor ", what, " does."));
    endif
    if (typeof(code) == ERR)
      player:notify(tostr(what, ":", vname, " -- ", code));
    else
      info = verb_info(what, vname);
      vargs = verb_args(what, vname);
      fullname = info[3];
      if (index(fullname, " "))
        fullname = toliteral(fullname);
      endif
      if (index(vargs[2], "/"))
        vargs[2] = tostr("(", vargs[2], ")");
      endif
      $ansi_utils:add_noansi();
      player:notify(tostr(what, ":", fullname, "   ", $string_utils:from_list(vargs, " "), permflag ? " " + info[2] | ""));
      if (code == {})
        player:notify("(That verb has not been programmed.)");
      else
        lineseq = {1, length(code) + 1};
        range && (lineseq = $seq_utils:intersection(range, lineseq));
        if (!lineseq)
          player:notify("(No lines in that range.)");
        endif
        for k in [1..length(lineseq) / 2]
          for i in [lineseq[2 * k - 1]..lineseq[2 * k] - 1]
            if (nflag)
              player:notify(tostr(" "[1..i < 10], i, ":  ", code[i]));
            else
              player:notify(code[i]);
            endif
            $command_utils:suspend_if_needed(0);
          endfor
        endfor
      endif
      $ansi_utils:remove_noansi();
    endif
    shown_one = 1;
  endif
  if (shown_one && !aflag)
    return;
  endif
endfor
if (!shown_one)
  player:notify(tostr("That object does not define that verb", argspec ? " with those args." | "."));
endif
