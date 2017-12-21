init("0", 1);
width,height = getScreenSize() 
sysLog("屏幕的宽度为： "..width.."屏幕的高度为： "..height)
toast("屏幕的宽度为： "..width.."屏幕的高度为： "..height)
similar_rate = 93
touch_interval = 1000
time_hold = 250
setScreenScale(750,1334)
dofile('config')
dofile('tools')
dofile('explore')
dofile('order')
dofile('battle')

function is_main_interface()
	return (isColor(806,701,0x9b6d5b,90) 
		and isColor(1068,701,0x946b5a,90)
		and isColor(1275,685,0xfff5f4,90))
end

function open_order()
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

if results.choose_function == '0' then
	battle()
elseif results.choose_function == '1' then
	explore()
end