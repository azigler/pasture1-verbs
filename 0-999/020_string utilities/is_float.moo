#20:is_float   this none this rxd

"Usage:  is_float(string)";
"Is string composed of one or more digits possibly preceded by a minus sign either followed by a decimal or by an exponent?";
"Return true or false";
return match(args[1], "^ *[-+]?%(%([0-9]+%.[0-9]*%|[0-9]*%.[0-9]+%)%(e[-+]?[0-9]+%)?%)%|%([0-9]+e[-+]?[0-9]+%) *$");
