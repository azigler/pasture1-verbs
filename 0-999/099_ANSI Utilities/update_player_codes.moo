#99:update_player_codes   this none this rxd

":update_player_codes (OBJ player)";
"Updates <player>'s .replace_codes property";
if (!this:trusts(caller_perms()))
  return E_PERM;
elseif ($object_utils:isa(plr = args[1], $ansi_pc))
  codes = {};
  for x in (this.groups)
    if (plr:ansi_option(x))
      codes = {@codes, @this.("group_" + x)};
      x == "extra" || (codes = setadd(codes, "normal"));
    endif
  endfor
  return plr.replace_codes = codes in this.replace_code_pointers || codes;
endif
