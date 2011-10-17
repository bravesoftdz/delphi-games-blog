unit dgCommonTypes;

interface

uses
  OpenGL,
  SysUtils;

type

  TColor4f = record
    Red, Green, Blue, Alpha : single;
  end;

  TPoint2D = class
  private
    fX: single;
    fY: single;
  public
    constructor Create(pX:single=0.0; pY:single=0.0);
    property X : single read fX write fX;
    property Y : single read fY write fY;
  end;



  TSize = class
  private
    fWidth: single;
    fHeight: single;
  public
    constructor Create(pWidth : single = 15.0; pHeight: single = 15.0);
  published
    property Width: single read fWidth write fWidth;
    property Height: single read fHeight write fHeight;
  end;


  TRange = class
    Min, Max: integer;
    constructor Create(Min: integer = 1000; Max: integer = 10000);
  end;


  T2DVector = class
    private
      fx, fy : single;
      function GetTamanho: single;
      function GetAsString : string;
    public
      constructor Create(); overload;
      constructor Create(x, y: single); overload;

      procedure Add(x, y : single); overload;
      procedure Add(v : T2DVector); overload;

      property X : single read fx write fx;
      property Y : single read fy write fy;
      property Magnitude : single read GetTamanho;
      property AsString : string read GetAsString;
  end;


implementation

{ TPoint2D }


constructor TPoint2D.Create(pX, pY: single);
begin
  fX := pX;
  fY := pY;
end;


{ TSize }

constructor TSize.Create(pWidth, pHeight: single);
begin
  fWidth  := pWidth;
  fHeight := pHeight;
end;


{ TVector2D }

constructor T2DVector.Create;
begin
  fx := 0;
  fy := 0;
end;


procedure T2DVector.Add(x, y: single);
begin
  fx := fx + x;
  fy := fy + y;
end;

procedure T2DVector.Add(v: T2DVector);
begin
  fx := fx + v.X;
  fy := fy + v.Y;
end;

constructor T2DVector.Create(x, y: single);
begin
  fx := x;
  fy := y;
end;

function T2DVector.GetAsString: string;
begin
  Result := '[ ' + FormatFloat('#0.0  ', X) + FormatFloat('#0.0 ]', Y);
end;

function T2DVector.GetTamanho: single;
begin
  result := Sqr(fx*fx + fy*fy);
end;


{ TRange }

constructor TRange.Create(Min: integer = 1000; Max: integer = 10000);
begin
  Self.Min := Min;
  Self.Max := Max;
end;

end.
