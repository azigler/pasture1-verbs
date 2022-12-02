#58:@gethelp   any any any rxd

"@gethelp [<topic>] [from <db or dblist>]";
"  Prints the raw text of topic from the appropriate help db.";
"  With no argument, gets the blank (\"\") topic from wherever it lives";
"  Text is printed as a script for changing this help topic ";
"  (somewhat like @dump...)";
if (!prepstr)
  topic = argstr;
  dblist = $code_utils:help_db_list();
elseif (prepstr != "from")
  player:notify("Usage:  ", verb, " [<topic>] [from <db>]");
  return;
elseif (!(e = $no_one:eval_d(iobjstr = argstr[$string_utils:word_start(argstr)[(prepstr in args) + 1][1]..$])))
  player:notify(tostr(e));
  return;
elseif (!e[1])
  player:notify_lines(e[2]);
  return;
elseif (!(typeof(dblist = e[2]) in {OBJ, LIST}))
  player:notify(tostr(iobjstr, " => ", dblist, " -- not an object or a list"));
  return;
else
  topic = dobjstr;
  if (typeof(dblist) == OBJ)
    dblist = {dblist};
  endif
endif
search = $code_utils:help_db_search(topic, dblist);
if (!search)
  player:notify("Topic not found.");
elseif (search[1] == $ambiguous_match)
  player:notify(tostr("Topic `", topic, "' ambiguous:  ", $string_utils:english_list(search[2], "none", " or ")));
elseif (typeof(text = (db = search[1]):dump_topic(fulltopic = search[2])) == ERR)
  "...ok...shoot me.  This is a -d verb...";
  player:notify(tostr("Cannot retrieve `", fulltopic, "' on ", $code_utils:corify_object(db), ":  ", text));
else
  player:notify_lines(text);
endif
