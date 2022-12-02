#59:toobj   this none this rxd

":toobj(objectid as string) => objectid";
return match(s = args[1], "^ *#[-+]?[0-9]+ *$") ? toobj(s) | E_TYPE;
