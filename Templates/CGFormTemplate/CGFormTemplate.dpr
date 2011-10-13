program CGFormTemplate;

uses
  Forms,
  uScreenForm in 'uScreenForm.pas' {frmCGScreen};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCGScreen, frmCGScreen);
  Application.Run;
end.
