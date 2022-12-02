#51:match_verb   this none this rxd

"$match_utils:match_verb(verbname, object) => Looks for a command-line style verb named <verbname> on <object> with current values of prepstr, dobjstr, dobj, iobjstr, and iobj.  If a match is made, the verb is called with @args[3] as arguments and 1 is returned.  Otherwise, 0 is returned.";
{vrb, what, rest} = args;
if (where = $object_utils:has_verb(what, vrb))
  if ((vargs = verb_args(where[1], vrb)) != {"this", "none", "this"})
    if (vargs[2] == "any" || (!prepstr && vargs[2] == "none") || index("/" + vargs[2] + "/", "/" + prepstr + "/") && (vargs[1] == "any" || (!dobjstr && vargs[1] == "none") || (dobj == what && vargs[1] == "this")) && (vargs[3] == "any" || (!iobjstr && vargs[3] == "none") || (iobj == what && vargs[3] == "this")) && index(verb_info(where[1], vrb)[2], "x") && verb_code(where[1], vrb))
      set_task_perms(caller_perms());
      what:(vrb)(@rest);
      return 1;
    endif
  endif
endif
