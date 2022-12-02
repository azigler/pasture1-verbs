#108:multiline_add_value   this none this rxd

{data_tag, keyword, value} = args;
if (caller != $mcp.parser)
  raise(E_PERM);
elseif (!(n = $list_utils:iassoc(data_tag, this.pending_multilines)))
  "drop it";
  return;
elseif (!(nkey = $list_utils:iassoc(keyword, this.pending_multilines[n][4])))
  "drop it";
  return;
elseif (typeof(this.pending_multilines[n][4][nkey][2]) != LIST)
  "not a multiline, drop it.";
  return;
else
  this.pending_multilines[n][4][nkey][2] = {@this.pending_multilines[n][4][nkey][2], value};
endif
