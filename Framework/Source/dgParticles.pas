unit dgParticles;

interface

uses
  dgCommonTypes,
  dglOpenGL;

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
    destructor Destroy; override;
  end;


  //Emissor de partículas
  TParticleEmitter = class
  private
    const
      BOUNDARY_LINE_WIDTH = 1;
      CENTER_POINT_SIZE = 2;
    var
      fParticles : array of TParticle;
      fAngle     : single;
      fImpulse   : single;
      fWidth     : integer;
      fHeight    : integer;
      fCenter    : TPoint2D;
      fTexture   : cardinal;
      fCount     : integer;
      fGravity   : T2DVector;
      fWind      : T2DVector;
      fVisibleBoundary : boolean;
      fLifeTime : TRange;
  protected
    procedure InitParticles;
    procedure DestroyParticles;
    procedure DrawBoundaries;
  public
    constructor Create(AParticleCount: integer = 100);
    destructor Destroy; override;

    procedure Draw;

    property Center    : TPoint2D read fCenter write fCenter;
    property Angle     : Single read fAngle write fAngle;
    property Impulse   : Single read fImpulse write fImpulse;
    property LifeTime  : TRange read fLifeTime write fLifeTime;

    property Texture : cardinal read fTexture write fTexture;
    property Count : integer read fCount;
    property Width : integer read fWidth write fWidth;
    property Height: integer read fHeight write fHeight;

    property VisibleBoundary: boolean read fVisibleBoundary write fVisibleBoundary;

    property Gravity : T2DVector read fGravity write fGravity;
    property Wind    : T2DVector read fWind write fWind;
  end;

implementation

{ TParticleEmitter }

constructor TParticleEmitter.Create(AParticleCount: integer = 100);
begin
  SetLength(fParticles, 0);
  fAngle     := 0;
  fImpulse   := 10;
  fCenter    := TPoint2D.Create(200, 200);
  fWidth     := 300;
  fHeight    := 50;
  fCount     := AParticleCount;
  fGravity   := T2DVector.Create;
  fWind      := T2DVector.Create;
  fLifeTime  := TRange.Create(1000, 10000);
  VisibleBoundary := true;
  fTexture   := 0;

  InitParticles;
end;

destructor TParticleEmitter.Destroy;
begin
  fCenter.Free;
  fGravity.Free;
  fWind.Free;
  fLifeTime.Free;
  DestroyParticles;
end;

procedure TParticleEmitter.Draw;
var
  lParticle : TParticle;
  HalfH, HalfW : single;
  i : integer;
begin
  if fVisibleBoundary then DrawBoundaries;

  for i:=0 to Pred(Length(fParticles)) do
  begin
    lParticle := fParticles[i];
//    if lParticle.Alive then
      begin
        HalfH  := lParticle.Size.Height / 2;
        HalfW  := lParticle.Size.Width / 2;
        glColor3f(0,0,1);
        glLoadIdentity;
        glNormal3f(0, 0, 1);
        {
        glEnable(GL_TEXTURE_2D);
        if fTexture > 0 then glBindTexture(GL_TEXTURE_2D, fTexture);
        glBegin(GL_QUADS);
           glTranslatef(lParticle.Position.X, lParticle.Position.Y, 0);
           glRotatef(lParticle.Angle, 0, 0, 1);
           glTranslatef(-lParticle.Position.X, -lParticle.Position.Y, 0);

           glTexCoord2f(0,0);
           glVertex2f(lParticle.Position.X - HalfW, lParticle.Position.Y - HalfH);

           glTexCoord2f(1,0);
           glVertex2f(lParticle.Position.X - HalfW, lParticle.Position.Y + HalfH);

           glTexCoord2f(1,1);
           glVertex2f(lParticle.Position.X + HalfW, lParticle.Position.Y + HalfH);

           glTexCoord2f(0,1);
           glVertex2f(lParticle.Position.X + HalfW, lParticle.Position.Y - HalfH);
        glEnd;
        glDisable(GL_TEXTURE_2D);
        }
    end;
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

  {Boudaries}
  if fTexture > 0 then begin
     glEnable(GL_TEXTURE_2D);
     glBindTexture(GL_TEXTURE_2D, fTexture);
     glBegin(GL_QUADS);
//      glTexCoord2f(0, 0); glVertex3f((fCenter.X - HalfW), (fCenter.Y - HalfH), 0);
//      glTexCoord2f(1, 0); glVertex3f((fCenter.X - HalfW), (fCenter.Y + HalfH), 0);
//      glTexCoord2f(1, 1); glVertex3f((fCenter.X + HalfW), (fCenter.Y + HalfH), 0);
//      glTexCoord2f(0, 1); glVertex3f((fCenter.X + HalfW), (fCenter.Y - HalfH), 0);

      glTexCoord2f(0, 0); glVertex3f((fCenter.X + HalfW), (fCenter.Y - HalfH), 0);
      glTexCoord2f(1, 0); glVertex3f((fCenter.X + HalfW), (fCenter.Y + HalfH), 0);
      glTexCoord2f(1, 1); glVertex3f((fCenter.X - HalfW), (fCenter.Y + HalfH), 0);
      glTexCoord2f(0, 1); glVertex3f((fCenter.X - HalfW), (fCenter.Y - HalfH), 0);
     glEnd;
  end
  else begin
    glBegin(GL_LINE_LOOP);
      glVertex3f((fCenter.X - HalfW), (fCenter.Y - HalfH), 0);
      glVertex3f((fCenter.X - HalfW), (fCenter.Y + HalfH), 0);
      glVertex3f((fCenter.X + HalfW), (fCenter.Y + HalfH), 0);
      glVertex3f((fCenter.X + HalfW), (fCenter.Y - HalfH), 0);
    glEnd;
  end;


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

procedure TParticleEmitter.DestroyParticles;
var
  i: integer;
begin
  for i:=0 to Pred(Length(fParticles)) do
    fParticles[i].Free;
  SetLength(fParticles, 0);
end;

procedure TParticleEmitter.InitParticles;
var
  i: Integer;
begin
  Assert(fCount > 0);

  SetLength(fParticles, fCount);
  for i:= 0 to Pred(fCount) do
  begin
    fParticles[i] := TParticle.Create;
    fParticles[i].Position.X := fCenter.X;
    fParticles[i].Position.Y := fCenter.Y;
  end;

end;

{ TParticle }

constructor TParticle.Create;
begin
  Position   := T2DVector.Create;
  Size       := TSize.Create;
  Speed      := T2DVector.Create(0,1);
end;

destructor TParticle.Destroy;
begin
  Size.Free;
  Speed.Free;
  Position.Free;
  inherited;
end;

end.
