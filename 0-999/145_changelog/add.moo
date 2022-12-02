#145:add   this none this rxd

if (!args)
  return 0;
endif
{adding} = args;
"date will equal month.day.year.";
date = #43:time_sub("$1.$3.$Y");
"Does the date exist in the entries map? if not, add it.";
if (!maphaskey(this.entries, date))
  this.entries[date] = {};
endif
"is the adding item a list? if so, add it element by element so there won't be 2 lists in the entries map. otherwise, just dump it in cause it's a string.";
if (typeof(adding) == LIST)
  for i in (adding)
    this.entries[date] = setadd(this.entries[date], i);
  endfor
else
  this.entries[date] = setadd(this.entries[date], adding);
endif
return 1;
