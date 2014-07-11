program GLGameForm;

uses
  Forms,
  uGLGameForm in '..\..\Source\Templates\uGLGameForm.pas' {frmGL2DTemplate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGL2DTemplate, frmGL2DTemplate);
  Application.Run;
end.
