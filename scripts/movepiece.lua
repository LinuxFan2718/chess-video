-- script that moves chess pieces
-- input is a string with source square and destination square
-- e.g. "e2e4"
-- output is controlling the gamepad to pick up and move the piece

-- pick up the piece on e2, then drop it on e4
-- local keys_table = {up=true, down=false, left=false, right=false, A=false, B=false, start=false, select=false};
       
function e2e4 ()
       local x = memory.readbyteunsigned(0x0503);
       local y = memory.readbyteunsigned(0x0500);
       local keys_table = {};
       
       if(x < 131)
       then
              keys_table = {left=false, right=true};
       elseif(137 < x)
       then
              keys_table = {left=true, right=false};
       else -- cursor is already in the right place
              keys_table = {left=false, right=false};
       end
       joypad.set(1, keys_table);
       
       -- move the cursor horizontally

       -- move the cursor vertically

       -- press A

       -- move the cursor horizaontally
       -- no op for e2e4

       -- move the cursor vertically

       -- press A
       emu.frameadvance();
end

while (true) do
       e2e4()
end

