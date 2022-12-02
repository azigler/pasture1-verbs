#24:rename_all_instances   this none this rxd

":rename_all_instances(object,oldname,newname)";
"Used to rename all instances of an unwanted verb (like recycle or disfunc)";
"if said verb is actually defined on the object itself";
if (caller_perms().wizard)
  found = 0;
  {object, oldname, newname} = args;
  while (info = `verb_info(object, oldname) ! ANY')
    `set_verb_info(object, oldname, listset(info, newname, 3)) ! ANY';
    found = 1;
  endwhile
  return found;
else
  return E_PERM;
endif
