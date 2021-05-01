emu.speedmode("nothrottle")
-- human player has the white pieces
-- chessmaster AI has the black pieces

-- wait for emulation to start
-- load savestate where human has white pieces

local waiting_for_move_from = 'human'; -- other value 'chessmaster'
local last_human_move = nil;
local last_chessmaster_move = nil;
local tolerance = 0;
local human_move_filename = '../player-move.txt';
local chessmaster_move_filename = '../chessmaster-move.txt';
local square_table = {
  [0x00]=nil,

  [0x70]="a1",
  [0x71]="b1",
  [0x72]="c1",
  [0x73]="d1",
  [0x74]="e1",
  [0x75]="f1",
  [0x76]="g1",
  [0x77]="h1",

  [0x60]="a2",
  [0x61]="b2",
  [0x62]="c2",
  [0x63]="d2",
  [0x64]="e2",
  [0x65]="f2",
  [0x66]="g2",
  [0x67]="h2",

  [0x50]="a3",
  [0x51]="b3",
  [0x52]="c3",
  [0x53]="d3",
  [0x54]="e3",
  [0x55]="f3",
  [0x56]="g3",
  [0x57]="h3",

  [0x40]="a4",
  [0x41]="b4",
  [0x42]="c4",
  [0x43]="d4",
  [0x44]="e4",
  [0x45]="f4",
  [0x46]="g4",
  [0x47]="h4",

  [0x30]="a5",
  [0x31]="b5",
  [0x32]="c5",
  [0x33]="d5",
  [0x34]="e5",
  [0x35]="f5",
  [0x36]="g5",
  [0x37]="h5",

  [0x20]="a6",
  [0x21]="b6",
  [0x22]="c6",
  [0x23]="d6",
  [0x24]="e6",
  [0x25]="f6",
  [0x26]="g6",
  [0x27]="h6",

  [0x10]="a7",
  [0x11]="b7",
  [0x12]="c7",
  [0x13]="d7",
  [0x14]="e7",
  [0x15]="f7",
  [0x16]="g7",
  [0x17]="h7",

  [0x00]="a8",
  [0x01]="b8",
  [0x02]="c8",
  [0x03]="d8",
  [0x04]="e8",
  [0x05]="f8",
  [0x06]="g8",
  [0x07]="h8",
}

function read_file (filename)
  input = io.open(filename, 'r')
  io.input(input)
  move = io.read()
  io.close(input)

  return move
end

function write_file (filename, move)
  file = io.open(filename, 'w+')
  io.output(file)
  io.write(move)
  io.close(file)
end

function latest_move()
  local fromPointer = 0x006120;
  local toPointer = 0x00621F;
  repeat
         fromPointer = fromPointer + 1
         toPointer = toPointer + 1
         local fromEncoded = memory.readbyteunsigned(fromPointer);
         fromEncoded = AND(fromEncoded, 0x77)
         local fromDecoded = square_table[fromEncoded];
         local toEncoded = memory.readbyteunsigned(toPointer);
         toEncoded = AND(toEncoded, 0x77)
         local toDecoded = square_table[toEncoded];
         lastMove = fromDecoded .. toDecoded
  until(memory.readbyteunsigned(fromPointer+1) == 0x00)

  return lastMove
end


function moveHorizontal (file)
  local x = memory.readbyteunsigned(0x0503);
  local files_table = {a=37, b=61, c=85, d=109, e=133, f=157, g=181, h=207}
  local destination_pixel = files_table[file]

  local keys_table = {};
  
  if(x < destination_pixel - tolerance)
  then
         keys_table = {left=false, right=true};
  elseif( destination_pixel + tolerance < x)
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
  
  if(y < destination_pixel - tolerance)
  then
         keys_table = {up=false, down=true};
  elseif( destination_pixel + tolerance < y)
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
  local frames = 10
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

while(true) do
  if (waiting_for_move_from == 'human') then
    -- check for the move in the text file
    human_move = read_file(human_move_filename);
    -- if it's a new move then play it on the board
    if (human_move ~= nil and human_move ~= "" and human_move ~= last_human_move) then
      last_human_move = human_move;
      -- play move
      movePiece(human_move);
      waiting_for_move_from = 'chessmaster';
    end
    
  elseif (waiting_for_move_from == 'chessmaster') then
    -- check for the most recent move in the game move list
    local lastMove = latest_move();
    -- if there's a new move then write it to the text file
    if (lastMove ~= last_human_move) then
      write_file(chessmaster_move_filename, lastMove)
      waiting_for_move_from = 'human';
    end
  end

  emu.frameadvance()
end