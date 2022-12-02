#59:help_db_search   this none this rxd

":help_db_search(string,dblist)";
"  searches each of the help db's in dblist for a topic matching string.";
"  Returns  {db,topic}  or  {$ambiguous_match,{topic...}}  or {}";
{what, dblist} = args;
topics = {};
help = 1;
verb_help_match = 0;
for db in (dblist)
  $command_utils:suspend_if_needed(0);
  if ({what} == (ts = `db:find_topics(what) ! ANY => 0'))
    if (db == $help_db["verb"])
      "Verb help is considered a last resort. It's possible help files contain more relevant information (e.g. $login).";
      verb_help_match = {db, ts[1]};
    else
      return {db, ts[1]};
    endif
  elseif (ts && typeof(ts) == LIST)
    if (help)
      help = db;
    endif
    for t in (ts)
      topics = setadd(topics, t);
    endfor
  endif
endfor
if (length(topics) > 1)
  return {$ambiguous_match, topics};
elseif (topics)
  return {help, topics[1]};
elseif (verb_help_match)
  return verb_help_match;
else
  return {};
endif
