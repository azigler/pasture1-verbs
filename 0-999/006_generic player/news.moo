#6:news   any none none rxd

"Usage: news [contents] [articles]";
"";
"Common uses:";
"news           -- display all current news, or as @mail-options decree";
"news new       -- display articles you haven't seen yet";
"news all       -- display all current news";
"news contents  -- display headers of current news";
"news <article> -- display article";
"news archive   -- display news which has been marked as archived.";
set_task_perms(player);
cur = this:get_current_message($news) || {0, 0};
arch = 0;
if (!args && (o = player:mail_option("news")) && o != "all")
  "no arguments, use the player's default";
  args = {o};
elseif (args == {"all"})
  args = {};
elseif (args == {"archive"})
  arch = 1;
  args = {};
endif
if (hdrs_only = args && args[1] == "contents")
  "Do the mail contents list";
  args[1..1] = {};
endif
if (args)
  if (typeof(seq = $news:_parse(args, @cur)) == STR)
    player:notify(seq);
    return;
  elseif (seq = $seq_utils:intersection(seq, $news.current_news))
  else
    player:notify(args == {"new"} ? "No new news." | "None of those are current articles.");
    return;
  endif
elseif (arch && (seq = $news.archive_news))
  "yduJ hates this coding style.  Just so you know.";
elseif (seq = $news.current_news)
else
  player:notify("No news");
  return;
endif
if (hdrs_only)
  $news:display_seq_headers(seq, @cur);
else
  player:set_current_message($news, @$news:news_display_seq_full(seq));
endif
