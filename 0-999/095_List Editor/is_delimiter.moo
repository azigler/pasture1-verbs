#95:is_delimiter   this none this rxd

line = $string_utils:triml(args[1]);
return line && (line[1] == "}" || (line[1] == "{" && !rindex(line, "}")));
