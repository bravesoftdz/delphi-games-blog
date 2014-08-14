unit uGame;

interface

uses
  uPlayer, Graphics, PNGImage, Classes;

type
  THUD = class
  private
    fBGColor: TColor;
    fHeight: integer;
    fScreenBuffer: TBitmap;
    fLabelFont: TFont;
    fTextFont: TFont;
    fHeartImage: TPngImage;
    procedure DrawBG;
    procedure DrawLives;
    procedure DrawText;
  public
    constructor Create(aScreenBuffer: TBitmap);
    destructor Destroy; override;

    procedure Draw;

    property BGColor: TColor read fBGColor write fBGColor;
    property Height: integer read fHeight write fHeight;
  end;

  TStage = class
  private
    fScreenBuffer: TBitmap;
    fGroundTexture: TPngImage;
  public
    constructor Create(aScreenBuffer: TBitmap);
    destructor Destroy; override;

    procedure Draw;
    property GroundTexture: TPngImage read fGroundTexture write fGroundTexture;
  end;



  TGame = class
  private
    fPlayer: TPlayer;
    fScrrenBuffer: TBitmap;
    fHUD: THUD;
    fStage: TStage;
  public
    constructor Create(aScreenBuffer: TBitmap);
    destructor Destroy; override;

    procedure DrawFrame;

    property Player: TPlayer read fPlayer write fPlayer;
    property HUD: THUD read fHUD write fHUD;
    property Stage: TStage read fStage write fStage;
  end;

implementation

{ TGame }

function RGBToColor(r, g, b: byte): TColor; inline;
begin
  result := (r or (g shl 8) or (b shl 16));
end;

constructor TGame.Create(aScreenBuffer: TBitmap);
begin
  fScrrenBuffer := aScreenBuffer;
  fPlayer := TPlayer.Create;
  fHUD    := THUD.Create(aScreenBuffer);
  fStage  := TStage.Create(aScreenBuffer);
end;

destructor TGame.Destroy;
begin
  fPlayer.Free;
  fHUD.Free;
  fStage.Free;
  inherited;
end;

procedure TGame.DrawFrame;
begin
  fStage.Draw;
  fHUD.Draw;
end;

{ THUD }

constructor THUD.Create(aScreenBuffer: TBitmap);
begin
  fBGColor := RGBToColor(96, 65, 39);
  fHeight := 50;
  fScreenBuffer := aScreenBuffer;

  fLabelFont := TFont.Create;
  fLabelFont.Name  := 'Impact';
  fLabelFont.Size  := 22;
  fLabelFont.Color := RGBToColor(142, 99, 71);

  fTextFont  := TFont.Create;
  fTextFont.Name  := 'Impact';
  fTextFont.Size  := 22;
  fTextFont.Color := clWhite;

  fHeartImage := TPngImage.Create;
  fHeartImage.LoadFromResourceName(HInstance, 'IMG_HEART');
end;

destructor THUD.Destroy;
begin
  fLabelFont.Free;
  fTextFont.Free;
  fHeartImage.Free;

  inherited;
 end;

procedure THUD.Draw;
begin
  DrawBG;
  DrawText;
  DrawLives;
end;

procedure THUD.DrawBG;
begin
  fScreenBuffer.Canvas.Brush.Color := fBGColor;
  fScreenBuffer.Canvas.Pen.Style := psClear;
  fScreenBuffer.Canvas.Rectangle(0, fScreenBuffer.Height - self.Height, fScreenBuffer.Width + 1, fScreenBuffer.Height + 1);
  fScreenBuffer.Canvas.Pen.Style := psSolid;
  fScreenBuffer.Canvas.Pen.Color := clBlack;
  fScreenBuffer.Canvas.Pen.Width := 3;
  fScreenBuffer.Canvas.MoveTo(0, fScreenBuffer.Height - fHeight - 2);
  fScreenBuffer.Canvas.LineTo(fScreenBuffer.Width, fScreenBuffer.Canvas.PenPos.Y);
end;

procedure THUD.DrawLives;
var
  y : integer;
begin
  y := fScreenBuffer.Height - fHeight + 8;
  fScreenBuffer.Canvas.Draw(480, y, fHeartImage);
  fScreenBuffer.Canvas.Draw(530, y, fHeartImage);
  fScreenBuffer.Canvas.Draw(580, y, fHeartImage);
end;

procedure THUD.DrawText;
begin
  fScreenBuffer.Canvas.Font := fLabelFont;
  fScreenBuffer.Canvas.TextOut(12, fScreenBuffer.Height - fHeight + 5, 'Tam.');
  fScreenBuffer.Canvas.TextOut(125, fScreenBuffer.Height - fHeight + 5, 'Pontos');
  fScreenBuffer.Canvas.TextOut(400, fScreenBuffer.Height - fHeight + 5, 'Vidas');

  fScreenBuffer.Canvas.Font := fTextFont;
  fScreenBuffer.Canvas.TextOut(80, fScreenBuffer.Height - fHeight + 5, '12');
  fScreenBuffer.Canvas.TextOut(220, fScreenBuffer.Height - fHeight + 5, '000,000,000');
end;

{ TStage }

constructor TStage.Create(aScreenBuffer: TBitmap);
var
  lRStream: TResourceStream;
begin
  fScreenBuffer := aScreenBuffer;
  fGroundTexture:= TPngImage.Create;
  fGroundTexture.LoadFromResourceName(HInstance, 'BG_FASE1');
end;

destructor TStage.Destroy;
begin
  fGroundTexture.Free;
  inherited;
end;

procedure TStage.Draw;
begin
  fScreenBuffer.Canvas.Draw(0, 0, fGroundTexture);
end;

end.
