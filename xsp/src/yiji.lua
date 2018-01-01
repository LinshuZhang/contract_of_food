function to_lilian()
	tap(1279,274)
	logging("打开历练窗口")
	mSleep(1000)
end

function to_yiji()
	tap(938,550)
	logging("打开遗迹窗口")
	mSleep(1000)
end

function is_before_in_yiji()
	if isColor(401,643,0xffffff,90) and isColor(1133,631,0xbcbcbc,90)
	then
		logging("进入遗迹但尚未编辑预备队伍")
		return true
	else
		return false
	end
end

function edit_prepared_team()
	tap(401,643) logging("开始编辑预备队伍") mSleep(1000)
	mSleep(2000)
	for number = 1,string.len(results.first_row_choosed) do
		player_number = tonumber(string.sub(results.first_row_choosed,number,number))
		tap(188+154*(player_number-1),514)
		logging("选择第一排的第"..player_number.."个角色")
		mSleep(1000)
	end
	for number = 1,string.len(results.second_row_choosed) do
		player_number = tonumber(string.sub(results.second_row_choosed,number,number))
		tap(188+154*(player_number-1),659)
		logging("选择第二排的第"..player_number.."个角色")
		mSleep(1000)
	end
	tap(1263,711) logging("确定") mSleep(1000)
end


function is_team_before_edit()
	if isColor(1253,643,0x998067,90) and isColor(516,23,0x9a7567,90) 
	and (isColor(152,438,0x442a24,90) or isColor(155,496,0x442a23,90)) then
		return true
	else
		return false
	end
end

function is_in_yiji()
return isColor(521,46,0x9a7869,90) and isColor(852,44,0x9b7768,90) and isColor(924,47,0xad8774,90)
end

function is_team_after_edit()
	if isColor(1176,662,0xffd9b1,90) and isColor(522,36,0x9b7769,90) then
		return true
	else
		return false
	end
end

function yiji_to_battle()
	tap(1232,664) logging("开始战斗")
	mSleep(1000)
end

function yili_open_team_edit()
	tap(161,462) logging("开始编辑本层遗迹队伍")
	repeat mSleep(1000) until(isColor(1049,686,0xffc156,95))
	mSleep(2000)
end

function is_tianfu_empty(tianfu_number)
	return isColor(64,453+(tianfu_number-1)*135,0xffffff,99)
end

function open_tianfu(tianfu_number)
	tap(64,453+(tianfu_number-1)*135)
	logging("打开天赋"..tianfu_number)
	mSleep(1500)
end

function choose_tianfu(tianfu_choosed)
	if tianfu_choosed >5 then row=1 else row = 0 end
	tap(405+135*((tianfu_choosed-1)%5),135*row+400)
	logging("选择第"..tianfu_choosed..'个天赋')
	mSleep(1000)
	tap(923,291) mSleep(2000)
	tap(120,390) mSleep(2000)
end

function come_into_yiji()
	tap(1210,629)
	logging("进入")
	mSleep(1200)
	if results.how_to_come_into_yiji=='0' then
		tap(589,451)
		logging("直接进入")
	elseif results.how_to_come_into_yiji=='1' then
		tap(757,451)
		logging("扫荡进入")
	end
	mSleep(1000)
end

function add_food_to_team(number)
	if number >5 then row=1 else row = 0 end
	if isColor(146+((number-1)%5)*135.25,473+135*row,0xffa800,95) then
		logging("第"..number.."个人物已经选择")
	else
		tap(209+((number-1)%5)*135.25,463+135*row)
		logging("选择第"..number.."个人物")
	end
	mSleep(1000)
end

function edit_team()
	logging("开始编辑队伍")
	mSleep(200)
	for number = 1,5 do
		add_food_to_team(team_choosed[number])
	end
	tap(1093,703)
	logging("确定编辑完成")
	mSleep(1000)
end

function yiji_battle()
	while true do
		keep_skill()
		if is_victory_interface() or is_battle_end_interface() then 
			if not is_battle_end_interface() then
				battle_finish() mSleep(3000) 
			end
			if not is_battle_end_interface() then
				battle_finish() mSleep(3000) 
			end
			if is_battle_end_interface() then
				logging("战斗结算界面")
				times = 0
				while true and times<3 do
					times = times+1
					battle_finish() mSleep(2000) 
					if is_team_after_edit() or is_in_yiji() then break end
				end
			end
			if is_team_after_edit() or is_in_yiji() then break end
		end	
	end
end

function is_five_level_interface()
	if isColor(1242,628,0x997f65,90) 
	and not (isColor(152,438,0x442a24,90) or isColor(155,496,0x442a23,90)) then
		logging("需要打开宝箱")
		return true
	else
		return false
	end
	
end

function yiji_open_box()
	tap(1111,510) logging("打开宝箱") mSleep(3000)
	tap(667,626) logging("确定") mSleep(2000)
end

function auto_yiji()
	if is_main_interface() then
		to_lilian()
		to_yiji()
		mSleep(1000)
	end
	yiji_battle_times = 0
	while yiji_battle_times < yiji_battle_times_limit do
		if is_before_in_yiji() then
			edit_prepared_team()
			come_into_yiji()
		end
		if is_team_before_edit() then
			yili_open_team_edit()
			for tianfu_number=1,2 do
				if is_tianfu_empty(tianfu_number) then
					open_tianfu(tianfu_number)
					choose_tianfu(tianfu_choosed[tianfu_number])
				end
			end
			edit_team()
		end
		if is_team_after_edit() then 
			yiji_to_battle()
			yiji_battle()
			yiji_battle_times = yiji_battle_times+1
		end
		if is_five_level_interface() then yiji_open_box() end
	end
end