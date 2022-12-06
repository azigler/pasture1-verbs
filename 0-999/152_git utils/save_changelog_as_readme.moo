#152:save_changelog_as_readme   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
changelog = $changelog:read();
handle = file_open("verbs/README.md", "w-tn");
file_writeline(handle, "# pasture1 changelog");
for line in (changelog)
  yin();
  if (length(line) < 12)
    file_writeline(handle, "## " + line);
  else
    file_writeline(handle, "- " + line);
  endif
endfor
file_close(handle);
return player:notify("Changelog successfully saved to README.md");
