unit uGameForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfrmCGScreen = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fScreenBuff   : TBitmap;
    fDrawingScene : boolean;
    fFullScreen   : boolean;
    fOrigResX, fOrigResY : integer;

    fTextH : integer;

    fFramesRendered     : integer;
    fFramesInLastSecond : integer;
    fLastSecondBegining : real;

    fLastFrame : real;
    fShowFPS : boolean;
    fShowResolution : boolean;
    fFrameBeginTime, fFrameEndTime, fFrequency : Int64;
    fDeltaTime : real;

    procedure WMEraseBg(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetResolution(pWidth, pHeight : integer);
    procedure OnIdle(Sender: TObject; var Done: Boolean);
    procedure InitObjects;
    procedure DisposeObjects;
    procedure ClearBuffer;
    procedure StartScene;
    procedure EndScene;
    procedure MainLoop;
    procedure Blit;
    procedure DrawTextFPS;
    procedure DrawTextResolution;
    procedure SetFullScreen(Value : boolean);
    procedure SaveVideoMode;
    procedure RestoreVideoMode;
  public
    { Public declarations }
    procedure SetWindowSize(W, H: integer);
    procedure ShowCursor;
    procedure HideCursor;
    procedure DrawScene; virtual;
    procedure ProcessInput; virtual;
    property  Buffer : TBitmap read fScreenBuff;
  published
    property FPS : integer read fFramesInLastSecond;
    property ShowFPS : boolean read fShowFPS write fShowFPS;
    property ShowResolition : boolean read fShowResolution write fShowResolution;
    property FullScreen : boolean read fFullScreen write SetFullScreen;
  end;

var
  frmCGScreen: TfrmCGScreen;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmCGScreen.ClearBuffer;
begin
  fScreenBuff.Canvas.Brush.Color := Color;
  fScreenBuff.Canvas.Brush.Style := bsSolid;
  fScreenBuff.Canvas.FillRect(ClientRect);
end;

procedure TfrmCGScreen.DisposeObjects;
begin
  FreeAndNil(fScreenBuff);
end;

procedure TfrmCGScreen.DrawTextFPS;
begin
  fScreenBuff.Canvas.Font.Assign(Self.Font);
  fScreenBuff.Canvas.Brush.Style := bsClear;
  fScreenBuff.Canvas.TextOut(0, 0, FormatFloat('FPS: #,000', fFramesInLastSecond));
end;

procedure TfrmCGScreen.DrawScene;
var
  s1, s2 : string;
  c : TColor;
begin
  c := clWhite;
  fScreenBuff.Canvas.Brush.Style := bsClear;
  fScreenBuff.Canvas.Font.Size  := 16;
  fScreenBuff.Canvas.Font.Name  := 'Terminal';
  fScreenBuff.Canvas.Font.Color := c;
  s1 := 'You must override';
  s2 := 'the DrawScene procedure';
  fScreenBuff.Canvas.TextOut(
    ClientWidth div 2 - fScreenBuff.Canvas.TextWidth(s1) div 2,
    ClientHeight div 2 - fTextH ,
    s1);
    fScreenBuff.Canvas.TextOut(
      ClientWidth div 2 - fScreenBuff.Canvas.TextWidth(s2) div 2, +
      Round(ClientHeight div 2 - fTextH  + fTextH *1.5),
      s2);
end;

procedure TfrmCGScreen.DrawTextResolution;
begin
  fScreenBuff.Canvas.Font.Assign(Self.Font);
  fScreenBuff.Canvas.Brush.Style := bsClear;
  fScreenBuff.Canvas.TextOut(0, fScreenBuff.Canvas.TextHeight(' ') * 1, 'Resolução: ' + IntToStr(ClientWidth) + ' X ' + IntToStr(ClientHeight));
end;


procedure TfrmCGScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DisposeObjects;
  ShowCursor;
end;

procedure TfrmCGScreen.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  if not QueryPerformanceFrequency(fFrequency) then
    begin
      MessageDlg('Não foi possível ler a freqüência de operação do seu processador.'#13#10
                +'O programa será finalizado!',
                mtWarning, [mbOk], 0);
      Close;
    end;
  InitObjects;
  SaveVideoMode;
  SetWindowSize(640, 480);
  Application.OnIdle := OnIdle;
end;

procedure TfrmCGScreen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN :
      begin
        if ssAlt in Shift then
           FullScreen := not(FullScreen);
      end;
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmCGScreen.HideCursor;
begin
  Screen.Cursor := crNone;
end;

procedure TfrmCGScreen.InitObjects;
begin
  fScreenBuff := TBitmap.Create;
  fShowFPS := true;
  fShowResolution := true;
  fDrawingScene := true;
  fTextH := fScreenBuff.Canvas.TextHeight('T');

  HideCursor;
  QueryPerformanceCounter(fFrameBeginTime);
  fFrameEndTime := fFrameBeginTime;
  fLastSecondBegining := fFrameBeginTime;
  fFramesInLastSecond := 0;
end;

procedure TfrmCGScreen.MainLoop;
begin
  StartScene;
  DrawScene;
  if fShowFPS then DrawTextFPS;
  if fShowResolution then DrawTextResolution;
  ProcessInput;
  EndScene;
end;

procedure TfrmCGScreen.OnIdle(Sender: TObject; var Done: Boolean);
begin
  MainLoop;
  Blit;
  Done := false;
end;

procedure TfrmCGScreen.ProcessInput;
begin

end;

procedure TfrmCGScreen.RestoreVideoMode;
begin
  SetResolution(fOrigResX, fOrigResY);
  fFullScreen := false;
end;

procedure TfrmCGScreen.SaveVideoMode;
begin
  fOrigResX := Screen.Width;
  fOrigResY := Screen.Height;
end;

procedure TfrmCGScreen.SetFullScreen(Value : boolean);
begin
  if value then
    begin
      Width := ClientWidth;
      Height := ClientHeight;
      FormStyle   := fsStayOnTop;
      BorderStyle := bsNone;
      Left := 0;
      Top := 0;
      SetResolution(Self.ClientWidth, Self.ClientHeight);
    end
  else
    begin
      RestoreVideoMode;
      BorderStyle := bsSingle;
      ClientWidth := Width;
      ClientHeight:= Height;
      Position := poDesktopCenter;
    end;
  fFullScreen := Value;
end;

procedure TfrmCGScreen.SetResolution(pWidth, pHeight: integer);
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
  case i of
    DISP_CHANGE_BADPARAM,
    DISP_CHANGE_BADMODE :
      begin
        MessageDlg('The video mode is not supported or could not de initialized.'#13
                  +'The application will be closed.', mtWarning, [mbOk], 0);
        PostQuitMessage(0);
      end;
  end;
end;

procedure TfrmCGScreen.SetWindowSize(W, H: integer);
begin
  Self.BorderStyle := bsSingle;
  Self.FormStyle := fsNormal;

  Self.ClientWidth  := W;
  Self.ClientHeight := H;

  fScreenBuff.Width  := W;
  fScreenBuff.Height := H;
end;

procedure TfrmCGScreen.ShowCursor;
begin
  Screen.Cursor := crDefault;
end;

procedure TfrmCGScreen.StartScene;
begin
  QueryPerformanceCounter(fFrameBeginTime);
  ClearBuffer;
  fDrawingScene := True;
end;

procedure TfrmCGScreen.EndScene;
begin
  fDrawingScene := false;
  fDeltaTime := ( (fFrameBeginTime - fFrameEndTime) * 1000) / fFrequency;
  QueryPerformanceCounter(fFrameEndTime);

  if ( (fFrameEndTime - fLastSecondBegining ) * 1000 / fFrequency ) > 1000 then
  begin
    fLastSecondBegining := fFrameEndTime;
    fFramesInLastSecond := fFramesRendered;
    fFramesRendered := 0;
  end;
end;

procedure TfrmCGScreen.Blit;
begin
  if not fDrawingScene then
    BitBlt(Canvas.Handle, 0, 0, Self.Width, Self.Height, fScreenBuff.Canvas.Handle, 0, 0, cmSrcCopy);
  inc(fFramesRendered);
end;


procedure TfrmCGScreen.WMEraseBg(var Msg: TWMEraseBkgnd);
begin
  //Bloqueia o redesenho do fundo do formulário
  //Block's background redrawing
  Msg.Result := 0;
end;

end.
