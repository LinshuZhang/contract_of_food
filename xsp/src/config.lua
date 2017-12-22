ret,results=showUI("ui.json");
if ret == 0 then
	lua_exit(); --否则退出脚本
end

battle_times_limit = tonumber(results.battle_times_limit)
if results.cave_number == '' then results.cave_number='1' end
cave_number = tonumber(results.cave_number)