#52:has_verb   this none this rxd

":has_verb(OBJ object, STR verbname)";
"Find out if an object has a verb matching the given verbname.";
"Returns {location} if so, 0 if not, where location is the object or the ancestor on which the verb is actually defined.";
{object, verbname} = args;
while (valid(object))
  try
    if (verb_info(object, verbname))
      return {object};
    endif
  except (E_VERBNF)
    object = parent(object);
  endtry
endwhile
return 0;
"OLD CODE BELOW:";
while (E_VERBNF == (vi = `verb_info(object, verbname) ! E_VERBNF, E_INVARG'))
  object = parent(object);
endwhile
return vi ? {object} | 0;
