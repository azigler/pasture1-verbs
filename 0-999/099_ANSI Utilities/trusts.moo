#99:trusts   this none this rxd

":trusts (OBJ player) => true of <player> is trusted by the ANSI system.";
return args[1].wizard || args[1] == this.owner || args[1] in this.trusted;
