-- script that moves chess pieces
-- input is a string with source square and destination square
-- e.g. "e2e4"
-- output is controlling the gamepad to pick up and move the piece

while (true) do
       local x = memory.readbyteunsigned(0x0503);
       local y = memory.readbyteunsigned(0x0500);
       emu.message("x: " .. x .. " y: " .. y);
       emu.frameadvance();
end