#40:@send   any any any rxd

if (args && args[1] == "to")
  args = listdelete(args, 1);
endif
subject = {};
for a in (args)
  if ((i = index(a, "=")) > 3 && index("subject", a[1..i - 1]) == 1)
    args = setremove(args, a);
    a[1..i] = "";
    subject = {a};
  endif
endfor
$mail_editor:invoke(args, verb, @subject);
