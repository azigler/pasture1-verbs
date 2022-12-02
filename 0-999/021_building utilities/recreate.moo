#21:recreate   this none this rxd

":recreate(object,newparent) -- effectively recycle and recreate the specified object as a child of parent.  Returns true if successful.";
"In any circumstance, either object OR newparent has to be a valid object.";
"If object is valid and newparent is invalid, object is effectively just recycled.";
"If object is invalid and newparent is valid, an attempt will be made to recreate the invalid object as newparent.";
{object, parent} = args;
who = caller_perms();
if (who.wizard)
  "no problemo";
elseif (valid(object) && who != object.owner || (valid(parent) && (who != parent.owner && !parent.f)))
  return E_PERM;
endif
"No need to worry about orphans or contents, as recycle() will handle all of that for us.";
set_task_perms(who);
if (valid(object))
  recycle(object);
endif
if (!valid(parent))
  "We're done here. All we wanted to do was recycle with who's permissions.";
  return 1;
else
  recreate(object, parent, who);
  object.name = "";
  object.r = 0;
  object.f = 0;
  object.w = 0;
  return 1;
endif
