#46:make_message   this none this rxd

":make_message(sender,recipients,subject/replyto/additional-headers,body)";
" => message in the form as it will get sent.";
{from, recips, hdrs, body} = args;
try
  fromowner = from.owner;
except (E_INVIND)
  raise(E_PERM);
endtry
fromline = this:name_list(from);
if (typeof(recips) != LIST)
  recips = {recips};
endif
recips = this:name_list(@recips);
others = {};
replyto = 0;
if (typeof(hdrs) != LIST)
  hdrs = {hdrs};
endif
subj = hdrs[1];
if (!valid(from))
  others = {"Probable-Sender:   " + this:name(fromowner)};
  "  others = {'Possible-Sender:   ' + this:name(player)}";
  "  if (caller_perms() != player)";
  "    others = {@others, 'Possible-Sender:   ' + this:name(caller_perms())}";
  "  endif";
elseif (!is_player(from))
  others = {"Sender:   " + this:name(from.owner)};
endif
replyto = {@hdrs, 0}[2] && this:name_list(@hdrs[2]);
if (length(hdrs) > 2)
  hdrs[1..2] = {};
  for h in (hdrs)
    if (match(h[1], "[a-z1-9-]+"))
      others = {@others, $string_utils:left(h[1] + ": ", 15) + h[2]};
    endif
  endfor
endif
if (typeof(body) != LIST)
  body = body ? {body} | {};
endif
return {this:time(), fromline, recips, subj || " ", @replyto ? {"Reply-to: " + replyto} | {}, @others, "", @body};
