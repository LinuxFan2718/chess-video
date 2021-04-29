local moves_table = {
       [0x00]="null",
       [0x63]="d2d4"}

while (true) do
       local move1encoded = memory.readbyteunsigned(0x006121);
       local move1decoded = moves_table[move1encoded]
       emu.message(move1decoded);

       emu.frameadvance();
end
