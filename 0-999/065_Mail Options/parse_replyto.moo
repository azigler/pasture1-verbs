#65:parse_replyto   this none this rxd

{oname, raw, data} = args;
if (typeof(raw) == STR)
  raw = $string_utils:explode(raw, ",");
elseif (typeof(raw) == INT)
  return raw ? "You need to give one or more recipients." | {oname, 0};
endif
value = $mail_editor:parse_recipients({}, raw);
if (value)
  return {oname, value};
else
  return "No valid recipients in list.";
endif
