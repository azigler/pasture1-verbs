#37:clearall   this none this rxd

"WIZARDLY";
if (!($perm_utils:controls(caller_perms(), this) || caller == this))
  return E_PERM;
endif
if (args && (d = args[1]) in {3, 4})
  this.data = d;
endif
root = {"", "", {}, @this.data > 3 ? {{}} | {}};
"...since the for loop contains a suspend, we want to keep people";
"...from getting at properties which are now garbage but which we";
"...haven't had a chance to wipe yet.  Somebody might yet succeed";
"...in adding something; thus we have the outer while loop.";
this:set_node("", 37);
while (this.(" ") != root)
  this:set_node("", @root);
  for p in (properties(this))
    if (p[1] == " " && p != " ")
      delete_property(this, p);
    endif
    "...Bleah; db is inconsistent now....";
    "...At worst someone will add something that references an";
    "...existing property.  He will deserve to die...";
    $command_utils:suspend_if_needed(0);
  endfor
endwhile
