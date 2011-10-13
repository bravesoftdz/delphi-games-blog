unit Vetor;

interface

uses
  Graphics, SysUtils;

type
  TVetor2D = class
    private
      fx, fy : real;
      function GetTamanho: real;
      function GetAsString : string;
    public
      constructor Create(); overload;
      constructor Create(x, y: real); overload;

      procedure Add(x, y : real); overload;
      procedure Add(v : TVetor2D); overload;

      property X : real read fx write fx;
      property Y : real read fy write fy;
      property Magnitude : real read GetTamanho;
      property AsString : string read GetAsString;
  end;
  

implementation

{ TVector2D }

constructor TVetor2D.Create;
begin
  fx := 0;
  fy := 0;
end;


procedure TVetor2D.Add(x, y: real);
begin
  fx := fx + x;
  fy := fy + y;
end;

procedure TVetor2D.Add(v: TVetor2D);
begin
  fx := fx + v.X;
  fy := fy + v.Y;
end;

constructor TVetor2D.Create(x, y: real);
begin
  fx := x;
  fy := y;
end;

function TVetor2D.GetAsString: string;
begin
  Result := '[ ' + FormatFloat('#0.0  ', X) + FormatFloat('#0.0 ]', Y);
end;

function TVetor2D.GetTamanho: real;
begin
  result := Sqr(fx*fx + fy*fy);
end;



end.
