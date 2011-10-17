unit uMain;

interface

uses
  dgParticles,

  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uGameForm;


type
  TfrmMain = class(TfrmCGScreen)
  private
    { Private declarations }
  protected
    procedure InitObjects; override;
    procedure FreeObjects; override;
    procedure DrawScene; override;
  public
    { Public declarations }
    Emiter : TParticleEmitter;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ TfrmCGScreen1 }

procedure TfrmMain.DrawScene;
begin
  Emiter.Draw(Canvas);
end;

procedure TfrmMain.FreeObjects;
begin
  inherited;
  FreeAndNil(Emiter);
end;

procedure TfrmMain.InitObjects;
begin
  inherited;
  Emiter := TParticleEmitter.Create;
end;

end.
