emu.print("starting new game: opponent plays the white pieces");
local slot = 1

function create()
  local savestate_object = savestate.object(slot)
  savestate.save(savestate_object)
  savestate.persist(savestate_object)

  return savestate_object
end

function start_new_game()
  local savestate_object = savestate.object(slot)
  savestate.load(savestate_object)
end

--create()
start_new_game()