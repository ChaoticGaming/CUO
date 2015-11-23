var/icon/ColorNPC='Text.dmi'
obj/Supplemental/NameDisplay
	icon='Alphabet.dmi'
	layer=3
	pixel_y=-10
	New(var/px,var/IS)
		src.pixel_x=px+9
		src.icon_state=IS

atom/proc/AddName(var/Name2Add)
	var/spot=0
	var/letter=" "
	if(!Name2Add)	Name2Add=src.name
	for(var/O in src.overlays)
		if(O)	if(O:name=="NameDisplay")	src.overlays-=O
		else	src.overlays-=O
	while(letter!="")
		spot+=1
		letter=copytext(Name2Add,spot,spot+1)
		if(letter=="")	return
		var/px=(spot*6)-(length(Name2Add)*6)/2
		var/obj/Supplemental/NameDisplay/NL=new(px,letter)
		if(ColorNPC=='Alphabet.dmi')	ColorNPC+=rgb(0,120,200)
	//	if(istype(src,/mob/NPCs))	NL.icon+=ColorNPC
		src.overlays -= typesof(/obj/Supplemental/NameDisplay)
		src.overlays+=NL