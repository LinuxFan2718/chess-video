local pieces_table = {
  [0x00] = ' ',

  [0x10] = 'p',
  [0x11] = 'k',
  [0x12] = 'n',
  [0x13] = 'r',
  [0x14] = 'b',
  [0x15] = 'q',

  [0x20] = 'P',
  [0x21] = 'K',
  [0x22] = 'N',
  [0x23] = 'R',
  [0x24] = 'B',
  [0x25] = 'Q'
}

while(true) do
  local board = "";
  local startPointer = 0x001100;
  for i = 1,8,1
  do
    for j = 1,7,1
    do
      local encoded = memory.readbyteunsigned(startPointer + j);
      local decoded = pieces_table[encoded];
      board = board .. decoded;
    end
    startPointer = startPointer + 0x10;
    board = board .. "\n"
  end
  gui.text(0,8,(board):sub(-160));

  emu.frameadvance();
end