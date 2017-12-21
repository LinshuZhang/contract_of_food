function open_order_interface()
	logging("查看订单完成情况")
	tap(1282,468)
end

function is_order_interface()
	if isColor(842,44,0xfcf1e4,90) and isColor(1245,46,0xfcf1e4,90) then
		return true
	else
		return false
	end
end

function is_order_finished()
	if isColor(1248,148,0xf9bd75,90) and isColor(1250,232,0xffdd90,90) then
		logging("有订单已经完成")
		return true
	else
		return false
	end
end

function receive_award()
	logging("领取奖励")
	tap(1246,188)
end

function is_receive_award_interface()
	if isColor(629,659,0xffb040,90) and isColor(438,97,0xf1e2ce,90) 
	and isColor(514,162,0xfaf1e1,90) then
		logging("订单奖励领取界面")
		return true
	else
		return false
	end
end

function sure_receive_award()
	logging("领取")
	tap(668,653)
end

function tap_blank()
	tap(420,25)
end

function clear_order()
	open_order_interface() mSleep(2000)
	while is_order_finished() do
		receive_award() mSleep(2000)
		if is_receive_award_interface() then
			sure_receive_award() mSleep(2000)
			tap_blank() mSleep(2000)
		end
	end
	logging("无已完成订单")
	times = 0
	repeat tap_blank() times = times+1 logging("尝试回到主界面")
	until(is_main_interface() or times>2)
end

function find_new_order()
	x, y = findColor({508, 61, 1225, 618}, 
		{
			{x=0,y=0,color=0xd01f1f},
			{x=5,y=-19,color=0xd01f1f},
			{x=1,y=-13,color=0xd01f1f},
			{x=3,y=-23,color=0xd11f1f}
		},
		95, 0, 0, 0)
	if x > -1 then
		logging("发现订单，坐标:"..x..','..y)
	else
		logging("没有找到订单")
	end
end

function open_new_order(x,y)
	tap(x,y)
	mSleep(2000)
end