program GLGameForm;

uses
  Forms,
  uGLGameForm in '..\..\Source\Templates\uGLGameForm.pas' {frmGL2DTemplate},
  dgGlUtils in '..\..\Source\dgGlUtils.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
  {$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGL2DTemplate, frmGL2DTemplate);
  Application.Run;
end.
