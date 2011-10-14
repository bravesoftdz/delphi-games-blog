unit dgParticles;

interface

uses
  dgCommonTypes,
  Graphics,
  OpenGL;

type
  TParticleEmitter = class;

  PParticle = ^TParticle;
  TParticle = class
  public
    Position   : T2DVector;
    Size       : TSize;
    Speed      : T2DVector;
    Angle      : Single;
    Delay      : Word;
    Alive      : boolean;
    LastDie    : Cardinal;
    LifeTime   : Cardinal;
    constructor Create;
  end;

  PParticleNode = ^TParticleNode;
  TParticleNode = record
    Particle : TParticle;
    Next     : PParticleNode;
  end;


  //Emissor de partículas
  TParticleEmitter = class
  private
    const
      BOUNDARY_LINE_WIDTH = 1;
      CENTER_POINT_SIZE = 2;
    var
      fParticleListNode : PParticleNode;
      fAngle     : single;
      fImpulse   : single;
      fWidth     : integer;
      fHeight    : integer;
      fCenter    : TPoint2D;
      fTexture   : TBitmap;
      fCount     : integer;
      fGravity   : T2DVector;
      fWind      : T2DVector;
      fVisibleBoundary : boolean;
  protected
    procedure DrawBoundaries;
    procedure SetCount(Value: integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Draw;

    property Center       : TPoint2D read fCenter write fCenter;
    property Angle        : Single read fAngle write fAngle;
    property Impulse      : Single read fImpulse write fImpulse;

    property Texture      : TBitmap read fTexture write fTexture;
    property Count : integer read fCount write SetCount;
    property Width : integer read fWidth write fWidth;
    property Height: integer read fHeight write fHeight;

    property VisibleBoundary: boolean read fVisibleBoundary write fVisibleBoundary;

    property Gravity : T2DVector read fGravity write fGravity;
    property Wind    : T2DVector read fWind write fWind;
  end;

implementation

{ TParticleEmitter }

constructor TParticleEmitter.Create;
begin
  fParticleListNode := nil;
  fAngle     := 0;
  fImpulse   := 10;
  fCenter    := TPoint2D.Create(200, 200);
  fWidth     := 300;
  fHeight    := 50;
  fCount  := 100;
  fGravity   := T2DVector.Create;
  fWind      := T2DVector.Create;
  VisibleBoundary := true;
end;

destructor TParticleEmitter.Destroy;
begin
  fCenter.Free;
  fGravity.Free;
  fWind.Free;

end;

procedure TParticleEmitter.Draw;
var
  lParticle : TParticle;
  HalfH, HalfW : single;
begin
  if fVisibleBoundary then DrawBoundaries;
  while not(fParticleListNode = nil) do
  begin
    lParticle := fParticleListNode^.Particle;
    if lParticle.Alive then
      begin
        HalfH  := lParticle.Size.Height / 2;
        HalfW  := lParticle.Size.Width / 2;
        glColor3f(0,0,1);
        glBegin(GL_QUADS);
           glLoadIdentity;
           glTranslatef(lParticle.Position.X, lParticle.Position.Y, 0);
           glRotatef(lParticle.Angle, 0, 0, 1);
           glTranslatef(-lParticle.Position.X, -lParticle.Position.Y, 0);

           glVertex2f(lParticle.Position.X - HalfW, lParticle.Position.Y - HalfH);
           glVertex2f(lParticle.Position.X - HalfW, lParticle.Position.Y + HalfH);
           glVertex2f(lParticle.Position.X + HalfW, lParticle.Position.Y + HalfH);
           glVertex2f(lParticle.Position.X + HalfW, lParticle.Position.Y - HalfH);
        glEnd;
    end;
    fParticleListNode := fParticleListNode^.Next;
  end;
end;

procedure TParticleEmitter.DrawBoundaries;
var
  HalfH, HalfW : single;
begin
  HalfH := fHeight shr 1;
  HalfW := fWidth shr 1;

  glColor3f(1, 0, 0);
  glLineWidth(BOUNDARY_LINE_WIDTH);
  glPushMatrix;
  glLoadIdentity;

  glTranslatef(fCenter.X, fCenter.Y, 0);
  glRotatef(fAngle, 0, 0, 1);
  glTranslatef(-fCenter.X, -fCenter.Y, 0);

  glBegin(GL_LINE_LOOP); {Boudaries}
    glVertex3f((fCenter.X - HalfW), (fCenter.Y - HalfH), 0);
    glVertex3f((fCenter.X - HalfW), (fCenter.Y + HalfH), 0);
    glVertex3f((fCenter.X + HalfW), (fCenter.Y + HalfH), 0);
    glVertex3f((fCenter.X + HalfW), (fCenter.Y - HalfH), 0);
  glEnd;

  glPointSize(CENTER_POINT_SIZE); {wmitter center indicator}
  glBegin(GL_POINTS);
    glVertex2f(fCenter.X, fCenter.Y);
  glEnd;

  glcolor3f(0, 0, 1);
  glBegin(GL_LINES); {initial force vector}
    glVertex2f(fCenter.X, fCenter.Y);
    glVertex2f(fCenter.X, fCenter.Y - fImpulse);

    if fImpulse > 0  then begin
      glVertex2f(fCenter.X, fCenter.Y - fImpulse);
      glVertex2f(fCenter.X - 5, fCenter.Y - fImpulse + 5);
      glVertex2f(fCenter.X, fCenter.Y - fImpulse);
      glVertex2f(fCenter.X + 5, fCenter.Y - fImpulse + 5);
    end
    else
    if fImpulse < 0 then  begin
      glVertex2f(fCenter.X, fCenter.Y - fImpulse);
      glVertex2f(fCenter.X - 5, fCenter.Y - fImpulse - 5);
      glVertex2f(fCenter.X, fCenter.Y - fImpulse);
      glVertex2f(fCenter.X + 5, fCenter.Y - fImpulse - 5);
    end
    else begin
      glVertex2f(fCenter.X - 5, fCenter.Y - fImpulse);
      glVertex2f(fCenter.X + 5, fCenter.Y - fImpulse);
    end;

  glEnd;

  glPopMatrix;
end;

procedure TParticleEmitter.SetCount(Value: integer);
var
 i : integer;
begin
  if Value <> fCount then
  begin
    if fCount = 0 then
       for i:=0 to Value-1 do begin

       end;
  end;
end;

{ TParticle }

constructor TParticle.Create;
begin
  Position   := T2DVector.Create;
  Size       := TSize.Create;
  Speed      := T2DVector.Create(0,1);
end;

end.
