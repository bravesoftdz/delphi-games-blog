unit dgParticles;

interface

uses
  dgVetors,
  Windows;

type
  TParticle = record
    Tamanho    : Byte;
    Posicao    : TVetor2D;
    Velocidade : TVetor2D;
    Delay      : Word;
    Alive      : boolean;
    LastDie    : Cardinal;
    LifeTime   : Cardinal;
  end;


  //Emissor de partículas
  TParticleEmitter = class
  private
    fBoundary : TRect;
  public
    property Boundary: TRect read fBoundary write fBoundary;
  end;

implementation

end.
