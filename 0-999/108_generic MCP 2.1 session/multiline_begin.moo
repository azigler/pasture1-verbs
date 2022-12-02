#108:multiline_begin   this none this rxd

{request, authkey, data_tag, alist} = args;
if (caller != $mcp.parser)
  raise(E_PERM);
elseif ($list_utils:assoc(data_tag, this.pending_multilines))
  "it's not valid to begin two requests with the same data tag, drop it";
  return;
endif
this.pending_multilines = {@this.pending_multilines, {data_tag, authkey, request, alist}};
