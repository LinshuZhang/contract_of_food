init("0", 1);
width,height = getScreenSize() 
sysLog("屏幕的宽度为： "..width.."屏幕的高度为： "..height)
toast("屏幕的宽度为： "..width.."屏幕的高度为： "..height)
similar_rate = 93
touch_interval = 1000
time_hold = 250
setScreenScale(750,1334)
dofile('tools')
dofile('config')
dofile('explore')
dofile('order')
dofile('battle')
dofile('restaurant')
dofile('email')
dofile('duoshen')
dofile('yiji')

function is_main_interface()
	return (isColor(806,701,0x9b6d5b,90) 
		and isColor(1068,701,0x946b5a,90)
		and isColor(1275,685,0xfff5f4,90))
end

function back()
	logging("返回")
	tap(61,53)
end

function open_order()
	logging("打开订单列表")
	tap(1268,469)
end

function open_map()
	logging("打开地图")
	tap(1271,570)
end

function go_to_geruiluo()
	logging("去格瑞洛")
	tap(481,366)
end



function go_to_yaozhizhou()
	logging("去耀之洲")
	tap(751,233)
end

function go_to_naifu()
	logging("去奈夫拉斯特")
	tap(428,201)
end

function go_to_yingzhidao()
	logging("去樱之岛")
	tap(152,250)
end

function guaji()
	do_guaji()
	start_time_guaji = mTime()
	start_time_guaji_record = start_time_guaji
	while true do
		if (mTime() - start_time_guaji_record)>(waiting_time*60*1000) then
			do_guaji()
			start_time_guaji_record = mTime()
		end
		shengyu_time = waiting_time - zhengchu((mTime() - start_time_guaji_record),60*1000)
		logging("等待下次挂机内容检查中,剩余时间还有"..shengyu_time.."分钟")
		back() mSleep(2000) back() --保持屏幕激活
		logging("每半分钟保持游戏激活")
		mSleep(30000)
	end
end

function do_guaji()
	if string.find(results.content_guaji,'0') then
		logging("自动探索")
		keep_explore()
	end
	if string.find(results.content_guaji,'1') then
		logging("自动堕神")
		clear_duoshen()
	end
	if string.find(results.content_guaji,'2') or string.find(results.content_guaji,'3') then
		clear_bawangcan()
	end
end

--is_bawangcan_interface()

if results.choose_function == '0' then
	battle()
elseif results.choose_function == '1' then
	guaji()
elseif results.choose_function == '2' then
	if string.find(results.clear_content,'2') then
		clear_email()		
	end
	if string.find(results.clear_content,'0') or string.find(results.clear_content,'1') then
		clear_restaurant()		
	end
elseif results.choose_function == '3' then
	auto_yiji()
end

