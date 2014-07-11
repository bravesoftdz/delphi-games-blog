unit uMain;

interface

uses
  uBall,
  uBackground,

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
    procedure Blit;                 //2.4
  public
    { Public declarations }
    Ball : TBall;
    BackGnd : TBackgroung;
  end;

  
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DrawToBuffer;
var
  Canvas : TCanvas;
begin
  Canvas := fOffScreen.Canvas;

  // Primeiro, limpamos o buffer com um fundo preto...
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(fOffScreen.Canvas.ClipRect);

  //Desenhamos o fundo..
  BackGnd.Draw(Canvas);

  //Agora desenhamos a bola
  Ball.Draw(Canvas);
end;
    
procedure TForm1.Blit;
begin
  // Copiamos o buffer de vídeo para a tela
  BitBlt(Canvas.Handle, 0, 0, ClientWidth, ClientHeight,
         fOffScreen.Canvas.Handle, 0, 0, SRCCOPY);
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fOffScreen.Free;
  BackGnd.Free;
  Ball.Free;
end;


procedure TForm1.EraseBg(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 0;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  ClientWidth   := 640;               // teremos uma tela de 640 x 480 pixels
  ClientHeight  := 480;               //
  fOffScreen := TBitmap.Create;       // Criamos nosso bitmap de buffer
  fOffScreen.PixelFormat := pf24bit;  // iremos trabalhar com cores de 24bit
  fOffScreen.Width  := ClientWidth;   // configura as dimensões do buffer
  fOffScreen.Height := ClientHeight;  // de acordo com as dimensões do formulário

  Ball := TBall.Create;
  Ball.SetPos(ClientWidth div 2, ClientHeight div 2);
  Ball.Color := clWhite;
  Ball.Diameter := 20;                // 20 pixels de diâmetro
  Ball.MoveLimits := ClientRect;      // Impede que a bola seja movida para
                                      // fora da tela

  BackGnd := TBackgroung.Create(Self.ClientWidth, Self.ClientHeight);

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
  BackGnd.Step := BackGnd.Step + 1;
end;

procedure TForm1.ProcessInput;
begin
  if GetKeyState(VK_UP)<0 then
     Ball.Move(0,-1);

  if GetKeyState(VK_DOWN)<0 then
     Ball.Move(0, 1);

  if GetKeyState(VK_LEFT)<0 then
     Ball.Move(-1, 0);

  if GetKeyState(VK_RIGHT)<0 then
     Ball.Move(1, 0);

  if GetKeyState(VK_F2) <0 then
     Ball.Speed := Ball.Speed - 0.1;

  if GetKeyState(VK_F3) <0 then
     Ball.Speed := Ball.Speed + 0.1;
end;


end.
