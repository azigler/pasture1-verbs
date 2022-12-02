#117:"generate_json json"   this none this rxd

"Map:generate_json()";
"Map:json()";
"So that programmers can call generate_json directly on a map.";
"Just calls the builtin of the same name.";
return call_function("generate_json", this, @args);
