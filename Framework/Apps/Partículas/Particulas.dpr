program Particulas;

uses
  Forms,
  uGameForm in '..\..\Source\Templates\uGameForm.pas' {frmCGScreen},
  uMain in 'uMain.pas' {frmMain},
  dgParticles in '..\..\Source\dgParticles.pas',
  dgCommonTypes in '..\..\Source\dgCommonTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
