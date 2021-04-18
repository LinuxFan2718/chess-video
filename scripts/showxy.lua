while (true) do
       local x = memory.readbyteunsigned(0x0503);
       local y = memory.readbyteunsigned(0x0500);
       emu.message("x: " .. x .. " y: " .. y);

       emu.frameadvance();
end
