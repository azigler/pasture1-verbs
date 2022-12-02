#155:standard_menu   this none this rxd

":standard_menu(LIST <menu options>[, STR <user input>, INT <ignore categories>]) => ANY | $failed_match";
"Presents a menu of choices to the user and attempts to interpret it in the context of notes and categories. That is to say, if the user enters a number, it will first check to see if that number is a valid menu choice. If it's not valid, or the user enters other input, it's assumed to be a search string.";
"If <user input> is supplied and isn't an empty string, that will be used instead of presenting the player with a separate input prompt.";
"If <ignore categories> is true, categories won't be searched.";
"NOTE: This verb is /interactive/. It will prompt the player for additional information if necessary.";
"The return value will either be a single choice from the available menu or $failed_match if no match was found.";
"--";
"TODO: Investigate how much of this we can move into SQLite itself. The whole search could be a query and cut out all of this code, who knows.";
{menu, ?choice = "", ?ignore_categories = 0} = args;
no_input = choice == "";
if (no_input)
  choice = $command_utils:read();
endif
if (choice == "")
  return $failed_match;
elseif (no_input && $string_utils:is_numeric(choice))
  "Only match to numeric input options if we actually saw the menu. Otherwise, assume they're referencing an ID directly.";
  option = toint(choice);
  if (option > 0 && option <= length(menu))
    return menu[option];
  endif
endif
"Not a menu option. We'll try it as a text search. Should we alert the player?";
"-- Parse metadata search options";
"Possible options:";
"  tags: Comma separated list of tags.";
"  name: Comma separated list of titles.";
"  content: A string of text to search for.";
"  id: The ID of a note to open.";
"--";
search_tags = search_names = {};
search_content = "";
parsing = $string_utils:is_numeric(choice) ? "id" | "name";
total_criteria = 0;
for x in (explode(choice, " "))
  if (x in {"tags:", "tag:"})
    parsing = "tags";
    continue;
  elseif (x in {"name:", "title:"})
    parsing = "name";
    continue;
  elseif (x in {"content:", "body:", "contents:"})
    parsing = "content";
    continue;
  elseif (x in {"id:"})
    parsing = "id";
    continue;
  endif
  if (parsing != "content" && x[$] == ",")
    x = x[1..$ - 1];
  endif
  if (parsing == "tags")
    search_tags = setadd(search_tags, x);
  elseif (parsing == "name")
    search_names = setadd(search_names, x);
  elseif (parsing == "content")
    search_content = tostr(search_content, x, " ");
  elseif (parsing == "id")
    "ID searching supercedes all other searches, obviously, so we take a shortcut here return if it's a valid ID.";
    player:tell("([red]debug[normal]) Searching for ID: ", x);
    if ((search_id = tostr("N", x)) in menu)
      return search_id;
    else
      return $failed_match;
    endif
  endif
endfor
total_criteria = total_criteria + (search_names != {}) + (search_tags != {}) + (search_content != "");
if (this:get_option("debug"))
  player:tell("([red]debug[normal]) Searching for tags: ", toliteral(search_tags));
  player:tell("([red]debug[normal]) Searching for names: ", toliteral(search_names));
  player:tell("([red]debug[normal]) Searching for content: ", search_content);
  player:tell("([red]debug[normal]) Searchable criteria: ", total_criteria);
  player:tell();
endif
matches = match_names = {};
last_category = 1;
breadcrumb_cache = [];
start = ftime(1);
shown_search_msg = 0;
if (search_content != "")
  "For performance, we use SQLite full text search first. Once we have these IDs, we can skip all others in the loop below while still getting the category data we need for breadcrumbs.";
  search_content_results = this:search_note_body(search_content);
endif
for x in (menu)
  "We have to do a mildly silly trick here to keep track of the last category ID because a single note can belong to multiple categories. As such, we'd not know WHICH category to choose for the breadcrumb.";
  if (x[1] == "C")
    last_category = toint(x[2..$]);
    if (ignore_categories)
      continue x;
    endif
  endif
  if (search_content != "" && toint(x[2..$]) in search_content_results == 0)
    continue;
  endif
  if (this:get_option("show_all_occurances") && x in matches)
    "TODO: Make an option to show all or just the first.";
    continue;
  endif
  "All criteria given have to match before we return a result. So matched will increment each time we get a match and then, at the end, get compared with the total tags present. If they're the same, the match is returned. If not, it's thrown away for not meeting all criteria.";
  matched = 0;
  name = this:(x[1] == "C" ? "category_name" | "note_name")(x[2..$]);
  matched_names = 0;
  if (search_names != {})
    for name_search in (search_names)
      if (pcre_match(name, name_search))
        matched_names = matched_names + 1;
      endif
    endfor
    if (matched_names == length(search_names))
      matched = matched + 1;
    endif
  endif
  if (search_tags != {})
    tag_success = 1;
    all_tags = this:tags_for_note(x[2..$]);
    "Map english tags to tag IDs...";
    for tag in (search_tags)
      id = this:find_tag_by_name(tag);
      if (id == $failed_match || !(id in all_tags))
        "No point in continuing. It's all tags or nothin'.";
        tag_success = 0;
        break;
      endif
    endfor
    if (tag_success)
      matched = matched + 1;
    endif
  endif
  if (search_content != "" && search_content_results != {})
    matched = matched + 1;
  endif
  if (matched >= total_criteria)
    matches = {@matches, x};
    crumb_name = tostr(x[1], "__", last_category);
    if (maphaskey(breadcrumb_cache, crumb_name))
      crumb = breadcrumb_cache[crumb_name];
    else
      crumb = this:category_breadcrumb(last_category, x[1] == "N");
      breadcrumb_cache[crumb_name] = crumb;
    endif
    match_names = {@match_names, tostr(name, " (", crumb, ")")};
  endif
endfor
if (!matches)
  return $failed_match;
else
  description = {};
  if (search_names != {})
    description = {@description, tostr("with the name ", $string_utils:english_list(search_names))};
  endif
  if (search_tags != {})
    description = {@description, tostr("with the ", $s("tag", length(search_tags)), " ", $string_utils:english_list(search_tags))};
  endif
  if (search_content != "")
    description = {@description, tostr("containing the string \"", search_content, "\"")};
  endif
  player:tell("There ", length(matches) == 1 ? "is" | "are", " ", length(matches), " ", $s("option", length(matches)), " ", $string_utils:english_list(description), ". Please choose:");
  return matches[$menu_utils:menu(match_names)];
endif
