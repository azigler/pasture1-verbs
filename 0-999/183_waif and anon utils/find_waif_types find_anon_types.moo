#183:"find_waif_types find_anon_types"   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
endif
{data, ?class = 0} = args;
ret = {};
TYPE = verb == "find_anon_types" ? ANON | WAIF;
if (typeof(data) in {LIST, MAP})
  "Rather than wasting time iterating through the entire list, we can find if it contains any waifs with a relatively quicker index().";
  if (index(toliteral(data), "[[class = #") != 0)
    for x in (data)
      yin(0, 1000);
      ret = {@ret, @this:(verb)(x, class)};
    endfor
  endif
elseif (typeof(data) == TYPE)
  if (class == 0 || (class != 0 && (TYPE == WAIF && data.class == class || (TYPE == ANON && `parent(data) ! E_INVARG' == class))))
    ret = {@ret, data};
  endif
endif
return ret;
"Last modified Tue Dec  6 22:30:17 2022 UTC by Zig (#2).";
