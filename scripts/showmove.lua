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

while (true) do
       local fromPointer = 0x006120;
       local toPointer = 0x00621F;

       local movesString = "";
       repeat
              fromPointer = fromPointer + 1
              toPointer = toPointer + 1
              local fromEncoded = memory.readbyteunsigned(fromPointer);
              fromEncoded = AND(fromEncoded, 0x77)
              local fromDecoded = square_table[fromEncoded];
              local toEncoded = memory.readbyteunsigned(toPointer);
              toEncoded = AND(toEncoded, 0x77)
              local toDecoded = square_table[toEncoded];
              if ( not (fromDecoded == nil))
              then
              --       movesString = movesString .. "0x" ..string.format("%x", fromEncoded).. " "
              --else
                     movesString = movesString .. fromDecoded
              else
                     movesString = movesString .. "??"
              end

              if ( not (toDecoded == nil))
              then
                     movesString = movesString .. toDecoded .."\n"
              else
              --       movesString = movesString .. "&&\n"
                     movesString = movesString .. " 0x" ..string.format("%x", toEncoded).."\n"
       end

       until(memory.readbyteunsigned(fromPointer+1) == 0x00)

       gui.text(0,8,(movesString):sub(-80));

       emu.frameadvance();
end
