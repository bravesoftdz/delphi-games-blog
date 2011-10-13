program Particulas;

uses
  Forms,
  main in 'main.pas' {Form2},
  Vetor in 'Vetor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
