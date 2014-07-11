program matrix2;

{$APPTYPE CONSOLE}

uses
  windows;

const
  Black           = 0;
  Green           = 2;
  LightGreen      = 10;
  White           = 15;

  STRIP_COUNT    = 150;
  STRIP_MAX_LEN  = 25;
  STRIP_MIN_LEN  = 6;

type
  TStrip = record
    Position : COORD;
    Length   : byte;
    Delay    : integer;
  end;

var
  hBuffer1, hBuffer2, hBackBuffer   : THandle;
  consoleBounds : TCOORD;
  strips: array[0..STRIP_COUNT] of TStrip;

procedure ConfigConsole;
var
  lCursorInfo    : TConsoleCursorInfo;
  lSecAttributes : TSecurityAttributes;
begin
  SetConsoleTitle('DelphiGames Blog | Matrix Effect - Part 2');
  Write('Getting handlers... ');

  lSecAttributes.nLength:= sizeOf(TSecurityAttributes);
  lSecAttributes.lpSecurityDescriptor := nil;
  lSecAttributes.bInheritHandle := false;

  hBuffer1 := GetStdHandle(STD_OUTPUT_HANDLE);
  {$IFDEF FPC}
  hBuffer2 := CreateConsoleScreenBuffer( GENERIC_WRITE or GENERIC_READ,
                                         FILE_SHARE_READ,
                                         lSecAttributes,
                                         CONSOLE_TEXTMODE_BUFFER, nil);

  {$ELSE}
  hBuffer2 := CreateConsoleScreenBuffer( GENERIC_WRITE or GENERIC_READ,
                                         FILE_SHARE_READ,
                                         @lSecAttributes,
                                         CONSOLE_TEXTMODE_BUFFER, nil);
  {$ENDIF}
  if (hBuffer1 = INVALID_HANDLE_VALUE) or (hBuffer2 = INVALID_HANDLE_VALUE) then
  begin
     WriteLn('ERROR');
     Halt(1);
  end
  else
     begin
       WriteLn('OK!');

       hBackBuffer := hBuffer1;
       lcursorInfo.dwSize   := 1;
       lcursorInfo.bVisible := False;

       SetConsoleCursorInfo(hBuffer1, lcursorInfo);
       SetConsoleCursorInfo(hBuffer2, lcursorInfo);

       consoleBounds.X:= 80;
       consoleBounds.Y:= 25;

       SetConsoleScreenBufferSize(hBuffer1, consoleBounds);
       SetConsoleScreenBufferSize(hBuffer2, consoleBounds);
     end;
end;

procedure Clear;
var
  tc :tcoord;
  nw: DWORD;
  cbi : TConsoleScreenBufferInfo;
begin
  GetConsoleScreenBufferInfo(hBackBuffer, cbi);
  tc.x := 0;
  tc.y := 0;
  FillConsoleOutputAttribute(hBackBuffer, Black,cbi.dwsize.x*cbi.dwsize.y, tc, nw);
  FillConsoleOutputCharacter(hBackBuffer, ' ', cbi.dwsize.x*cbi.dwsize.y, tc, nw);
  SetConsoleCursorPosition(hBackBuffer, tc);
end;

procedure SwapBuffers;
begin
  if hBackBuffer = hBuffer1 then
  begin
    SetConsoleActiveScreenBuffer(hBuffer1);
    hBackBuffer:= hBuffer2;
  end
  else begin
    SetConsoleActiveScreenBuffer(hBuffer2);
    hBackBuffer:= hBuffer1;
  end;
end;

procedure InitStrips;
var
  i: integer;
begin
  for i:=0 to STRIP_COUNT-1 do
  begin
    strips[i].Length      := random(STRIP_MAX_LEN - STRIP_MIN_LEN) + STRIP_MIN_LEN;
    strips[i].Position.y  := 0;
    strips[i].Position.x  := random(consoleBounds.x);
    strips[i].Delay       := random(20);
  end;
end;

procedure UpdateStrips;
var
  i : integer;
begin
  for i:=0 to STRIP_COUNT-1 do
  begin
    if strips[i].Delay > 0 then
       strips[i].Delay := strips[i].Delay -1
    else
       begin
         strips[i].Position.Y := strips[i].Position.Y + 1;
         if ( strips[i].Position.Y - strips[i].Length  > consoleBounds.Y ) then
         begin
            strips[i].Length     := random(STRIP_MAX_LEN - STRIP_MIN_LEN) + STRIP_MIN_LEN;
            strips[i].Position.y := 0;
            strips[i].Position.x := random(consoleBounds.x);
            strips[i].Delay      := random(100);
          end;
       end;
  end;
end;


procedure DrawStrips;
var
  i, j : integer;
  lColor, lCharsWritten: DWORD;
  lChar  : char;
  lPosition: COORD;
begin
  lCharsWritten := 0;
  for i:=0 to STRIP_COUNT-1 do
    begin
      if (strips[i].Delay <= 0) then
      begin
        if (strips[i].Position.Y <= consoleBounds.Y) then
        begin
          lColor:= White;
          lChar := Char(random(255-33)+33);
          WriteConsoleOutputAttribute(hBackBuffer, @lColor, 1, strips[i].Position, lCharsWritten);
          WriteConsoleOutputCharacter(hBackBuffer, @lChar, 1, strips[i].Position, lCharsWritten);
        end;
        for j:=1 to strips[i].Length-1 do
          if (strips[i].Position.Y + j <= consoleBounds.Y) then
          begin
             if (j / strips[i].Length <= 0.35) then
                lColor:= LightGreen
             else
                lColor:= Green;
             lChar := Char(random(255-33)+33);
             lPosition.X:= strips[i].Position.X;
             lPosition.Y:= strips[i].Position.Y - j;
             WriteConsoleOutputAttribute(hBackBuffer, @lColor, 1, lPosition, lCharsWritten);
             WriteConsoleOutputCharacter(hBackBuffer, @lChar, 1, lPosition, lCharsWritten);
          end;
      end;
    end;
end;


begin
  randomize;
  ConfigConsole;
  InitStrips;
  while hi(GetKeyState(VK_ESCAPE)) = 0 do
  begin
    Clear;
    UpdateStrips;
    DrawStrips;
    SwapBuffers;
    //Sleep(10);
  end;
end.

