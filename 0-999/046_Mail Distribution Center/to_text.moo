#46:to_text   this none this rxd

":to_text(@msg) => message in text form (suitable for printing)";
return {"Date:     " + player:ctime(args[1]), "From:     " + args[2], "To:       " + args[3], @args[4] == " " ? {} | {"Subject:  " + args[4]}, @args[5..$]};
