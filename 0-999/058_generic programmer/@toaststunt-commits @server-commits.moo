#58:"@toaststunt-commits @server-commits"   none none none rd

"Display ToastStunt commits.";
sourcedata = server_version("source");
current_commit = sourcedata["commit" in slice(sourcedata)][2];
last_commits = parse_json($string_utils:strip_binary(curl("https://api.github.com/repos/lisdude/toaststunt/commits")));
commit_lst = {{"Author", "SHA", "Date", "Message"}};
for commit in (last_commits)
  is_current_commit = commit["sha"] == current_commit[1..$ - 1];
  author = commit["commit"]["author"]["name"] + " (" + commit["commit"]["author"]["email"] + ")";
  message = commit["commit"]["message"];
  if (line_End = index(message, "~0a"))
    message = message[1..line_End - 1];
  endif
  sha = commit["sha"];
  date = commit["commit"]["author"]["date"];
  commit_lst = {@commit_lst, {(is_current_commit ? "[green]*[normal]" | "") + author, sha[1..6], date, message}};
endfor
player:tell_lines($string_utils:fit_to_screen(commit_lst, 2, 1));
player:tell();
player:tell("[green]*[normal] == The server is presently compiled from this commit.");
