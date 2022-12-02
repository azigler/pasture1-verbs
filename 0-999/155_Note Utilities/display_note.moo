#155:display_note   this none this rxd

":display_note(INT <note ID>) => output";
"Retrieve the note indicated by <note ID> and print its contents to the player.";
"TODO: Print tags too.";
{note} = args;
{title, entry} = this:get_note(note);
{author, author_obj, created, modified} = `this:note_metadata(note) ! E_INVARG => {"Unknown", #-1, 0, 0}';
line = $ansi_utils:space(player:linelen(), "-");
player:tell(line);
player:tell(title);
player:tell(line);
player:tell_lines_suspended(entry);
tags = this:tags_for_note(note);
if (tags != {})
  player:tell($string_utils:center("Tags", length(line), "-"));
  player:tell(this:tag_title_list(tags));
endif
player:tell($string_utils:center("Info", length(line), "-"));
author_text = tostr("Author: ", author, author_obj != #-1 ? tostr("(", author_obj, ")") | "");
reference_text = tostr("Note ID: ", note);
created_text = tostr("Created: ", !created ? "Unknown" | $time_utils:mmddyy(created));
modified_text = tostr("Last Modified: ", !modified ? "Unknown" | $time_utils:mmddyy(modified));
len = player:linelen();
if (length(author_text) + length(reference_text) >= len)
  player:tell(author_text, reference_text);
else
  player:tell(author_text, $string_utils:right(reference_text, len - length(author_text)));
endif
if (length(created_text) + length(modified_text) >= len)
  player:tell(created_text, " ", modified_text);
else
  player:tell(created_text, $string_utils:right(modified_text, len - length(created_text)));
endif
player:tell(line);
