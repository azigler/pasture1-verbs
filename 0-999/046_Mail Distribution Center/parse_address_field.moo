#46:parse_address_field   this none this rxd

":parse_address_field(string) => list of objects";
"This is the standard routine for parsing address lists that appear in From:, To: and Reply-To: lines";
objects = {};
string = args[1];
while (m = match(string, "(#[0-9]+)"))
  {s, e} = m[1..2];
  if (#0 != (o = toobj(string[s + 1..e - 1])))
    objects = {@objects, o};
  endif
  string = string[e + 1..$];
endwhile
return objects;
