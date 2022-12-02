#10:listname   this none this rxd

return {"???", "blacklist", "graylist", "redlist", "spooflist"}[1 + index("bgrs", (args[1] || "?")[1])];
