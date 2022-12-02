#1:examine_desc   this none this rxd

"examine_desc(who) - return the description, probably";
"who is the player examining";
"this should probably go away";
desc = this:description();
if (desc)
  if (typeof(desc) != LIST)
    desc = {desc};
  endif
  return desc;
else
  return {"(No description set.)"};
endif
