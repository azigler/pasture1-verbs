# 12.05.2022:
- @locate command now exists for builderclass and above. (caranov): 17:47:08
- match_exit on $room should now find an exit by its first letter, regardless of custom exit status. (caranov): 17:47:08
- The moo will sync all verbs to git every 4 hours. all non-player object folders include a __dump.txt that includes a full copy-paste @dump with create. enjoy. (Zig): 18:55:38
# 12.04.2022:
- Added support for automatically going AFK and coming... BTK? Whatever. Anyway, you can configure it with the .autoafk_options property on yourself. The keys are: auto_afk (enable automatic AFK), auto_unafk (enable automatic un-AFK), and max_time (the time, in seconds, you're idle before going AFK). (lisdude): 03:46:34
- Added AUTOAFK-O to configure the recently-implemented AFK preferences through an options menu interface (because I'm a sucker for menues!) (Saeed): 04:48:59
- Added @advent, which will show Zig's private leaderboard for Advent of Code 2022. (lisdude): 21:03:31
# 12.03.2022:
- Added PEER [direction] to look in [direction] before going to the monumental effort of actually walking there. (lisdude): 02:52:58
- Added integration message support for objects when LOOKing in a room. The basic usage consists of setting the .look_contents_msg property of the object in question (currently only defined on $thing since most virtual reality items typhically descend from that), and relies on a :look_contents_msg verb to handle pronoun substitutions and all that fun stuff. People looking to extend integration messages to be more interesting can override this verb on their own objects.
- Updated @LIST to display a verb's last modified timestamp (if any) prior to printing the verb's code. (Saeed): 03:47:52
- Room matching has been slightly improved. It no longer matches to firstword only, but rather gets all aliases. It can also match to ordinal references now, for instance second note. (caranov): 10:20:14
- Says now have playerwritten emotions and tones, along with new natural punctuation ones. It is heavily recommended to use help me:say if you are interested in using it to its full extent. (caranov): 14:55:28
- Added the @CODE-REVIEW <player> command to receive a breakdown of verbs/total lines of code in verbs owned by <player>. (Saeed): 18:55:02
# 12.02.2022:
- Changelog created.(caranov)
- Small following system made for playerclassed objects.(caranov)
- Added @vsearch and @psearch for searching verbs / properties by name. ((lisdude)
- Added @status*-all for retrieving boring technical details about the MOO. ((lisdude)
- Socials have been implimented. All ways to modify them are listed in help me:newsocial and help me:rmsocial. (caranov)
- [$edit_utils:cmd_previous/cmd_next] Added to move up and down 1 line in the editor, respectively. This also means that `p' is no longer an alias for `list' and now corresponds to `previous'. (Saeed)
- The @socials command now exists. If no arguments are provided, it lists all socials. Otherwise, it searches for socials matching the provided string. (caranov)
- [$edit_utils:cmd_localedit] Replaced nonexistent option reference with "default_editor". (Saeed)
- [$edit_utils:cmd_save] Disallow saving if the editor is devoid of text. (Saeed)
- [$edit_utils:cmd_insert] Print the line above and below the insertion point when used with no arguments, similar to the LambdaCore editor. (Saeed)
- Added a notetaking feature. '@add-feature $notes_feature' and '@notes help' for details. (lisdude)
- Fixed #154:@tags to point to $ansi_utils:color_selector instead of color_select (since the ladder doesn't exist in ToastCore). (Saeed): 21:35:45
- emoting has been redone. matching can be done with the at(@) symbol(although it is not very effective until matching is recoded to be much better). You can use @me for your name, @my for his/hers. Using 's for the begining of the emote will be taken into consideration, so it will appear smoothly. (caranov): 21:36:14
- Added basic timestamping to verb edits. (Saeed): 22:23:25
- Added the (sure to be exciting) `config' argument to @VERSION. Thanks, Lisdude. (Saeed): 23:16:14
