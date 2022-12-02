#30:"forward pass"   this none this rxd

"{\"*forward*\", topic, @rest}  => text for topic from this help db.";
"{\"*pass*\",    topic, @rest}  => text for topic from next help db.";
"In both cases the text of @rest is appended.  ";
"@rest may in turn begin with a *<verb>*";
{text, ?dblist = {}} = args;
if (verb == "forward")
  first = this:get_topic(text[1], dblist);
elseif ((result = $code_utils:help_db_search(text[1], dblist)) && (db = result[1]) != $ambiguous_match)
  first = db:get_topic(result[2], dblist[(db in dblist) + 1..$]);
else
  first = {};
endif
if (2 <= length(text))
  if (text[2] == "*" + (vb = strsub(text[2], "*", "")) + "*")
    return {@first, @`this:(vb)(text[3..$], dblist) ! ANY => {}'};
  else
    return {@first, @text[2..$]};
  endif
else
  return first;
endif
