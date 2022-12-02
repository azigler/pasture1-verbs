#107:parse_mcp   this none this rxd

"parse_mcp(@args) =>";
"relies on argstr being a version of @args unwordified";
"{request-name, contains-multiline, authentication-key, data-tag, { { keyword-name, data }, ... } }";
if (length(args) < 1)
  raise(E_INVARG, "not enough arguments");
endif
request_name = args[1][4..$];
if (!request_name)
  raise(E_INVARG, "no request name");
endif
if (request_name == "*")
  return this:parse_mcp_continuation(@args[2..$]);
endif
"... if there is an authentication key, the length of args will be even ...";
if (length(args) % 2)
  authentication_key = E_NONE;
  message_args = args[2..$];
else
  authentication_key = args[2];
  message_args = args[3..$];
endif
{contains_multiline, alist} = this:parse_mcp_alist(@message_args);
if (contains_multiline)
  if (tag = $list_utils:iassoc("_data-tag", alist))
    "mulitline with a datatag, OK";
    data_tag = alist[tag][2];
    alist = listdelete(alist, tag);
  else
    raise(E_INVARG, "multiline fields with no data tag");
  endif
else
  data_tag = E_NONE;
endif
if (typeof(alist) == LIST)
  return {request_name, contains_multiline, authentication_key, data_tag, alist};
else
  return alist;
endif
