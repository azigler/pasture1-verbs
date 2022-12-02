#30:find_index_topics   this none this rxd

":find_index_topic([search])";
"Return the list of index topics of this help DB";
"(i.e., those which contain an index (list of topics)";
"this DB, return it, otherwise return false.";
"If search argument is given and true,";
"we first remove any cached information concerning index topics.";
{?search = 0} = args;
if (this.index_cache && !search)
  "...make sure every topic listed in .index_cache really is an index topic";
  for p in (this.index_cache)
    if (!("*index*" in `this.(p) ! ANY => {}'))
      search = 1;
    endif
  endfor
  if (!search)
    return this.index_cache;
  endif
elseif ($generic_help == this)
  return {};
endif
itopics = {};
for p in (properties(this))
  if ((h = `this.(p) ! ANY') && "*index*" in h)
    itopics = {@itopics, p};
  endif
endfor
this.index_cache = itopics;
return itopics;
