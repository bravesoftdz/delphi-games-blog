program AnimacoesII;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uBall in 'uBall.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
