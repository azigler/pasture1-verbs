#45:mail_names   this none this rxd

names = {};
for a in (this.aliases)
  if (!index(a, " "))
    names = setadd(names, strsub(a, "_", "-"));
  endif
endfor
return names;
