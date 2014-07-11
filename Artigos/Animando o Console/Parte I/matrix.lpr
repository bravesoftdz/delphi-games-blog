program matrix;

{$APPTYPE CONSOLE}

uses
  windows;
var
  stdOut   : THandle;
  position : COORD;
  attribute: Word;
begin
  randomize;
  stdOut := GetStdHandle(STD_OUTPUT_HANDLE);
  while hi(GetKeyState(VK_ESCAPE)) = 0 do
  begin
    position.X:= short(random(79)+1);
    position.Y:= short(random(23)+1);
    if (Random(10) mod 2 = 0) then
       attribute:= FOREGROUND_GREEN
    else
       attribute:= 10;
    SetConsoleTextAttribute(stdOut, attribute);
    SetConsoleCursorPosition(stdOut, position);
    if (Random(10) mod 2 = 0) then
       write('0')
    else
       write('1');
  end;
end.

