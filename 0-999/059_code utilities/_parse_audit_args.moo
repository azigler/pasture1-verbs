#59:_parse_audit_args   this none this rxd

"Parse [from <start>] [to <end>] [for <name>].";
"Takes a series of strings, most likely @args with dobjstr removed.";
"Returns a list {INT start, INT end, STR name}, or {} if there is an error.";
fail = length(args) % 2;
start = 0;
end = toint(max_object());
match = "";
while (args && !fail)
  prep = args[1];
  if (prep == "from")
    if ((start = player.location:match_object(args[2])) >= #0)
      start = toint(start);
    else
      start = toint(args[2]);
    endif
  elseif (prep == "to")
    if ((end = player.location:match_object(args[2])) >= #0)
      end = toint(end);
    else
      end = toint(args[2]);
    endif
  elseif (prep == "for")
    match = args[2];
  else
    fail = 1;
  endif
  args = args[3..length(args)];
endwhile
return fail ? {} | {start, end, match};
