#82:help_msg   this none this rxd

output = {"On $server_options, the following settings have been established by the wizards:", ""};
wizonly = {};
etc = {};
mentioned = {};
for x in (setremove(properties(this), "help_msg"))
  if (index(x, "protect_") == 1)
    mentioned = {@mentioned, x[9..$]};
    wizonly = {@wizonly, tostr(x[9..$], "() is ", this.(x) ? "" | "not ", "wizonly.")};
  else
    etc = {@etc, tostr("$server_options.", x, " = ", $string_utils:print(this.(x)))};
  endif
endfor
if ("set_verb_code" in wizonly)
  wizonly = {@wizonly, "", "Note: since the 'set_verb_code' built-in function is wiz-only, then the '.program' built-in command is wiz-only too."};
endif
if (bf = $set_utils:intersection(verbs(#0), mentioned))
  bf = $list_utils:sort(bf);
  etc = {@etc, "", "In your code, #0:(built-in)(@args) should be called rather than built-in(@args) when you would use one of the following built-in functions:", $string_utils:english_list(bf) + ".", "Example: #0:" + bf[1] + "(@args) should be used instead of " + bf[1] + "(@args)"};
endif
return {@this.help_msg, @output, @wizonly, "", @etc};
