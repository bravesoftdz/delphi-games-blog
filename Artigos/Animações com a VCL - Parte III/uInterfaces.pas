unit uInterfaces;

interface

uses
  Windows,
  Graphics,
  uCommon;

type
  /// <summary>
  /// Interface para objetos capazes de se mover.
  /// </summary>
  IMoveable = interface ['{009A0CB7-F74F-4633-8D75-408E77C63958}']
    //property Gets
    function GetPosition: TPoint2D;
    function GetSpeed: real;
    function GetMoveLimits: TRect;

    //property Sets
    procedure SetSpeed(Value: real);
    procedure SetMoveLimits(Value: TRect);

    //procedures and functions
    procedure Move(X, Y : integer);
    procedure SetPos(X, Y : integer);

    //properties
    property Position : TPoint2D read GetPosition;
    property Speed : real read GetSpeed write SetSpeed;
    property MoveLimits : TRect read GetMoveLimits write SetMoveLimits;
  end;



  /// <summary>
  ///  Interface para objetos renderizáveis
  /// </summary>
  IDrawable = interface ['{3E41F055-58F6-4990-9C94-AA29FD4D7CF4}']
    //property Gets
    function GetVisible: boolean;
    function GetRect : TRect;

    //property Sets
    procedure SetVisible(const Value: boolean);

    //procedures and functions
    procedure Draw(Canvas:TCanvas);

    //properties
    property Rect: TRect read GetRect;
    property Visible: boolean read GetVisible write SetVisible;
  end;



implementation


end.
