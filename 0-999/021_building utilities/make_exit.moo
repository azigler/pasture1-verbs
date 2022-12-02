#21:make_exit   this none this rxd

"make_exit(spec, source, dest[, use-$recycler-pool [, kind]])";
"";
"Uses $recycler by default; supplying fourth arg as 0 suppresses this.";
"Optional 5th arg gives a parent for the object to be created";
"(i.e., distinct from $exit)";
"Returns the object number as a list if successful, 0 if not.";
set_task_perms(caller_perms());
{spec, source, dest, ?use_recycler, ?exit_kind = $exit} = args;
exit = player:_create(exit_kind);
if (typeof(exit) == ERR)
  player:notify(tostr("Cannot create new exit as a child of ", $string_utils:nn(exit_kind), ": ", exit, ".  See `help @build-options' for information on how to specify the kind of exit this command tries to create."));
  return;
endif
for f in ($string_utils:char_list(player:build_option("create_flags") || ""))
  exit.(f) = 1;
endfor
$building_utils:set_names(exit, spec);
exit.source = source;
exit.dest = dest;
source_ok = source:add_exit(exit);
dest_ok = dest:add_entrance(exit);
move(exit, $nothing);
via = $string_utils:from_value(setadd(exit.aliases, exit.name), 1);
if (source_ok)
  player:tell("Exit from ", source.name, " (", source, ") to ", dest.name, " (", dest, ") via ", via, " created with id ", exit, ".");
  if (!dest_ok)
    player:tell("However, I couldn't add ", exit, " as a legal entrance to ", dest.name, ".  You may have to get its owner, ", dest.owner.name, " to add it for you.");
  endif
  return {exit};
elseif (dest_ok)
  player:tell("Exit to ", dest.name, " (", dest, ") via ", via, " created with id ", exit, ".  However, I couldn't add ", exit, " as a legal exit from ", source.name, ".  Get its owner, ", source.owner.name, " to add it for you.");
  return {exit};
else
  player:_recycle(exit);
  player:tell("I couldn't add a new exit as EITHER a legal exit from ", source.name, " OR as a legal entrance to ", dest.name, ".  Get their owners, ", source.owner.name, " and ", dest.owner.name, ", respectively, to add it for you.");
  return 0;
endif
