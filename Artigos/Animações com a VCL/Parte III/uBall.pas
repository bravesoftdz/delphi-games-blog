unit uBall;

interface

uses
  Windows,
  Graphics,
  uCommon,
  uInterfaces;

type
  TBall = class(TInterfacedObject, IMoveable, IDrawable)
  private
    fColor : TColor;
    fPosition: TPoint2D;
    fSpeed: real;
    fMoveLimits: TRect;
    fDiameter: integer;
    fVisible: boolean;

    function GetPosition: TPoint2D;
    function GetSpeed: real;
    function GetMoveLimits: TRect;
    function GetRect: TRect;
    function GetVisible: boolean;

    procedure SetSpeed(Value: real);
    procedure SetMoveLimits(Value: TRect);
    procedure SetVisible(const Value: boolean);

  public
    constructor Create;
    destructor Free;

    procedure Move(X, Y : integer);
    procedure SetPos(X, Y : integer);
    procedure Draw(Canvas:TCanvas);

  published
    {IMoveable}
    property Position : TPoint2D read GetPosition;
    property Speed : real read GetSpeed write SetSpeed;
    property MoveLimits : TRect read GetMoveLimits write SetMoveLimits;

    {IDrawable}
    property Rect: TRect read GetRect;
    property Visible: boolean read GetVisible write SetVisible;

    {TBall}
    property Color : TColor read fColor write fColor;
    property Diameter : integer read fDiameter write fDiameter;
  end;



implementation


{ TBall }

constructor TBall.Create;
begin
  fColor := clWhite;
  fSpeed := 0.8;
  fDiameter := 20;
  fPosition := TPoint2D.Create(0, 0);
  fVisible := True;
end;

procedure TBall.Draw(Canvas: TCanvas);
var
  rB : TBrushRecall;
  rP : TPenRecall;
begin
  if fVisible then begin
    rB := TBrushRecall.Create(Canvas.Brush);
    rP := TPenRecall.Create(Canvas.Pen);

    Canvas.Pen.Width := 0;
    Canvas.Brush.Color := FColor;
    Canvas.Ellipse(GetRect);

    rB.Free;
    rP.Free;
  end;
end;

destructor TBall.Free;
begin
  fPosition.Free;
end;

function TBall.GetMoveLimits: TRect;
begin
  Result := fMoveLimits;
end;

function TBall.GetPosition: TPoint2D;
begin
  Result := fPosition;
end;

function TBall.GetRect: TRect;
var
  r : integer;
begin
  r := fDiameter div 2;
  Result.Top    := Position.Y - r;
  Result.Left   := Position.X - r;
  Result.Right  := Result.Left + fDiameter;
  Result.Bottom := Result.Top + fDiameter;
end;

function TBall.GetSpeed: real;
begin
  Result := fSpeed;
end;

function TBall.GetVisible: boolean;
begin
  Result := fVisible;
end;

procedure TBall.Move(X, Y: integer);
var
  r : integer;
begin
  Position.X := Position.X + Round(X * Speed);
  Position.Y := Position.Y + Round(Y * Speed);

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

procedure TBall.SetMoveLimits(Value: TRect);
begin
  fMoveLimits := Value;
end;

procedure TBall.SetPos(X, Y: integer);
begin
  Position.X := X;
  Position.Y := Y;
end;

procedure TBall.SetSpeed(Value: real);
begin
  fSpeed := Value;
end;

procedure TBall.SetVisible(const Value: boolean);
begin
  fVisible := Value;
end;

end.
