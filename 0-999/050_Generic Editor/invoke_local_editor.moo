#50:invoke_local_editor   this none this rxd

"$generic_editor:invoke_local_editor(name, text, upload, reference, type)";
"Spits out the magic text that invokes the local editor in the player's client.";
"NAME is a good human-readable name for the local editor to use for this particular piece of text.";
"TEXT is a string or list of strings, the initial body of the text being edited.";
"UPLOAD, a string, is a MOO command that the local editor can use to save the text when the user is done editing.  The local editor is going to send that command on a line by itself, followed by the new text lines, followed by a line containing only `.'.  The UPLOAD command should therefore call $command_utils:read_lines() to get the new text as a list of strings.";
"REFERENCE is a string representing the MCP/2.1 reference (usually <obj>.<prop> or <obj>:<verb>) for clients who speak MCP/2.1 simpleedit.";
"TYPE is a string representing the MCP/2.1 type (moo-code, string...) for clients who speak MCP/2.1 simpleedit.";
if (caller != this)
  return;
endif
{name, text, upload, reference, type} = args;
if (typeof(text) == STR)
  text = {text};
endif
session = $mcp:session_for(player);
package = $mcp:match_package("dns-org-mud-moo-simpleedit");
if (session:handles_package(package) == {1, 0})
  package:send_content(session, reference, name, type, text);
  return;
endif
notify(player, tostr("#$# edit name: ", name, " upload: ", upload));
":dump_lines() takes care of the final `.' ...";
for line in ($command_utils:dump_lines(text))
  notify(player, line);
endfor
