var/AdminChatLog=file("World Logs/Admin Chat/[_year]/[_month]/[_day]/Admin Chat.html")
proc/ACLog(Text)
	AdminChatLog<<"<br>@[_hour]:00 - [Text]"
mob
	var
		muted=0
		mutedtime=0
		AdminLock=0
		AdminLevel=0
	proc
		AdminLockCheck()
			if(usr.AdminLock==1) return 1
			else return 0
		AdminMessage(MSG)
			for(var/mob/X in world)
				if(X.AdminLevel>=1)
					X<<"<b><font color=#FE9A2E><font color=red>Admin Message:</font> [MSG]"
		UnmuteTimer(T)
			src.muted=1
			sleep(T)
			if(!src.muted)return
			world<<"<b>[src] has been <font color=red>Unmuted."
			src.muted = 0
	Admin/Level1
		verb
			Mute_Player(mob/M in world)
				set category = "Admin"
				if(AdminLockCheck())
					usr<<"<font color=#FE9A2E>Your Administrator Powers Are Currently Locked."
					return
				else
					switch(alert("Are you sure you want to mute [M]?","Mute [M]","Yes","No"))
						if("Yes")
							goto Yes
						if("No")
							return
					return
					Yes
					if(M.AdminLevel>=AdminLevel && !M.key == "CG_Xanthus" && !M.key == "The Chaos Crew" && !M.key == "Chaotic Gaming")
						AdminMessage("[usr] tried Muting [M]")
						return
					var/Reason=input("Input a valid reason")as null|text
					var/Time=input({"For How Long? (In Seconds)
(Max of 600 Seconds (10 Minutes))
(Input 0 or below 0 for target to remiain muted until
unmuted. Any time past 10 minutes will be lowered
to 10 minutes.)"})as num
					if(!M)return
					if(Time>=600)
						Time=600
					if(Time>=1)
						Time*=10
					if(Reason)
						if(Time)
							world<<"<b>[M] has been <font color=red>Muted</font> by [src]. ([Reason])([Time/10] Seconds)"
						else
							world<<"<b>[M] has been <font color=red>Muted</font> by [src]. ([Reason])"
					else
						if(Time)
							world<<"<b>[M] has been <font color=red>Muted</font> by [src]. ([Time/10] Seconds)"
						else
							world<<"<b>[M] has been <font color=red>Muted</font> by [src]."
					if(Time<=0)
						return
					if(!M)return
					M.muted = 1
					M.UnmuteTimer(Time)