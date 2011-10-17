program GLParticles;

uses
  Forms,
  uGLGameForm in '..\..\Source\Templates\uGLGameForm.pas' {frmGL2DTemplate},
  main in 'main.pas' {frmMain},
  dgCommonTypes in '..\..\Source\dgCommonTypes.pas',
  dgParticles in '..\..\Source\dgParticles.pas' {$R *.res},
  dlgEmitterEditor in 'dlgEmitterEditor.pas' {EmitterEditor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
