#65:show_netmail   this none this rxd

if (value = this:get(@args))
  return {value, {"Have MOO-mail automatically forwarded to me at", "my registered email-address."}};
else
  return {value, {"Receive MOO-mail here on the MOO."}};
endif
"Last modified Tue Jun  1 02:10:08 1993 EDT by Edison@OpalMOO (#200).";
