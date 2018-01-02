for i = 1,string.len('abd') do
print(string.sub('adb',i,i))
end

function string_iter (content)
    local i = 0
    local n = string.len(content)
    return function ()
       i = i + 1
       if i <= n then 
        return string.sub(content,i,i) 
    else
        i = 1
        return string.sub(content,i,i)
        end
    end
end

iter = string_iter('ddoliuern')