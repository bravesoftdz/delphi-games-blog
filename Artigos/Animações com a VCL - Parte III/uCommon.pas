unit uCommon;

interface

type
  TPoint2D = class
  private
    fX: integer;
    fY: integer;
    procedure SetX(const Value: integer);
    procedure SetY(const Value: integer);
  public
    constructor Create(pX:integer=0; pY:integer=0);overload;
  published
    property X : integer read FX write SetX;
    property Y : integer read FY write SetY;
  end;



  TSize = class
  private
    fWidth: integer;
    fHeight: integer;
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
  public
    constructor Create(pWidth : integer = 640; pHeight: integer = 480);
  published
    property Width: integer read FWidth write SetWidth;
    property Height: integer read FHeight write SetHeight;
  end;


implementation

{ TPoint2D }

constructor TPoint2D.Create(pX, pY: integer);
begin
  fX := pX;
  fY := pY;
end;


procedure TPoint2D.SetX(const Value: integer);
begin
  fX := Value;
end;

procedure TPoint2D.SetY(const Value: integer);
begin
  fY := Value;
end;

{ TSize }

constructor TSize.Create(pWidth, pHeight: integer);
begin
  fWidth := pWidth;
  fHeight := pHeight;
end;

procedure TSize.SetHeight(const Value: integer);
begin
  fHeight := Value;
end;

procedure TSize.SetWidth(const Value: integer);
begin
  fWidth := Value;
end;

end.
