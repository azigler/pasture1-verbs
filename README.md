# pasture1 changelog
## 12.07.2022:
- [$prog:@forked] Add the total number of returned tasks at the bottom. (Saeed): 17:39:54
- [$wiz:@code-review] Report how long the verb took to finish. (Saeed): 17:45:42
## 12.06.2022:
- source control now includes the changelog as README.md (Zig): 18:04:09
- Added $waif_utils (which is also $anon_utils) to find WAIFs and ANONs. Feel free to try it out. Example: $anon_utils:find_anons() (Zig): 22:32:53
## 12.05.2022:
- @locate command now exists for builderclass and above. (caranov): 17:47:08
- match_exit on $room should now find an exit by its first letter, regardless of custom exit status. (caranov): 17:47:08
- The moo will sync all verbs to git every 4 hours. all non-player object folders include a __dump.txt that includes a full copy-paste @dump with create. enjoy. (Zig): 18:55:38
## 12.04.2022:
- Added support for automatically going AFK and coming... BTK? Whatever. Anyway, you can configure it with the .autoafk_options property on yourself. The keys are: auto_afk (enable automatic AFK), auto_unafk (enable automatic un-AFK), and max_time (the time, in seconds, you're idle before going AFK). (lisdude): 03:46:34
- Added AUTOAFK-O to configure the recently-implemented AFK preferences through an options menu interface (because I'm a sucker for menues!) (Saeed): 04:48:59
- Added @advent, which will show Zig's private leaderboard for Advent of Code 2022. (lisdude): 21:03:31
## 12.03.2022:
- Added PEER [direction] to look in [direction] before going to the monumental effort of actually walking there. (lisdude): 02:52:58
- Added integration message support for objects when LOOKing in a room. The basic usage consists of setting the .look_contents_msg property of the object in question (currently only defined on $thing since most virtual reality items typhically descend from that), and relies on a :look_contents_msg verb to handle pronoun substitutions and all that fun stuff. People looking to extend integration messages to be more interesting can override this verb on their own objects.
- Updated @LIST to display a verb's last modified timestamp (if any) prior to printing the verb's code. (Saeed): 03:47:52
- Room matching has been slightly improved. It no longer matches to firstword only, but rather gets all aliases. It can also match to ordinal references now, for instance second note. (caranov): 10:20:14
- Says now have playerwritten emotions and tones, along with new natural punctuation ones. It is heavily recommended to use help me:say if you are interested in using it to its full extent. (caranov): 14:55:28
- Added the @CODE-REVIEW <player> command to receive a breakdown of verbs/total lines of code in verbs owned by <player>. (Saeed): 18:55:02
