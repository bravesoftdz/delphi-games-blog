unit uMain;

interface

uses
  uSprite,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fOffScreen : TBitmap;
    procedure EraseBg(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure OnIdle(Sender: TObject; var Done: Boolean);
    procedure ProcessInput;         //2.1
    procedure UpdateAnimation;      //2.2
    procedure DrawToBuffer;         //2.3
    procedure Blit;
    procedure FreeFields;                 //2.4
  public
    { Public declarations }
    Sprite : TSprite;
    OpIncreasing : boolean;
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DrawToBuffer;
var
  Canvas : TCanvas;
  Blendf : TBlendFunction;
begin
  Canvas := fOffScreen.Canvas;
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(fOffScreen.Canvas.ClipRect);

  Blendf.BlendOp    := AC_SRC_OVER;
  Blendf.BlendFlags := 0;
  Blendf.SourceConstantAlpha := Sprite.Opacity;
  Blendf.AlphaFormat := AC_SRC_OVER;

  Windows.AlphaBlend(
     Canvas.Handle,  {manipulador da imagem de destino}
     fOffScreen.Width - Sprite.Width, {coordenada X}
     0,                               {coordenada Y}
     Sprite.Width,                    {largura da área de desenho}
     Sprite.Height,                   {altura da área de desenho}

     Sprite.Canvas.Handle, {manipulador da imagem de origem}
     0,                    {coordenada X}
     0,                    {coordenada Y}
     Sprite.Width,         {largura da imagem de origem}
     Sprite.Height,        {altura da imagem de origem}

     Blendf                 {parâmetros de executação(TBlendFunction)}
     );

  Canvas.TextOut(10, 10, Format('Opacidade : %d', [Sprite.Opacity]));
end;

procedure TForm1.Blit;
begin
  // Copiamos o buffer de vídeo para a tela
  BitBlt(Canvas.Handle, 0, 0, ClientWidth, ClientHeight,
         fOffScreen.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TForm1.FreeFields;
begin
  fOffScreen.Free;
  Sprite.Free;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeFields;
end;


procedure TForm1.EraseBg(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 0;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  ClientWidth   := 800;               // teremos uma tela de 640 x 480 pixels
  ClientHeight  := 600;               //
  fOffScreen := TBitmap.Create;       // Criamos nosso bitmap de buffer
  fOffScreen.PixelFormat := pf24bit;  // iremos trabalhar com cores de 24bit
  fOffScreen.Width  := ClientWidth;   // configura as dimensões do buffer
  fOffScreen.Height := ClientHeight;  // de acordo com as dimensões do formulário

  fOffScreen.Canvas.Font.Color := clGray;
  fOffScreen.Canvas.Font.Size  := 9;

  Sprite := TSprite.Create;
  Sprite.LoadFromResourceName(HInstance, 'IMG01');
  Sprite.Opacity := 1;
  Application.OnIdle := OnIdle;
end;


procedure TForm1.OnIdle(Sender: TObject; var Done: Boolean);
begin
  ProcessInput;
  UpdateAnimation;
  DrawToBuffer;
  Blit;
  Done := False;
end;


procedure TForm1.UpdateAnimation;
begin
  if OpIncreasing then
     Sprite.Opacity := Sprite.Opacity + 1
  else
     Sprite.Opacity := Sprite.Opacity - 1;

  case Sprite.Opacity of
    0   : OpIncreasing := true;
    255 : OpIncreasing := false;
  end;
end;

procedure TForm1.ProcessInput;
begin

end;


end.
