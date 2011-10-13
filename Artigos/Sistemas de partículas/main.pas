unit main;

interface

uses
  Vetor,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList;

const
  NumParticulas = 2000;

type
  TParticula = record
    Tamanho    : Byte;
    Posicao    : TVetor2D;
    Velocidade : TVetor2D;
    Delay      : Word;
    Alive      : boolean;
    LastDie    : Cardinal;
    LifeTime   : Cardinal;
  end;


type
  TForm2 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    img: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    fImgBG : TBitmap;
    procedure Clear;
    procedure Blit;
    procedure DrawVariables;
    procedure InitParticulas;
    procedure InitParticula(index : integer);
    procedure DrawParticulas;
    procedure ProcessaParticulas;
    procedure KillParticulas;

    procedure WMEraseBg(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure ChangeSetFormToFullScreen(pWidth, pHeight : integer);
  public
    { Public declarations }
    Gravidade: TVetor2D;
    Vento    : TVetor2D;
    Emissor  : TPoint;
    BgColor  : TColor;
    particulas : array[0..NumParticulas] of TParticula;
    MouseHolding : Boolean;

    procedure ChangeToFullSreen(pWidth, pHeight : integer);
    procedure RestoreOldDisplaySettings;
  end;



var
  Form2: TForm2;


implementation



{$R *.dfm}

procedure TForm2.Blit;
begin
  BitBlt(PaintBox1.Canvas.Handle, 0, 0, fImgBG.Width, fImgBG.Height,
         fImgBG.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TForm2.DrawVariables;
var
  tw : integer;
begin
  tw :=  fImgBG.Canvas.TextHeight('TESTE');

  fImgBG.Canvas.Font.Style := [];
  fImgBG.Canvas.TextOut(3, 0, 'Gravidade: ' + Gravidade.AsString + '  Vento : ' + Vento.AsString);

  fImgBG.Canvas.TextOut(3, tw, FormatFloat('Partículas : ###,##0', NumParticulas));

  fImgBG.Canvas.TextOut(3, 2*tw, 'Use o mouse para mudar a posição do emissor.');
  fImgBG.Canvas.TextOut(3, 3*tw, 'Tecle + e - para alterar a gravidade.');
  fImgBG.Canvas.TextOut(3, 4*tw, 'Use as setas para controlar o vento.');
  fImgBG.Canvas.TextOut(3, 5*tw, 'Pressione "F" para tela cheia e "ESC" para sair.');
end;

procedure TForm2.ChangeSetFormToFullScreen(pWidth, pHeight: integer);
begin
  Self.Width  := pWidth;
  Self.Height := pHeight;
  Self.BorderStyle := bsNone;
  Self.Left := 0;
  Self.Top := 0;
  Self.FormStyle := fsStayOnTop;
  Self.Color := clBackground;
end;

procedure TForm2.ChangeToFullSreen(pWidth, pHeight: integer);
var
  dmSettings : DEVMODE;
  i : integer;
begin
  if not(EnumDisplaySettings(nil, 0, dmSettings)) then
    begin
      MessageBox(self.Handle, 'Could Not Enum Display Settings', 'Error', MB_OK);
      PostQuitMessage(0);
    end;

  dmSettings.dmPelsWidth  := pWidth;
  dmSettings.dmPelsHeight := pHeight;
  dmSettings.dmFields     := DM_PELSWIDTH or DM_PELSHEIGHT;

  i := Windows.ChangeDisplaySettings(dmSettings, CDS_FULLSCREEN);
  if not(i=DISP_CHANGE_SUCCESSFUL) then
    begin
      MessageBox(NULL, 'Display Mode Not Compatible', 'Error', MB_OK);
      PostQuitMessage(0);
    end
  else
    ChangeSetFormToFullScreen(pWidth, pHeight);
end;

procedure TForm2.Clear;
begin
  fImgBG.Canvas.Brush.Color := BgColor;
  fImgBG.Canvas.FillRect(fImgBG.Canvas.ClipRect);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RestoreOldDisplaySettings;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  fImgBG := TBitmap.Create;
  fImgBG.PixelFormat := pf24bit;
  fImgBG.Width  := 640;
  fImgBG.Height := 480;
  fImgBG.Canvas.Font.Name := 'Courrier New';
  fImgBG.Canvas.Font.Size := 8;
  fImgBG.Canvas.Font.Color := clSilver;
  BgColor := clBlack;

  Gravidade := TVetor2D.Create(0,1);
  Vento := TVetor2D.Create(0.0, 0.0);

  Emissor.X := 320;
  Emissor.Y := 400;
  MouseHolding:= false;

  KillParticulas;
  InitParticulas;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : Close;
    VK_DOWN   : Vento.Y := Vento.Y + 0.1;
    VK_UP     : Vento.Y := Vento.Y - 0.1;
    VK_LEFT   : Vento.X := Vento.X - 0.1;
    VK_RIGHT  : Vento.X := Vento.X + 0.1;
  end;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key  of
    '-' : Gravidade.Y := Gravidade.Y -0.1;
    '+' : Gravidade.Y := Gravidade.Y +0.1;
    'f', 'F': ChangeToFullSreen(640, 480);
    'p', 'P': Timer1.Enabled := not (Timer1.Enabled);
  end;
end;

procedure TForm2.InitParticula(index: integer);
begin
  Randomize;
  if Assigned(particulas[index].Posicao) then
     particulas[index].Posicao.Free;
  if Assigned(particulas[index].Velocidade) then
     particulas[index].Velocidade.Free;

  particulas[index].Posicao     := TVetor2D.Create(Emissor.X,  Emissor.Y);
  particulas[index].Tamanho     := Random(25)+14;
  particulas[index].Velocidade  := TVetor2D.Create(Random(10)-5 , -(Random(40)+20));
  particulas[index].Delay       := Random(5000); //de 0 a 2 segundos de delay
  particulas[index].LifeTime    := Random(3000)+500;
  particulas[index].LastDie     := GetTickCount;
  particulas[index].Alive       := False;
end;

procedure TForm2.InitParticulas;
var
  i : integer;
begin
  for i:=0 to NumParticulas-1 do
    InitParticula(i);
end;

procedure TForm2.KillParticulas;
var
  i: integer;
begin
  for i:=0 to NumParticulas-1 do
    particulas[i].Alive := false;
end;

procedure TForm2.ProcessaParticulas;
var
  i: integer;
  t: Cardinal;
begin
  t := GetTickCount;
  for i:=0 to NumParticulas-1 do
    begin
      if particulas[i].Alive then
        begin
          particulas[i].Velocidade.Add(Gravidade);
          particulas[i].Velocidade.Add(Vento);
          particulas[i].Posicao.Add(particulas[i].Velocidade);
          particulas[i].Alive := (t-particulas[i].LastDie) <= particulas[i].Delay;
        end
      else
        begin
           if((particulas[i].LastDie-t) >= particulas[i].Delay) then
             begin
               InitParticula(i);
               particulas[i].Alive := true;
             end;
        end;
    end;
end;

procedure TForm2.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Emissor.X := X;
  Emissor.Y := Y;
  MouseHolding := True;
end;

procedure TForm2.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if MouseHolding then
    begin
      Emissor.X := X;
      Emissor.Y := Y;
    end;
end;

procedure TForm2.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseHolding := false;
end;

procedure TForm2.RestoreOldDisplaySettings;
var
  dmSettings : DEVMODE;
begin
  ChangeDisplaySettings(dmSettings, 0);
end;

procedure TForm2.DrawParticulas;
var
  x1, y1, i : integer;
begin
  fImgBG.Canvas.Pen.Width := 0;
  for i:=0 to NumParticulas-1 do
    if particulas[i].Alive then
    begin
      x1 := Round(particulas[i].Posicao.X - particulas[i].Tamanho / 2);
      y1 := Round(particulas[i].Posicao.Y - particulas[i].Tamanho / 2);
      StretchBlt(fImgBG.Canvas.Handle, x1, y1, particulas[i].Tamanho, particulas[i].Tamanho,
                img.Picture.Bitmap.Canvas.Handle, 0, 0, 16, 16, SRCPAINT);
    end;
end;


procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Clear;
  DrawVariables;
  ProcessaParticulas;
  DrawParticulas;
  Blit;
end;

procedure TForm2.WMEraseBg(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 0;
end;

end.
