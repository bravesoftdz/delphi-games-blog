unit uSprite;

interface

uses
  Graphics;

type
  TSprite = class(TBitmap)
  private
    FOpacity: byte;
    procedure SetOpacity(const Value: byte);
  published
     property Opacity: byte read FOpacity write SetOpacity;
  end;

implementation

{ TSprite }

procedure TSprite.SetOpacity(const Value: byte);
begin
  FOpacity := Value;
end;

end.
