unit uMainForm;

interface

uses
  uGame,

  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uGameForm, ExtCtrls, StdCtrls;

type
  TfrmCGScreen1 = class(TfrmCGScreen)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fGame : TGame;
  protected
      procedure DrawScene; override;
  public
  end;

var
  frmCGScreen1: TfrmCGScreen1;

implementation

{$R *.dfm}

{ TfrmCGScreen1 }

procedure TfrmCGScreen1.DrawScene;
begin
 //inherited;
 fGame.DrawFrame;
 Caption := 'Snake dt=' + FloatToStr(DeltaTime);
end;

procedure TfrmCGScreen1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fGame.Free;
end;

procedure TfrmCGScreen1.FormCreate(Sender: TObject);
begin
  inherited;
  fGame := TGame.Create(Buffer);
end;

end.
