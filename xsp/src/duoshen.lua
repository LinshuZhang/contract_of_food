function to_duoshen()
	logging("进入堕神")
	tap(650,655)
	mSleep(1500)
end

function is_duoshen_exist(duoshen_number)
	if (isColor(86+120.5*duoshen_number,140,0x7e6555,90) 
	or isColor(82+120.5*duoshen_number,142,0x826957,90)) then 
		logging("发现"..duoshen_number.."号位置有空位")
		return false
	else
		logging("发现"..duoshen_number.."号位置有堕神")
		return true
	end
end

function is_duoshen_space_open(duoshen_number)
	return (not isColor(94+120.5*duoshen_number,140,0xffffff,90)) 
end

function get_duoshen_space_limit()
	for duoshen_number = 5,1,-1 do
		if is_duoshen_space_open(duoshen_number) then 
		logging("堕神位置开启至第"..duoshen_number.."个")
		return duoshen_number end
	end
end

function open_duoshen(duoshen_number)
	tap(86+120*duoshen_number,146)
	logging("点击堕神： "..duoshen_number)
	mSleep(1000)
end

function is_can_be_received()
	return isColor(409,684,0xffbe56,90)
end

function duoshen_receive()
	logging("领取堕神")
	tap(443,690)
	mSleep(1000)
end

function duoshen_receive_sure()
	logging("确认领取")
	tap(1210,672)
	mSleep(1000)
end

function choose_lingti_first()
	tap(930,177)
	logging("选择第一个灵体")
	mSleep(1000)
end

function lingti_purify_normal()
	logging("普通净化")
	tap(311,692)
	mSleep(1000)
end

function is_duoshen_sure_interface()
	return isColor(1021,668,0x85b9f9,90) and isColor(1244,665,0xffc056,90)
end

function lingti_purify_awake()
	logging("觉醒净化")
	tap(585,695)
	mSleep(1000)
	tap(746,476) --sure
	mSleep(1500)
	if is_duoshen_sure_interface() then
		logging("确认收获堕神")
		tap(1244,665)
		mSleep(1000)
	end
end

function lingti_purify()
	lingti_purify_normal()
end


function clear_duoshen()
	to_duoshen()
	for duoshen_number = 1,get_duoshen_space_limit() do
		if is_duoshen_exist(duoshen_number) then
			open_duoshen(duoshen_number)
			if is_can_be_received() then
				logging("堕神可领取")
				duoshen_receive()
				duoshen_receive_sure()
				mSleep(3000)
			end
		end
		if not is_duoshen_exist(duoshen_number) then
			choose_lingti_first()
			lingti_purify()
		end
	end
	logging("堕神处理完毕")
	repeat back() mSleep(1000) 
	until(is_main_interface()) logging("回到主界面") mSleep(1000)
end