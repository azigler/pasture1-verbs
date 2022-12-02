#87:check_obscure_combinations   this none this rxd

pwd = args[1];
if (match(pwd, "^[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]$"))
  return "Social security numbers are potentially insecure passwords.";
elseif (match(pwd, "^[0-9]+/[0-9]+/[0-9]+$"))
  return "Passwords which look like dates are potentially insecure passwords.";
endif
