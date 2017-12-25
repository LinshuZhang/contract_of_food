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
	tap(781,480)
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
x, y = findColor({0, 0, 1333, 749}, 
{
	{x=0,y=0,color=0xffffff,offset = 0x090909},
	{x=1,y=11,color=0x3d2b26,offset = 0x090909},
	{x=8,y=11,color=0x402b26,offset = 0x090909},
	{x=10,y=17,color=0x3e2b26,offset = 0x090909}
},
99, 0, 0, 0)
if x > -1 then
		logging("发现霸王餐")
		tap(x,y+80)
		mSleep(1500)
	else
		logging("没有发现霸王餐")
	end
end

function is_bawangcan_interface()
	if isColor(1238,626,0xffd5ac,90) and isColor(795,689,0xedd1b8,90)
	and isColor(79,689,0xaf9277,90) then
		return true
	else
		return false
	end
end

function bawangcan_battle()
	logging("教训他")
	tap(1244,661)
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
			bawangcan_battle() mSleep(2000)
			bawangcan_battle_begin()
			keep_skill()
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
							if is_restaurant_interface() then break end
						end
					end
					if is_restaurant_interface() then break end
				end	
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
		else
			break
		end
	end
	repeat back() mSleep(1500)
	until(is_restaurant_interface())
	logging("回到餐厅界面") mSleep(1000)
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