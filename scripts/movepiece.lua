-- script that moves chess pieces
-- input is a string with source square and destination square
-- e.g. "e2e4"
-- output is controlling the gamepad to pick up and move the piece

-- pick up the piece on e2, then drop it on e4
-- local keys_table = {up=true, down=false, left=false, right=false, A=false, B=false, start=false, select=false};
       
function moveHorizontal (file)
       local x = memory.readbyteunsigned(0x0503);
       local files_table = {a=37, b=61, c=85, d=109, e=133, f=157, g=181, h=207}
       local destination_pixel = files_table[file]

       local keys_table = {};
       
       if(x < destination_pixel - 2)
       then
              keys_table = {left=false, right=true};
       elseif( destination_pixel + 2 < x)
       then
              keys_table = {left=true, right=false};
       else -- cursor is already in the right place horizontally
              keys_table = {left=false, right=false};
       end
       return keys_table
end

function moveVertical (rank)
       local y = memory.readbyteunsigned(0x0500);
       local ranks_array = { 196, 172, 150, 124, 102, 78, 54, 28 }
       local destination_pixel = ranks_array[rank]

       local keys_table = {};
       
       if(y < destination_pixel - 2)
       then
              keys_table = {up=false, down=true};
       elseif( destination_pixel + 2 < y)
       then
              keys_table = {up=true, down=false};
       else -- cursor is already in the right place vertically
              keys_table = {up=false, down=false};
       end
       return keys_table
end

local function split(str)
       if #str>0 then return str:sub(1,1),split(str:sub(2)) end
end

function moveCursor (square)
       local moving = true
       while (moving) do
              file, rank_string = split(square)
              rank = tonumber(rank_string)
              keys_table = moveHorizontal(file)
              vertical_keys_table = moveVertical(rank)

              moving = false
              for k,v in pairs(vertical_keys_table) do
                     keys_table[k] = v
              end

              for k,v in pairs(keys_table) do
                     moving = moving or v
              end

              joypad.set(1, keys_table);
              emu.frameadvance();

       end
end

function justPlay ()
       while (true) do
              emu.frameadvance();
       end
end

function pressAOnce ()
       local aDown = {["A"] = true};
       local aUp = {["A"] = false};
       local frames = 3
       for i = 1,frames,1
       do
              joypad.set(1, aDown);
              emu.frameadvance();
       end
       for i = 1,frames,1
       do 
              emu.frameadvance();
       end
       -- adding this loop makes this work
       -- for k,v in pairs(joypad.get(1)) do
       --        local throwaway = v
       -- end
       -- removing it makes it not work
       
       for i = 1,frames,1
       do
              joypad.set(1, aUp);
              emu.frameadvance();
       end
       for i = 1,frames,1
       do 
              emu.frameadvance();
       end
end

function movePiece(uci_move)
       start_square = uci_move:sub(0, 2)
       destination_square = uci_move:sub(3, 4)

       moveCursor(start_square);
       pressAOnce();
       moveCursor(destination_square);
       pressAOnce();
end

movePiece("a8a4");
--movePiece("c3b1");
--justPlay();

