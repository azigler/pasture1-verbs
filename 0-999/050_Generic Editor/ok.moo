#50:ok   this none this rxd

who = args[1];
if (who < 1 || who > length(this.active))
  return E_RANGE;
elseif (length(c = callers()) < 2 ? player == this.active[who] | c[2][1] == this || ($perm_utils:controls(c[2][3], this.active[who]) || c[2][3] == $generic_editor.owner))
  return 1;
else
  return E_PERM;
endif
