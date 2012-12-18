unit dgCamera;

interface

uses
  OpenGL,
  dgCommonTypes,
  SysUtils;

type

  TProjectionKind = (
    pkPerspective,
    pkOrthogonal);


  TCameraParams = class
  private
    fFoV : single;
    fAspect: single;
    fClippingFar: single;
    fClippingNear: single;
  public
    // The horizontal Field of View, in degrees : the amount of "zoom". Think "camera lens". Usually between 90° (extra wide) and 30° (quite zoomed in)
    property FoV            : single read fFoV write fFoV;
    property Aspect         : single read fAspect write fAspect;
    property ClippingNear   : single read fClippingNear write fClippingNear;
    property ClippingFar    : single read fClippingFar write fClippingFar;
  end;

  TCamera = class
  private
    fPosition: TVector3D;
    fTarget  : TVector3D;
    fUp      : TVector3D;
    fParams : TCameraParams;
  public
    constructor Create;
    destructor Destroy; override;
    property Position: TVector3D read fPosition write fPosition;
    property Target  : TVector3D read fTarget write fTarget;
    property Up : TVector3D read fUp write fUp;
    property Params : TCameraParams read fParams write fParams;
  end;



implementation

{ TCamera }

constructor TCamera.Create;
begin
  inherited;
  fPosition := TVector3D.Create(0,0,-1);
  fTarget   := TVector3D.Create(0,0,0);
  fUp       := TVector3D.Create(0,1,0);
  fParams   := TCameraParams.Create;
  fParams.FoV          := 90;  //90º de abertura
  fParams.Aspect       := 4/3;
  fParams.ClippingFar  := 100.0;
  fParams.ClippingNear := 0.1;

  gluLookAt(fPosition.X, fPosition.Y, fPosition.Z,
            fTarget.X, fTarget.Y, fTarget.Z,
            fUp.X, fUp.Y, fUp.Z);
end;

destructor TCamera.Destroy;
begin
  FreeAndNil(fPosition);
  FreeAndNil(fTarget);
  FreeAndNil(fUp);
  FreeAndNil(fParams);
  inherited;
end;

end.
