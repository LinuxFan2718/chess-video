-- human player has the white pieces
-- chessmaster AI has the black pieces

-- wait for emulation to start
-- load savestate where human has white pieces

local waiting_for_move_from = 'human' -- other value 'chessmaster'
local last_human_move = nil
local last_chessmaster_move = nil

while(true) do
  if (waiting_for_move_from == 'human') then
    -- check for the move in the text file
    -- if it's a new move then play it on the board
    waiting_for_move_from = 'chessmaster';
  elseif (waiting_for_move_from == 'chessmaster') then
    -- check for the move in the text file
    -- if there's a new move then write it to the text file
    waiting_for_move_from = 'human';
  end
  emu.frameadvance()
end