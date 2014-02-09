unit uPlayer;

interface

uses
  dgSprite;

  type TPlayer = class
  private
    fScore: word;
    fLives: byte;
  public
    property Score: word read fScore write fScore;
    property Lives: byte read fLives write fLives;
  end;



implementation

end.
