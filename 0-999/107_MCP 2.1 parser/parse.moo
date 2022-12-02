#107:parse   this none this rxd

"parse(@args) => parsed MCP message ready for dispatch or 0";
"                if there was nothing to dispatch for this message";
"                (as in multiline continuations, dispatch";
"                for those occurs at the END";
"returns {message, authkey, alist} or 0";
"argstr must equal the unmodified line from the client";
{argstr, @words} = args;
session = caller;
message = this:parse_mcp(@words);
if (message[1] == "*")
  {n, data_tag, keyword, value} = message;
  session:multiline_add_value(data_tag, keyword, value);
elseif (message[1] == ":" || message[1] == "END")
  {request, dummy, data_tag, dummy, dummy} = message;
  return session:multiline_finish(player, data_tag);
else
  {request, contains_multiline, authkey, data_tag, alist} = message;
  if (contains_multiline)
    session:multiline_begin(request, authkey, data_tag, alist);
  else
    return {request, authkey, alist};
  endif
endif
return 0;
