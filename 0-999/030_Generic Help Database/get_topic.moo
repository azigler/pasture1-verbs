#30:get_topic   this none this rxd

"WIZARDLY";
{topic, ?dblist = {}} = args;
if (`$object_utils:has_property(parent(this), topic) ! ANY')
  text = `this.(" " + topic) ! ANY';
else
  text = `this.(topic) || this.(" " + topic) ! ANY';
endif
if (typeof(text) == LIST)
  if (text && text[1] == "*" + (vb = strsub(text[1], "*", "")) + "*")
    text = `this:(vb)(listdelete(text, 1), dblist) ! ANY';
  endif
endif
return text;
