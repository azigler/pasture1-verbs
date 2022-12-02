#50:suck_in   this none this rxd

"The correct way to move someone into the editor.";
if ((loc = (who_obj = args[1]).location) != this && caller == this)
  this.invoke_task = task_id();
  who_obj:moveto(this);
  if (who_obj.location == this)
    try
      "...forked, just in case loc:announce is broken...";
      "changed to a try-endtry. Lets reduce tasks..Ho_Yan 12/20/96";
      if (valid(loc) && (msg = this:depart_msg()))
        loc:announce($string_utils:pronoun_sub(msg));
      endif
    except (ANY)
      "Just drop it and move on";
    endtry
  else
    who_obj:tell("For some reason, I can't move you.   (?)");
    this:exitfunc(who_obj);
  endif
  this.invoke_task = 0;
endif
return who_obj.location == this;
