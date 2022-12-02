#6:@memory   none none none rd

"Return information about the MOO's current memory usage.";
"memory_info returns in pages. You can get KB by multiplying by 4.";
"Values: total size, resident set size, shared pages, text (code), data + stack";
mem = call_function("memory_usage");
MB = 0.001;
PAGE = 4.0;
player:tell($network.moo_name, " Memory Statistics");
player:tell();
player:tell("Total Memory Usage: ", mem[1] * PAGE * MB, " MB");
player:tell("Resident Set Size:  ", mem[2] * PAGE * MB, " MB");
player:tell("Shared Pages:       ", mem[3] * PAGE * MB, " MB");
player:tell("Text (Code):        ", mem[4] * PAGE * MB, " MB");
player:tell("Data + Stack:       ", mem[5] * PAGE * MB, " MB");
