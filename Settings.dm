#define DEBUG

mob
	step_size=8

var
	Game_Version=0.01
	Pwipe_Version=0.01

/*Server Settings*/
world
	name = "Chaos Universe Online"
	hub = "ChaoticGaming.CU"
	hub_password = "Universal1"
	status = "<html><b><font color=#393939>Chaos Universe Online: BETA</b></font></html>"
	visibility = 1
	version = 0.01
	icon_size = 32
	fps = 40
	tick_lag = 1
	map_format = TOPDOWN_MAP
	mob = /mob/New_Player
	turf = /turf
	sleep_offline = 0
	view = "60x40"
	New()
		..()
		game_state = 0
		world.log = file("worldlog.txt")
		spawn()STARTUP()

client
	script = "<STYLE>BODY {background: black; color: #999999;font-size: -2;font-family:verdana}</STYLE>"
	perspective = EDGE_PERSPECTIVE
	New()
		..()
		//if(key=="Guest-[computer_id]")del(src)
		winset(src,"MAINWINDOW","is-maximized=true")
		spawn() map_size()




client
	proc
		map_size()
			var
				info = winget(src, "MapPane.Map", "size")
				delimiter = findtextEx(info, "x")
				map_width = text2num(copytext(info, 1, delimiter))
				map_height = text2num(copytext(info, delimiter+1))
				view_width = round(map_width / world.icon_size)
				view_height = round(map_height / world.icon_size)
			view = "[view_width]x[view_height]"
			spawn(10) src.map_size()

world
	proc
		STARTUP()
			set background=1
			spawn while(1)
				world.Repop()
				_month = time2text(world.realtime,"MM")
				_day = time2text(world.realtime,"DD")
				_hour = time2text(world.realtime,"hh")
				_year = time2text(world.realtime,"YYYY")
				LocalChatLog=file("World Logs/Local Chat/[_year]/[_month]/[_day]/Local Chat.html")
				AdminChatLog=file("World Logs/Admin Chat/[_year]/[_month]/[_day]/Admin Chat.html")
				sleep(3000)