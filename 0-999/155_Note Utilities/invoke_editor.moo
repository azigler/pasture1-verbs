#155:invoke_editor   this none this rxd

":invoke_editor(STR <upload command>[, LIST <existing text>, STR <title>])";
"Either launch the local editor or the in-line editor for editing a new or existing note.";
"<upload command> is the MOO command that will get called with the contents of the editor.";
{upload_command, ?text = {}, ?title = tostr($network.moo_name, " Note")} = args;
session = $mcp:session_for(player);
if (player:edit_option("local") != 1 || session == #-1 || session.authentication_key == E_NONE || !session:handles_package($mcp.registry:match_package("dns-org-mud-moo-simpleedit")))
  "This is... not ideal:";
  data = $edit_utils:editor(text);
  force_input(player, upload_command);
  for x in (data)
    yin();
    force_input(player, x);
  endfor
  force_input(player, ".");
else
  $generic_editor:invoke_local_editor(title, text, upload_command, upload_command, "upload-command");
  "bridge = $waif_bridge:request_raw_read(task_id(), title);";
  "$verb_editor:invoke_local_editor(title, text, tostr(\"@waif-bridge \", bridge, \":\", task_id()), bridge, \"waif-bridge\");";
  "suspend();";
  "data = $waif_bridge.(bridge);";
  "$waif_bridge:destroy(bridge);";
  "return data[3];";
endif
