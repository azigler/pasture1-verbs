#42:apply   this none this rxd

":apply(permstring,mods) => new permstring.";
"permstring is a permissions string, mods is a concatenation of strings of the form +<letters>, !<letters>, or -<letters>, where <letters> is a string of letters as might appear in a permissions string (`+' adds the specified permissions, `-' or `!' removes them; `-' and `!' are entirely equivalent).";
{perms, mods} = args;
if (!mods || !index("!-+", mods[1]))
  return mods;
endif
i = 1;
while (i <= length(mods))
  if (mods[i] == "+")
    while ((i = i + 1) <= length(mods) && !index("!-+", mods[i]))
      if (!index(perms, mods[i]))
        perms = perms + mods[i];
      endif
    endwhile
  else
    "mods[i] must be ! or -";
    while ((i = i + 1) <= length(mods) && !index("!-+", mods[i]))
      perms = strsub(perms, mods[i], "");
    endwhile
  endif
endwhile
return perms;
