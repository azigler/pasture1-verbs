#99:ansi_status   this none this rxd

mess = {};
mess = {@mess, tostr("ANSI Version ", this.version, ":")};
a = 0;
for x in (this.groups)
  a = a + length(this.("group_" + x));
endfor
mess = {@mess, tostr("It is ", this.active ? "currently" | "not", " active.  There are ", $string_utils:english_number(a), " codes defined in ", $string_utils:english_number(length(this.groups)), " groups.  There ", length(this.noansi_queue) == 1 ? "is" | "are", " ", $string_utils:english_number(length(this.noansi_queue)), " tasks in the ignore ANSI task queue, and the cleanup task is ", $code_utils:task_valid(this.noansi_queue) ? "currently" | "not", " running.")};
return mess;
