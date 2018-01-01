ret,results=showUI("ui.json");
if ret == 0 then
	lua_exit(); --否则退出脚本
end

battle_times_limit = tonumber(results.battle_times_limit)
if results.cave_number == '' then results.cave_number='1' end
cave_number = tonumber(results.cave_number)
waiting_time = tonumber(results.waiting_time)
food_number = tonumber(results.food_number)
tianfu_choosed = {}
tianfu_choosed[1] = zhengchu(tonumber(results.tianfu_choosed),10)
tianfu_choosed[2] = tonumber(results.tianfu_choosed)%10

team_choosed = {}
for rank = 1,5 do
	team_choosed[rank] = tonumber(string.sub(results.team_choosed,rank,rank))
end

yiji_battle_times_limit = tonumber(results.yiji_battle_times)

if string.len(results.tianfu_choosed) ~= 2 then
dialog("请确认天赋选择是两位数")
end

if string.len(results.team_choosed) ~= 5 then
dialog("请确认队伍编辑是5位数")
end