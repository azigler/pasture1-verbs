#72:raw_sendmail   any none none rxd

"Copied from sendmail fix (#88079):raw_sendmail by Lineman (#108318) Mon Feb  1 19:29:43 1999 PST";
"rawsendmail(to, @lines)";
"sends mail without processing. Returns 0 if successful, or else reason why not.";
if (!caller_perms().wizard)
  return E_PERM;
endif
if (!this.active)
  return "Networking is disabled.";
endif
if (typeof(this.debugging) == LIST)
  "who to notify";
  debugging = this.debugging;
else
  "notify this owner";
  debugging = this.debugging && {this.owner};
endif
address = args[1];
body = listdelete(args, 1);
data = {"HELO " + this.site, "MAIL FROM:<" + this.postmaster + ">", "RCPT TO:<" + address + ">", "DATA"};
blank = 0;
for x in (body)
  this:suspend_if_needed(0);
  if (!(blank || match(x, "^[!-9;-~]+: ")))
    if (x)
      data = {@data, ""};
    endif
    blank = 1;
  endif
  data = {@data, x && x[1] == "." ? "." + x | x};
endfor
data = {@data, ".", "QUIT", ""};
suspend(0);
target = E_NONE;
for maildrop in (typeof(this.maildrop) == LIST ? this.maildrop | {this.maildrop})
  target = $network:open(maildrop, 25);
  if (typeof(target) != ERR)
    break;
  endif
endfor
if (typeof(target) == ERR)
  return tostr(@target == E_NONE ? {"No maildrop specified"} | {"Cannot open connection to maildrop ", maildrop, ": ", target});
endif
set_connection_option(target, "hold-input", 1);
blast = 0;
msg = 0;
expects = {"220", "250", "250", "250%|251", "354", "250", "221"};
for line in (data)
  if (!blast)
    reply = this:tcp_wait(target);
    if (typeof(reply) == ERR)
      msg = "Connection dropped or timed out.";
      break;
    elseif (!match(reply[1..3], expects[1]))
      msg = "Expected " + expects[1] + " but got " + reply;
      break;
    endif
    debugging && notify(debugging[1], "GET: " + reply);
    expects[1..1] = {};
    if (reply[1..3] == "221")
      "Service closing transmission channel";
      break;
    elseif (reply[1..3] == "354")
      "Start mail input; end with <CRLF>.<CRLF>";
      blast = 1;
    endif
  elseif (line == ".")
    blast = 0;
  endif
  debugging && notify(debugging[1], "SEND:" + line);
  while (ticks_left() < 4000 || seconds_left() < 2 || !notify(target, line, 1))
    suspend(0);
  endwhile
endfor
$network:close(target);
debugging && notify(debugging[1], "EXIT:" + (msg || "Mail sent successfully."));
return msg;
