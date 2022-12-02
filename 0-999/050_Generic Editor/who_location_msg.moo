#50:who_location_msg   this none this rxd

who = args[1];
where = {#-1, @this.original}[1 + (who in this.active)];
wherestr = `where:who_location_msg(who) ! ANY => "An Editor"';
if (typeof(wherestr) != STR)
  wherestr = "broken who_location_msg";
endif
return strsub(this.who_location_msg, "%L", wherestr);
return $string_utils:pronoun_sub(this.who_location_msg, who, this, where);
