function to_jingying()
	tap(57,291)
	logging("去经营")
end

function is_jingying_interface()
	if isColor(1068,297,0xffffc2,90) and isColor(1069,425,0xfffdc0,90)
	and isColor(1069,513,0xffffc4,90) and isColor(776,367,0xffffff,90) then
		logging("经营界面")
		return true
	else
		return false
	end
end

function open_restaurant()
	tap(778,525)
	logging("进入餐厅")
end

function sure_restaurant_reward()
	tap(219,620)
	logging("确认餐厅经营收获")
end

function is_restaurant_interface()
	if isColor(416,713,0x657555,90) and isColor(638,24,0x584132,90)
	and isColor(857,23,0x584132,90) then
		logging("餐厅界面")
		return true
	else
		return false
	end
end

function find_bawangcan()
	keepScreen(true)
	x, y = findColor({0, 0, 1333, 749}, 
		{
			{x=0,y=0,color=0xffffff,offset = 0x090909},
			{x=1,y=11,color=0x3d2b26,offset = 0x090909},
			{x=8,y=11,color=0x402b26,offset = 0x090909},
			{x=10,y=17,color=0x3e2b26,offset = 0x090909}
		},
		99, 0, 0, 0)
	keepScreen(false)
	if x > -1 then
		tap(x,y+80) 
		logging("发现霸王餐")
		times =0 
		repeat
		mSleep(2500) times = times+1
		until(is_bawangcan_interface() or times>5)
	else
		logging("没有发现霸王餐")
	end
end

function is_bawangcan_interface()
	if isColor(46,717,0xb5927b,90) and isColor(963,735,0xefd3bd,90) then
		logging("霸王餐已打开")
		return true
	else
		return false
	end
end

function bawangcan_battle()
	logging("教训他")
	tap(1250,661)
	mSleep(2000)
end

function bawangcan_battle_begin()
	logging("开始战斗")
	tap(1000,518)
	mSleep(2000)
end

function bawangcan_give_up()
	logging("放弃收款")
	tap(943,679)
end

function bawangcan_help()
	logging("求助")
	tap(1088,679)
end



function deal_with_bawangcan()
	find_bawangcan() mSleep(1000)
	if is_bawangcan_interface() then
		if results.deal_with_bawangcan == '0' then
			bawangcan_battle()
			bawangcan_battle_begin()
			keep_skill()
			while true do
				keep_skill()
				battle_finish()
			end
		elseif results.deal_with_bawangcan == '1' then
			bawangcan_give_up()
		elseif results.deal_with_bawangcan == '2' then
			bawangcan_help()
		end
	end
end

function restaurant_open_friend_list()
	tap(1302,361)
	logging("打开好友列表")
	mSleep(2000)
end

function drop_down_friend_list()
	logging("下拉好友列表")
	touch_from_to(1176,701,1154,149)
end



function is_friend_restaurant()
	if isColor(738,22,0xffffff,90) and isColor(1296,397,0xfff7e8,90) 
	and isColor(369,717,0xc69673,90) then
		return true
	else
		return false
	end
end

function find_lubi_in_friend_list()
	k3 = 0
	while true and k3<5 do
		
		x, y = findColor({1207, 105, 1319, 738}, 
			{
				{x=0,y=0,color=0x290608},
				{x=-8,y=0,color=0x240303},
				{x=-9,y=11,color=0xfffffd},
				{x=12,y=-7,color=0xffffff}
			},
			95, 0, 0, 0)
		if x > -1 then
			logging("发现好友的露比")
			tap(x,y)	
			mSleep(3000)
			return true
		else
			logging("没有发现好友的露比")
			drop_down_friend_list() mSleep(2000)
		end
		k3 = k3+1
	end
	return false
end

function find_lubi_in_restaurant()
	x, y = findColor({0, 0, 1333, 749}, 
		{
			{x=0,y=0,color=0x706e5a},
			{x=-9,y=3,color=0x6e6a57},
			{x=-5,y=2,color=0xffffff},
			{x=-4,y=11,color=0xffffff},
			{x=10,y=1,color=0xffffff},
			{x=2,y=-10,color=0xffffff}
		},
		99, 0, 0, 0)
	if x > -1 then
		logging("餐厅中发现露比")
		return x,y
		
	end
	x, y = findColor({0, 0, 1333, 749}, 
		{
			{x=0,y=0,color=0x6e6a57},
			{x=-9,y=-1,color=0x706e5a},
			{x=-4,y=-1,color=0xffffff},
			{x=-5,y=6,color=0xffffff}
		},
		99, 0, 0, 0)
	if x > -1 then
		logging("餐厅中发现露比")
		return x,y
	else
		logging("没有在餐厅中发现露比")
		return false
	end
end

function kill_lubi_in_restaurant_of_friend()
	if find_lubi_in_restaurant() then
		x,y = find_lubi_in_restaurant()
		tap(x,y) mSleep(1000)
		tap(1127,673) logging("猎杀露比") mSleep(1000)
		tap(747,446) logging("确定猎杀") mSleep(3000)
		tap(368,719) logging("点击空白确定收获") mSleep(2000)
		if not is_friend_restaurant() then 
			tap(368,719) logging("点击空白确定收获") mSleep(2000)
		end
	end
end

function come_into_friend_restaurant()
	tap(368,719) logging("点击空白关闭好友列表") mSleep(1000)	
end

function deal_with_lubi_of_friend()
	k2 = 0
	lubi_times = 10
	while true and k2 < lubi_times do
		restaurant_open_friend_list()
		if find_lubi_in_friend_list() then
			k1 = 0
			while (not is_friend_restaurant()) and k1<2 do
				come_into_friend_restaurant()
				k1 = k1+1
			end
			kill_lubi_in_restaurant_of_friend()
			k2=k2+1
			logging("好友露比猎杀次数: "..k2)
		else
			break
		end
	end
	repeat back() mSleep(1500)
	until(is_restaurant_interface())
	logging("回到餐厅界面") mSleep(1000)
end

function clear_bawangcan()
	repeat to_jingying() mSleep(2000)
	until(is_jingying_interface())	
	repeat open_restaurant() 
		mSleep(2000) 
		sure_restaurant_reward() 
		mSleep(2000)
	until(is_restaurant_interface())
	if string.find(results.content_guaji,'2') then
		logging("清理霸王餐")
		deal_with_bawangcan()
		mSleep(1000)
	end
	if string.find(results.content_guaji,'3') then
		logging("自动备菜")
		 auto_ready_food()
	end
	repeat back() mSleep(1000)
	until(is_jingying_interface()) logging("回到经营界面") mSleep(1000)
	repeat tap(1272,287) mSleep(1000) 
	until(is_main_interface()) logging("回到主界面") mSleep(1000)
end

function clear_restaurant()
	repeat to_jingying() mSleep(2000)
	until(is_jingying_interface())
	open_restaurant() mSleep(2000)
	repeat sure_restaurant_reward() mSleep(2000)
	until(is_restaurant_interface())
	if string.find(results.clear_content,'0') then
		deal_with_bawangcan()
	end
	if string.find(results.clear_content,'1') then
		deal_with_lubi_of_friend()
	end
	repeat back() mSleep(1000)
	until(is_jingying_interface()) logging("回到经营界面") mSleep(1000)
	repeat tap(1272,287) mSleep(1000) 
	until(is_main_interface()) logging("回到主界面") mSleep(1000)
end

--Todo: 次数满的时候进行自动退出

function open_ready_food()
	tap(848,689)
	logging("打开备菜")
	mSleep(2000)
end

function is_ready_food_interface()
	if isColor(367,504,0xf7efff,90) then
		logging("成功进入备菜窗口")
		return true
	else
		return false
	end
end

function is_food_empty()
	for food_space_number = 1,4 do
		if isColor(632.5+130.5*food_space_number,527,0xe5b5c7,90) then
			logging("橱窗"..food_space_number.."为空")
			return true
		end
	end
	return false
end

function is_chief_busy(chief_number)
	if isColor(215+338*(chief_number-1),496,0xbab9b9,90) then
		return true
	else
		return false
	end
end

function choose_hearth(hearth_number)
	if hearth_number==1 then
		tap(219,503)
		logging("选择左边的灶台")
	elseif hearth_number==2 then
		tap(546,500)
		logging("选择右边的灶台")
	end
end

function choose_food(food_number)
	x = 850+(food_number-1)%3*187.5
	y = 235+zhengchu((food_number-1),3)*204.5
	
	logging("选择第"..food_number.."个食物")
	times = 0
	repeat tap(x,y) mSleep(2000) times = times+1
	until(isColor(524,177,0xfffff7,90) or times>3)
	repeat tap(570,664) 
	mSleep(2000)
	until(is_ready_food_interface())
end



function is_menu_open()
	if isColor(783,82,0xab6e4e,90) and isColor(1044,83,0xe9e0d9,90) then
		logging("菜单已经打开")
		return true
	else return false
	end
end

function auto_ready_food()
	
	times = 0
	repeat open_ready_food() times = times+1
	until(is_ready_food_interface() or times>7)
	if is_ready_food_interface() then
		times = 0
		while is_food_empty() and times<2 do
			logging("还有空的橱窗")
			mSleep(20)
			for hearth_number = 1,2 do
				if not is_chief_busy(hearth_number) then 
					
					times = 0
					repeat choose_hearth(hearth_number) mSleep(2000) times = times+1
					until(is_menu_open() or times>1)
					if is_menu_open() then
						food_number = tonumber(food_number_iter())
						choose_food(food_number)
					else
						logging("无法打开菜单，可能无厨师")
					end
				else
					logging("厨师"..hearth_number.."正在备菜")
				end
				mSleep(20)
			end
			times = times+1
		end
	end
end