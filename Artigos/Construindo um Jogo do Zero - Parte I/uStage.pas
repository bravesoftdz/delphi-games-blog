unit uStage;

interface

uses
  dgSprite;

type
  TStage = class
  private
    fBackground: TSprite;
  public
    property Background: TSprite read fBackground write fBackground;
  end;

implementation

end.
