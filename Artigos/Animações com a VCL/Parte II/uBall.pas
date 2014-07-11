unit uBall;

interface

uses
  Windows,
  Graphics;

type
  TDrawable = class
  private
    FPosition: TPoint;
    FSpeed: real;
    FMoveLimits: TRect;
    procedure SetSpeed(const Value: real);
    procedure SetMoveLimits(const Value: TRect);
  public
    function GetRect : TRect; virtual; abstract;
    procedure Draw(Canvas:TCanvas); virtual; abstract;
    procedure Move(X, Y : integer); virtual;
    procedure SetPos(X, Y : integer);
    property Position : TPoint read FPosition;
    property Speed : real read FSpeed write SetSpeed;
    property MoveLimits : TRect read FMoveLimits write SetMoveLimits;
  end;


  TBall = class(TDrawable)
  private
    FColor: TColor;
    FDiameter: integer;
    procedure SetColor(const Value: TColor);
    procedure SetDiameter(const Value: integer);
  public
    constructor Create;
    function GetRect : TRect; override;
    procedure Move(X, Y : integer); override;
    procedure Draw(Canvas:TCanvas); override;
    property Diameter : integer read FDiameter write SetDiameter;
    property Color : TColor read FColor write SetColor;
  end;

implementation

{ TBall }

constructor TBall.Create;
begin
  FSpeed := 0.8;
end;

procedure TBall.Draw(Canvas: TCanvas);
var
  rB : TBrushRecall;
  rP : TPenRecall;
begin
  rB := TBrushRecall.Create(Canvas.Brush);
  rP := TPenRecall.Create(Canvas.Pen);

  Canvas.Pen.Width := 0;
  Canvas.Brush.Color := FColor;
  Canvas.Ellipse(GetRect);

  rB.Free;
  rP.Free;
end;

function TBall.GetRect: TRect;
var
  r : integer;
begin
  r := FDiameter div 2;
  Result.Top    := FPosition.Y - r;
  Result.Left   := FPosition.X - r;
  Result.Right  := Result.Left + FDiameter;
  Result.Bottom := Result.Top + FDiameter;
end;

procedure TBall.Move(X, Y: integer);
var
  r : integer;
begin
  FPosition.X := FPosition.X + Round(X * FSpeed);
  FPosition.Y := FPosition.Y + Round(Y * FSpeed);

  r := FDiameter div 2;
  if FPosition.X > FMoveLimits.Right - r then
     FPosition.X := FMoveLimits.Right - r;
  if FPosition.X < FMoveLimits.Left + r then
     FPosition.X := FMoveLimits.Left + r;

  if FPosition.Y > FMoveLimits.Bottom - r then
     FPosition.Y := FMoveLimits.Bottom - r;
  if FPosition.Y < FMoveLimits.Top + r then
     FPosition.Y := FMoveLimits.Top + r;
end;

procedure TBall.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TBall.SetDiameter(const Value: integer);
begin
  FDiameter := Value;
end;



{ TDrawable }

procedure TDrawable.Move(X, Y: integer);
begin
  FPosition.X := FPosition.X + Round(X * FSpeed);
  FPosition.Y := FPosition.Y + Round(Y * FSpeed);
end;

procedure TDrawable.SetMoveLimits(const Value: TRect);
begin
  FMoveLimits := Value;
end;

procedure TDrawable.SetPos(X, Y: integer);
begin
  FPosition.X := FPosition.X + X;
  FPosition.Y := FPosition.Y + Y;
end;

procedure TDrawable.SetSpeed(const Value: real);
begin
  FSpeed := Value;
end;

end.
