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
       emu.message("x: " .. x .. " dest: " .. destination_pixel);
       
       local keys_table = {};
       
       if(x < destination_pixel - 2)
       then
              keys_table = {left=false, right=true};
       elseif( destination_pixel + 2 < x)
       then
              keys_table = {left=true, right=false};
       else -- cursor is already in the right place
              keys_table = {left=false, right=false};
       end
       joypad.set(1, keys_table);
       
       -- move the cursor horizontally

       
end

while (true) do
       file = "f"
       moveHorizontal(file)
       local y = memory.readbyteunsigned(0x0500);

       -- move the cursor vertically

       -- press A

       -- move the cursor horizaontally
       -- no op for e2e4

       -- move the cursor vertically

       -- press A
       emu.frameadvance();
end

