function open_battle_map()
	if map_x and map_y then
		logging("再次进入关卡，已经胜利"..battle_times.."次")
		tap(map_x,map_y)
		mSleep(2000)
		sysLog("尝试进入关卡")		
	else
		if results.is_dialog=='0' then
			logging("尚未确定关卡所在位置，请点击屏幕上想要打开的关卡")
		else
			dialog("尚未确定关卡所在位置，请点击屏幕上想要打开的关卡", 0);
		end
		map_x_tmp,map_y_tmp = catchTouchPoint();
		map_y = width-map_x_tmp
		map_x = map_y_tmp
		mSleep(500);
		logging("已获取要战斗关卡坐标点——> ".."x:"..map_x.." y:"..map_y, 0);
		mSleep(500)
		logging("请确认您的队伍配置正确倒计时开始")
		mSleep(1500)
		for times = 4,0,-1 do
			logging(times)
			mSleep(1000)
		end
	end
end

function is_battle_ready_interface()
	if isColor(142,645,0xffc151,90) and isColor(459,646,0xffc04f,90)
	and isColor(1168,579,0xffd3a7,90) then
		logging("战斗准备界面")
		return true
	else
		return false
	end
end

function start_battle()
	logging("开始战斗")
	tap(1207,606)
end

lianxie = {} --连携技能从右往左计数
lianxie[1] = {803,671}
lianxie[2] = {954,672}
lianxie[3] = {1106,666}
lianxie[4] = {1276,663}
tianfu = {} --天赋技能从上往下计数
tianfu[1] = {76,565}
tianfu[2] = {190,674}

function keep_skill()
	for lianxie_number = 1,4 do
		x = lianxie[lianxie_number][1]
		y = lianxie[lianxie_number][2]
		color_r, color_g, color_b = getColorRGB(x, y)
		mSleep(10)
		if color_r > 130 or color_b>130 or color_g>130 then
			tap(x,y)
			mSleep(100)
		end
		interrupt_boss()
		mSleep(20)
	end
	for tianfu_number = 1,2 do
		x = tianfu[tianfu_number][1]
		y = tianfu[tianfu_number][2]
		color_r, color_g, color_b = getColorRGB(x, y)
		mSleep(10)
		if color_r > 130 or color_b>130 or color_g>130 then
			tap(x,y)
			mSleep(100)
		end
		interrupt_boss()
		mSleep(20)
	end
end

function interrupt_boss1()
	point = findColors({568, 71, 1285, 593}, 
		{
			{x=0,y=0,color=0xfefeff},
			{x=3,y=0,color=0xfefeff},
			{x=3,y=3,color=0xfdfefe},
			{x=0,y=3,color=0xfdfeff},
			{x=0,y=8,color=0xfdfdfe},
			{x=0,y=13,color=0xfdfdfe},
			{x=2,y=14,color=0xfdfdfe},
			{x=3,y=11,color=0xfdfdfe},
			{x=3,y=4,color=0xfdfefe}
		},
		99, 1, 0, 0)
	
	if #point ~= 0 then
		tmp_x = 0
		tmp_y = 0
		for var = 1, #point do
			boss_x = point[var].x
			boss_y = point[var].y
			if boss_x -tmp_x > 10 and boss_y - tmp_y >20 then
				tap(boss_x,boss_y)
				mSleep(100)
				tmp_x = boss_x
				tmp_y = boss_y
			end
			if var>1 then break end
		end
	end
end

function interrupt_boss2()
	point = findColors({568, 71, 1285, 593}, 
		{
			{x=0,y=0,color=0xf1929d},
			{x=3,y=4,color=0xfdfdfe},
			{x=8,y=8,color=0xe08a94},
			{x=1,y=4,color=0xfdfdfe},
			{x=6,y=3,color=0xfdfdfe}
		},
		98, 1, 0, 0)
	
	if #point ~= 0 then
		tmp_x = 0
		tmp_y = 0
		for var = 1, #point do
			boss_x = point[var].x
			boss_y = point[var].y
			if boss_x -tmp_x > 10 and boss_y - tmp_y >20 then
				tap(boss_x,boss_y)
				mSleep(100)
				tmp_x = boss_x
				tmp_y = boss_y
			end
			if var>1 then break end
		end
	end
end

function is_victory_interface()
	if isColor(798,290,0xfbebcb,90) and isColor(1259,157,0xfae9c7,90)
	and isColor(1014,262,0xffd97c,90) and isColor(47,333,0xf2d8a6,90) then
		logging("战斗胜利")
		return true
	else
		return false
	end
end

function is_battle_end_interface()
	if isColor(1277,688,0xffc156,90) and isColor(1198,711,0xffb34d,90) then
		return true
	else
		return false
	end
end

function battle_finish()
	tap(1240,703)
end

function interrupt_boss()
	if results.is_interrupt_boss == '0' then
		interrupt_boss2()
		interrupt_boss1()
	end
end

function clear_map()
	start_battle()
	mSleep(2000)
	while true do
		keep_skill()
		interrupt_boss()
		if is_victory_interface() or is_battle_end_interface() then 
			if not is_battle_end_interface() then
				battle_finish() mSleep(2000) 
			end
			if is_battle_end_interface() then
				logging("战斗结算界面")
				battle_finish() mSleep(2000) 
				break 
			end
		end
	end	
end

function battle()	
	battle_times = 0
	while battle_times<battle_times_limit do
		open_battle_map()
		clear_map()	
		battle_times = battle_times+1
	end
end