program Particulas;

uses
  Vcl.Forms,
  uGameForm in '..\..\Source\Templates\uGameForm.pas' {frmCGScreen},
  uGameMain in 'uGameMain.pas' {frmCGScreen1},
  dgParticulas in '..\..\Source\dgParticulas.pas',
  dgVetores in '..\..\Source\dgVetores.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCGScreen1, frmCGScreen1);
  Application.Run;
end.
