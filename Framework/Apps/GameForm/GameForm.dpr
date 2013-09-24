program GameForm;

uses
  Vcl.Forms,
  uGameForm in '..\..\Source\Templates\uGameForm.pas' {frmCGScreen};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCGScreen, frmCGScreen);
  Application.Run;
end.
