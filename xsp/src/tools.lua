function logging(str)
  toast(str)
  sysLog(str)
end

function zhengchu(x,y)
  return (x-x%y)/y
end

function tap(x, y)
  touchDown(1, x, y);
  mSleep(time_hold);
  touchUp(1, x, y);
end

function isColor(x,y,c,s)   --x,y为坐标值，c为颜色值，s为相似度，范围0~100。
  local fl,abs = math.floor,math.abs
  s = fl(0xff*(100-s)*0.01)
  local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
  local rr,gg,bb = getColorRGB(x,y)
  if abs(r-rr)<s and abs(g-gg)<s and abs(b-bb)<s then
    return true
  end
  return false
end

function is_color_move(x,y,color,similar,movement)
  return isColor(x-movement,y-movement,color,similar) 
  or isColor(x+movement,y+movement,color,similar)
  or isColor(x,y,color,similar)
  or is_color_horizontal_move(x,y,color,similar,movement)
  or is_color_vertical_move(x,y,color,similar,movement)
end

function is_color_horizontal_move(x,y,color,similar,movement)
  return (isColor(x-movement,y,color,similar) 
    or isColor(x+movement,y,color,similar)
    or isColor(x,y,color,similar))
end

function is_color_vertical_move(x,y,color,similar,movement)
  return (isColor(x,y-movement,color,similar) 
    or isColor(x,y+movement,color,similar)
    or isColor(x,y,color,similar))
end


function print_color(x,y)
  color_r, color_g, color_b = getColorRGB(x,y)
  x = x*width/720
  y = y*height/1280
  sysLog(x..','..y..':'..'r_'..color_r..'g_'..color_g..'b_'..color_b)
end