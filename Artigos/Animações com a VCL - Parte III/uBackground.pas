unit uBackground;

interface

uses
  uCommon,
  uInterfaces,

  Windows,
  Graphics;

type
  /// <summary>
  ///  Background procedural simples.
  ///  Experimente alterar as constantes do método Draw para criar novos efeitos.
  /// </summary>
  TBackgroung = class(TInterfacedObject, IDrawable)
  private
    fStep: byte;
    fSize: uCommon.TSize;
    fVisible: boolean;
    function GetVisible: boolean;
    function GetRect : TRect;
    procedure SetVisible(const Value: boolean);
  public
    constructor Create(pWidth: integer=640; pHeight:integer=480);
    destructor Free;

    procedure Draw(Canvas:TCanvas);
  published
    {IDrawable}
    property Rect: TRect read GetRect;
    property Visible: boolean read GetVisible write SetVisible;

    {TBackgroung}
    property Size : uCommon.TSize read fSize;
    property Step : byte read fStep write fStep;
  end;


implementation

{ TBackgroung }

constructor TBackgroung.Create;
begin
  fSize := uCommon.TSize.Create(pWidth, pHeight);
  fVisible := True;
end;

procedure TBackgroung.Draw(Canvas: TCanvas);
const
  SquareW    = 40;                    //largura de cada bloco
  SquareH    = 40;                    //altura de cada bloco
  SquaresC   = 640 div SquareW + 1;   //numero de colunas
  SquaresR   = 480 div SquareH + 1;   //numero de linhas
var
  col, row, i : integer;
  r : TRect;
begin
  if fVisible then begin
     for col:=0 to SquaresC-1 do
       for row :=0 to SquaresR-1 do begin
           r.Left   := Col * SquareW;
           r.Top    := Row * SquareH;
           r.Right  := r.Left + SquareW;
           r.Bottom := r.Top + SquareH;

           Canvas.Brush.Color := col * row + Step;
           Canvas.FillRect(r);
      end;
  end;
end;

destructor TBackgroung.Free;
begin
  fSize.Free;
end;

function TBackgroung.GetRect: TRect;
begin
  Result.Top    := 0;
  Result.Left   := 0;
  Result.Right  := fSize.Width;
  Result.Bottom := fSize.Height;
end;

function TBackgroung.GetVisible: boolean;
begin
  Result := fVisible;
end;

procedure TBackgroung.SetVisible(const Value: boolean);
begin
  fVisible := Value;
end;

end.
