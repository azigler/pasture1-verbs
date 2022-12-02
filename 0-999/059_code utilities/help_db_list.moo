#59:help_db_list   this none this rxd

":help_db_list([player]) => list of help dbs";
"in the order that they are consulted by player";
{?who = player} = args;
olist = {who, @$object_utils:ancestors(who)};
if (valid(who.location))
  olist = {@olist, who.location, @$object_utils:ancestors(who.location)};
endif
dbs = {};
for o in (olist)
  h = `o.help ! ANY => 0';
  if (typeof(h) == OBJ)
    h = {h};
  endif
  if (typeof(h) == LIST)
    for db in (h)
      if (typeof(db) == OBJ && (valid(db) && !(db in dbs)))
        dbs = {@dbs, db};
      endif
    endfor
  endif
endfor
return setadd(dbs, $help);
