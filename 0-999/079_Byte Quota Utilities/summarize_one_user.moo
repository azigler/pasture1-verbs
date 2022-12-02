#79:summarize_one_user   this none this rxd

"Summarizes total space usage by one user (args[1]).  Optional second argument is a flag to say whether to re-measure all objects for this user; specify the number of seconds out of date you are willing to accept.  If negative, will only re-measure objects which have no recorded data.";
"Returns a list of four values:";
"  total : total measured space in bytes";
"  uncounted : Number of objects that were not counted because they aren't descendents of #1";
"  zeros : Number of objects which have been created too recently to have any measurement data at all (presumably none if re-measuring)";
"  most-out-of-date : the time() the oldest actual measurement was taken";
"  object-thereof: the object who had this time()'d measurement";
who = args[1];
if (length(args) == 2)
  if (args[2] < 0)
    earliest = 1;
  else
    earliest = time() - args[2];
  endif
else
  earliest = 0;
endif
nzeros = 0;
oldest = time();
eldest = #-1;
nuncounted = 0;
total = 0;
for x in (typeof(who.owned_objects) == LIST ? who.owned_objects | {})
  if (x.owner == who)
    "Bulletproofing against recycling during suspends!";
    "Leaves us open to unsummarized creation during this period, which is unfortunate.";
    if ($object_utils:has_property(x, "object_size"))
      size = x.object_size[1];
      time = x.object_size[2];
      if (time < earliest)
        "Re-measure.  This side-effects x.object_size.";
        this:object_bytes(x);
        size = x.object_size[1];
        time = x.object_size[2];
      endif
      if (time && time <= oldest)
        oldest = time;
        eldest = x;
      elseif (!time)
        nzeros = nzeros + 1;
      endif
      if (size >= 0)
        total = total + size;
      endif
    else
      nuncounted = nuncounted + 1;
    endif
  endif
  $command_utils:suspend_if_needed(0);
endfor
if (!is_clear_property(who, "size_quota"))
  "Cache the data, but only if they aren't scamming.";
  who.size_quota[2] = total;
  who.size_quota[3] = oldest;
  who.size_quota[4] = nuncounted * this.unmeasured_multiplier + nzeros;
endif
return {total, nuncounted, nzeros, oldest, eldest};
