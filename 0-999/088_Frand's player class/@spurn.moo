#88:@spurn   any none none rd

"Prevent an object or any of its descendents from going into your inventory, regardless of whose player perms sent it there.";
"Syntax:  @spurn <object>";
"         @spurn !<object>";
"The second form removes an object from your list of spurned objects.";
"Verb created by TheCat, 11/8/98";
if (caller != this)
  return E_PERM;
endif
if (!argstr)
  this:tell("Spurn what?");
elseif (argstr[1] == "!")
  "Stop spurning something.";
  item = this:my_match_object(argstr[2..$]);
  if (item in this.spurned_objects)
    this.spurned_objects = $list_utils:setremove_all(this.spurned_objects, item);
    this:tell("You are no longer spurning " + $string_utils:nn(item) + " or any kids of it.");
  else
    this:tell("You are not spurning " + $string_utils:nn(item) + ".");
  endif
else
  "Spurn something.";
  item = this:my_match_object(argstr);
  if (!$command_utils:object_match_failed(item, argstr))
    if (item in this.spurned_objects)
      this:tell("You are already spurning " + $string_utils:nn(item) + " plus any and all kids of it.");
    else
      this.spurned_objects = setadd(this.spurned_objects, item);
      this:tell("You are now spurning " + $string_utils:nn(item) + " plus any and all kids of it.");
    endif
  endif
endif
