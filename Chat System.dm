var/_day=""
var/_hour=""
var/_month=""
var/_year=""
var/LocalChatLog=file("World Logs/Local Chat/[_year]/[_month]/[_day]/Local Chat.html")
proc/LCLog(Text)
	LocalChatLog<<"<br>@[_hour]:00 - [Text]"
mob
	verb
		Local_Chat(msg as text)
			if(!src.muted)
				view() << "<Font Color = Blue>Local Chat |[usr.key]|:</Font><Font Color = White> [msg]"
				LCLog("Local Chat |[usr.key]|: [msg]")
			else
				src << "You are <font color=red><u>muted</font></u> for [mutedtime] more min(s)."
