#97:handle_connection   this none this rxd

"HTTP Server";
"";
"This gets called by the #0:do_login_command";
"It keeps track of web browser guests, and it feeds them HTTP instead of Telnet.";
if (caller != #0 && caller != this)
  return E_PERM;
endif
not_http = args ? args | {$login.blank_command};
guest = $string_utils:connection_hostname(player);
if (!args)
  if ((guestnum = $list_utils:iassoc(guest, this.guests)) > 0)
    guestinfo = this.guests[guestnum];
    if (guestinfo[3] > 1)
      "Three blank requests means this is not a guest anymore.";
      this.guests = listdelete(this.guests, guestnum);
      return not_http;
    endif
    guestinfo[3] = guestinfo[3] + 1;
    this.guests[guestnum] = guestinfo;
  else
    "Don't know who this is. Do the regular welcome.";
    return not_http;
  endif
elseif ((guestnum = $list_utils:iassoc(guest, this.guests)) > 0)
  "Previously registered HTTP guest.";
  if (args && args[1] == "GET")
    "Registered guest does a GET.";
    guestinfo = {guest, time(), 0};
    this.guests[guestnum] = guestinfo;
    html = {};
    keys = $string_utils:explode(args[2], "/");
    objid = keys ? toobj(keys[1]) | #-1;
    if (valid(objid))
      if ($object_utils:has_callable_verb(objid, "html"))
        new_player = $no_one;
        if (length(keys) >= 3 && length(keys[3]) > 2)
          if (keys[3] == this:gen_key(keys[1], keys[2], keys[3][1..2]))
            new_player = toobj(keys[2]);
            keys = length(keys) > 3 ? keys[4..$] | {};
          endif
        endif
        old_player = player;
        player = new_player;
        html = `objid:html(@keys) ! ANY';
        player = old_player;
        if (typeof(html) == ERR)
          html = {"HTTP/1.1 500 Internal Server Error", "Content-Type: text/plain", "", "", "ERROR:", tostr(objid) + ":html()", tostr(html)};
        endif
      elseif ($object_utils:has_readable_property(objid, "html"))
        html = objid.html;
      else
        html = {"HTTP/1.1 404 NOT FOUND", "Content-Type: text/plain", "", "", "HTML not found."};
      endif
    else
      html = {"HTTP/1.1 404 NOT FOUND", "Content-Type: text/plain", "", "", "Object not found."};
    endif
    "Default header is HTML";
    html_header = {"HTTP/1.1 200 OK", "Content-Type: text/html", "", ""};
    if (typeof(html) == STR)
      html = {html};
    endif
    if (`html[1][1..6] == "<HTML>" ! ANY => 0')
      html = {@html_header, @html};
    endif
    if (typeof(html) == LIST && length(html) == 0)
      html = html_header;
    endif
    if (html && typeof(html) == LIST)
      for h in (html)
        if (typeof(h) == STR)
          notify(player, h);
        endif
      endfor
    endif
    "Server options need a suspend before they take effect.";
    old_boot = $server_options.boot_msg;
    $server_options.boot_msg = "";
    suspend(0);
    boot_player(player);
    $server_options.boot_msg = old_boot;
  elseif (args[1][$] == ":")
    "Client is telling us some HTTP header info.";
    boot_player(player);
  else
    "They stopped doing GETs, so remove them as HTTP.";
    this.guests = listdelete(this.guests, guestnum);
    return not_http;
  endif
elseif (args && args[1] == "GET")
  "First visit. Register them as a guest and ask them to refresh.";
  guestinfo = {guest, time(), 0};
  this.guests = {@this.guests, guestinfo};
  html = {"HTTP/1.1 200 OK", "Content-Type: text/html", "", "", "<meta http-equiv=\"refresh\" content=\"0\"><br><b>", "", "", "", "Web service initialized. Please reload this page.", "</b>"};
  for h in (html)
    notify(player, h);
  endfor
  boot_player(player);
else
  "Regular telnet client.";
  return not_http;
endif
"HTTP Session successful";
return;
