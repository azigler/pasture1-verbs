#50:set_insertion   this none this rxd

return this:ok(who = args[1]) && (((ins = toint(args[2])) < 1 ? E_INVARG | ins <= (max = length(this.texts[who]) + 1) || (ins = max)) && (this.inserting[who] = ins));
