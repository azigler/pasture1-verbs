#108:multiline_finish   this none this rxd

{who, data_tag} = args;
if (caller != this && caller != $mcp.parser)
  raise(E_PERM);
elseif (!(n = $list_utils:iassoc(data_tag, this.pending_multilines)))
  "drop it";
  return;
else
  {data_tag, authkey, request, alist} = this.pending_multilines[n];
  this.pending_multilines = listdelete(this.pending_multilines, n);
  return {request, authkey, alist};
endif
