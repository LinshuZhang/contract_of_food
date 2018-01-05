function go_to_beilidao()
	logging("去北离岛")
	tap(617,212)
end

function go_to_tiancheng()
	logging("去天城")
	tap(778,588)
end

function go_to_dizhiguancezhan()
	logging("去地质观测站")
	tap(841,474)
end

function go_to_yuejiantai()
	logging("去月见台")
	tap(651,532)
end

function is_explore_reward_interface()
	if (isColor(217,258,0xffffff,95)
		and isColor(252,426,0xd2aca2,90)
		and isColor(239,465,0xd4aea2,90)) then
		logging("探索收获界面")
		return true
	else
		return false
	end
end

function sure_reward()
	tap(663,625)
end

function is_find_box1()
	if (isColor(756,139,0xfffaf5,90) and isColor(795,218,0xfffaf5,90) 
		and not isColor(1225,603,0xffd5ac,90)) then
		logging("发现宝箱1")
		return true
	else
		return false
	end
end

function is_find_box2()
	if (isColor(1152,437,0xee7f65,90) and isColor(1131,353,0xfaaf90,90) 
		and not isColor(1225,603,0xffd5ac,90))
	then
		logging("发现宝箱2")
		return true
	else
		return false
	end
end

function is_find_box3()
	if ((isColor(934,427,0xcc6763,90) and isColor(973,421,0xc95d5c,90) )
		or (isColor(921,434,0xb3765b,90) and isColor(975,443,0xb27257,90))
		and not isColor(1225,603,0xffd5ac,90))
	then
		logging("发现宝箱3")
		return true
	else
		return false
	end
end



function open_box1()
	logging("打开第一个宝箱")
	tap(960,413)
end

function open_box2()
	logging("打开第二个宝箱")
	tap(1127,404)
end

function open_box3()
	logging("打开第三个宝箱")
	tap(961,368)
end

function is_explore_option_interface()
	if isColor(1026,620,0xffbf56,90) and isColor(1186,646,0xffb455,90) then
		logging("选择探索还是前进")
		return true
	else
		return false
	end
end

function explore_continue()
	logging("继续探索")
	tap(1232,630)
	mSleep(1000)
end

function explore_finish()
	logging("结束探索")
	tap(1070,634)
	mSleep(1000)
end



function is_choose_cave_interface()
	if isColor(49,53,0xfff3bc,90) and isColor(1241,351,0xc27343,90)
	and isColor(1284,287,0xc26528,90) then
		logging("洞穴选择界面")
		return true
	else
		return false
	end
end

function choose_cave()
	if results.cave_number == '0' then
		logging("选择左边洞穴")
		tap(292,384)
	elseif results.cave_number == '1' then
		logging("选择中间洞穴")
		tap(666,368)
	elseif results.cave_number == '2' then
		logging("选择右边洞穴")
		tap(1047,367)
	end
end

function is_cave_choosed_interface()
	if is_choose_cave_interface() and isColor(1228,600,0xffd5ac,90) then
		logging("洞穴已选择")
		return true
	else
		return false
	end
end

function do_explore()
	tap(1232,665)
end

function is_exploring_interface()
	if isColor(1235,619,0xffbf56,90) and isColor(1153,638,0xffb44c,90) then
		logging("还在探索过程中")
		return true
	else
		return false
	end
end

function is_explore_enemy()
	if isColor(1231,607,0xffd5ac,90) and isColor(1199,656,0xffd5ac,90) then
		logging("发现敌人")
		return true
	else
		return false
	end
end

function challenge_enemy()
	logging("挑战敌人")
	tap(1228,643)
end

function is_victory_interface()
	if isColor(1018,218,0xffe1a0,90) 
	and isColor(1180,257,0xffe1a4,90)
	and isColor(1083,707,0xffb94e,90)
	then
		logging("胜利界面")
		return true
	else
		return false
	end
end

function close_victory_interface()
	tap(1040,709)
	if isColor(1007,699,0xffbf56,90) then tap(1007,699) end
end

function deal_with_enemy()
	challenge_enemy() mSleep(2000)
	while true do
		keep_skill()
		if is_victory_interface() then
			close_victory_interface() mSleep(1000)
			break
		end
	end
end

function next_team()
	tap(1109,641)
	logging("下一队")
end

function is_cave_continue_interface()
	if isColor(1073,708,0xffb23f,90) and isColor(1237,634,0xffd5ac,90) then
		logging("继续探险的洞穴选择界面")
		return true
	else
		return false
	end
end

function is_add_xinxian_interface()
	if isColor(1226,295,0xffd3a8,90) and isColor(1246,642,0x89c72f,90) then
		logging("新鲜度消耗完毕")
		return true
	else
		return false
	end
end

function explore_retreat()
	tap(1038,708)
	logging("撤退")
	mSleep(1000)
end

function deal_with_exploring()
	times = 0
	while (not is_exploring_interface()) and times<5 do
		mSleep(1000)
		if is_explore_option_interface() then
			explore_continue()
		end
		if is_explore_reward_interface() then
			sure_reward()
			mSleep(2000)
		end
		if is_find_box1() then
			open_box1()
			mSleep(3500)
			sure_reward() mSleep(3000)
		end
		if is_find_box2() then
			open_box2()
			mSleep(3500)
			sure_reward() mSleep(3000)
		end
		if is_find_box3() then
			open_box3()
			mSleep(3500)
			sure_reward() mSleep(3000)
		end
		if is_explore_enemy() then
			deal_with_enemy()
		end
		if is_cave_continue_interface() then
			choose_cave() mSleep(2000)
			tap(1228,669) mSleep(1000) logging("继续探索")
			if is_add_xinxian_interface() then
				back()
				explore_retreat()
				tap(1217,685) --关闭
				mSleep(1000)
				
			end
		end
		if is_choose_cave_interface() then
			choose_cave() mSleep(2000)
			times_change_team = 0
			while is_cave_choosed_interface() and times_change_team<6 do
				
				if results.is_leave_first_team == '0' and times_change_team==0 then --预留第一队不用于探索
					logging("需要留出第一队")
					next_team() mSleep(2000)
				end
				do_explore() mSleep(2000)
				times_change_team = times_change_team+1
				if is_exploring_interface() then break end
				next_team() mSleep(2000)
			end
			if is_exploring_interface() then
				back()
				mSleep(2000)
			else
				logging("探索用队伍不足")
			end
		end
		times = times+1
	end
	mSleep(1000)
	if not is_main_interface() then
		repeat back() mSleep(2000) 
		until(is_main_interface())
	end
end

function keep_explore()
	if is_main_interface() then
		logging("在主界面")
		if string.find(results.choose_map,'0') then
			open_map() mSleep(2000)
			go_to_geruiluo() repeat mSleep(2000) until(is_main_interface())
			go_to_beilidao() repeat mSleep(3000) until(not is_main_interface())
			deal_with_exploring()
		end
		if string.find(results.choose_map,'1') then
			open_map() mSleep(2000)
			go_to_yaozhizhou() repeat mSleep(2000) until(is_main_interface())
			go_to_tiancheng() repeat mSleep(3000) until(not is_main_interface())
			deal_with_exploring()
		end
		if string.find(results.choose_map,'2') then
			open_map() mSleep(2000)
			go_to_naifu() repeat mSleep(2000) until(is_main_interface())
			go_to_dizhiguancezhan() repeat mSleep(3000) until(not is_main_interface())
			deal_with_exploring()
		end
		if string.find(results.choose_map,'3') then
			open_map() mSleep(2000)
			go_to_yingzhidao() repeat mSleep(2000) until(is_main_interface())
			go_to_yuejiantai() repeat mSleep(3000) until(not is_main_interface())
			deal_with_exploring()
		end
	end
end

