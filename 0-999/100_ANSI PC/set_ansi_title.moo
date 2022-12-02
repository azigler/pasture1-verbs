#100:set_ansi_title   this none this rxd

":set_ansi_title (LIST title_list)";
tl = args[1];
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (typeof(tl) != LIST)
  return E_INVARG;
else
  au = $ansi_utils;
  for x in [1..length(tl)]
    if (!(typeof(tl[x]) == LIST && length(tl[x]) == 2 && typeof(tl[x][1]) == STR))
      return E_INVARG;
    elseif (typeof(tl[x][2]) == LIST)
      for y in [1..length(tl[x][2])]
        if (typeof(tl[x][2][y]) != STR)
          return E_INVARG;
        elseif (tl[x][1] != strsub(au:delete(tl[x][2][y]), " ", "_"))
          return E_NACC;
        else
          tl[x][2][y] = au:terminate_normal(tl[x][2][y]);
        endif
      endfor
    elseif (tl[x][1] != strsub(au:delete(tl[x][2]), " ", "_"))
      return E_NACC;
    else
      tl[x][2] = au:terminate_normal(tl[x][2]);
    endif
  endfor
  this.ansi_title = tl;
endif
