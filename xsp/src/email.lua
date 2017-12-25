function open_email()
tap(928,95) logging("打开邮箱") mSleep(1000) 
end

function is_email_interface()
return isColor(563,93,0x6c4a31,90) and isColor(693,93,0x6c4a31,90) and isColor(640,95,0xffffff,90) 
end

function is_email_unread()
	return isColor(441,216,0xffeddf,95)
end

function is_email_empty()
return isColor(262,165,0xebe0d8,95) and isColor(238,583,0xe0d0c5,95)
end

function receive_email()
tap(766,653) logging("领取邮件") mSleep(1000)
end

function is_harvest_interface()
 return (isColor(555,190,0xffe2a7,90) and isColor(616,197,0xffe09e,90)
 and isColor(686,201,0xffdf99,90) and isColor(772,185,0xffe3ac,90))
end

function tap_blank_to_close()
tap(510,717) logging("点击空白来关闭界面") mSleep(1000)
end

function close_email()
tap(1089,99) logging("关闭邮箱") mSleep(1000)
end

function clear_email()
open_email()
a= 0
repeat mSleep(1000) a = a+1 until(is_email_interface() or a>2)
	while not is_email_empty() do
	receive_email()
	a = 0
	repeat mSleep(1000) a = a+1 
	until(is_harvest_interface() or a>2)
	is_email_interface()
	a= 0
	repeat tap_blank_to_close() mSleep(1000) a = a+1 
	until(is_email_interface() or a>2)
	if is_email_empty() then logging("邮箱已空") break end
	end
repeat close_email() mSleep(1000) until(is_main_interface())
end

