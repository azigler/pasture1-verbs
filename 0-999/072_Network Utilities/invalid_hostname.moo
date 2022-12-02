#72:invalid_hostname   this none this rxd

return match(args[1], this.valid_host_regexp) ? "" | tostr("'", args[1], "' doesn't look like a valid internet host name");
