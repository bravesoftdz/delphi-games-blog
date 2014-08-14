program Snake;

{$R *.dres}

uses
  Forms,
  uGameForm in '..\..\Framework\Source\Templates\uGameForm.pas' {frmCGScreen},
  uMainForm in 'uMainForm.pas' {frmCGScreen1},
  uPlayer in 'uPlayer.pas',
  uGame in 'uGame.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCGScreen1, frmCGScreen1);
  Application.Run;
end.
