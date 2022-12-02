#108:register_handlers   this none this rxd

{messages} = args;
package = caller;
{plist, mlist} = this.message_handlers;
prefix = this:package_name(package);
for message in (messages)
  message = this:message_fullname(prefix, message);
  if (idx = message in mlist)
    if (plist[idx] != package)
      raise(E_INVARG);
    endif
  else
    plist = {@plist, package};
    mlist = {@mlist, message};
  endif
endfor
this.message_handlers = {plist, mlist};
