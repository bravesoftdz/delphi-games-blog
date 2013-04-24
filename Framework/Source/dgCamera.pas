unit dgCamera;

interface

uses
  dglOpenGL,
  dgCommonTypes,
  Types,
  SysUtils;

type

  TProjectionKind = (
    pkPerspective,

    /// <summary>
    ///   Projeção ortogonal com a origem no centro
    /// </summary>
    pkOrthogonal);


  TCameraParams = class
  private
    fFoV : double;
    fClippingFar: double;
    fClippingNear: double;
    fViewPort : TRect;
  public
    /// <summary>
    /// The horizontal Field of View, in degrees : the amount of "zoom". Think "camera lens". Usually between 90° (extra wide) and 30° (quite zoomed in)
    /// </summary>
    property FoV            : double read fFoV write fFoV;
    property ClippingNear   : double read fClippingNear write fClippingNear;
    property ClippingFar    : double read fClippingFar write fClippingFar;
    property ViewPort       : TRect read fViewPort write fViewPort;
  end;


  TCamera = class
  private
    fPosition: TGlCoord;
    fTarget  : TGlCoord;
    fUp      : TGlCoord;
    fParams  : TCameraParams;
    fKind    : TProjectionKind;
    fZoom    : GLfloat;
    procedure InitFields;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Update;

    property Position : TGlCoord read fPosition write fPosition;
    property Target   : TGlCoord read fTarget write fTarget;
    property Up       : TGlCoord read fUp write fUp;
    property Params   : TCameraParams read fParams write fParams;
    property Kind     : TProjectionKind read fKind write fKind;
    property Zoom     : GLfloat read fZoom write fZoom;
  end;



implementation

{ TCamera }


constructor TCamera.Create;
begin
  inherited;
  InitFields;
end;

destructor TCamera.Destroy;
begin
  FreeAndNil(fPosition);
  FreeAndNil(fTarget);
  FreeAndNil(fUp);
  FreeAndNil(fParams);
  inherited;
end;


procedure TCamera.Update;
begin
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;

  case fKind of
    pkPerspective:
      begin
        gluPerspective(fParams.FoV,
                        //aspect = W / H
                       (fParams.ViewPort.Right - fParams.ViewPort.Left) / (fParams.ViewPort.Bottom - fParams.ViewPort.Top),
                       fParams.ClippingNear,
                       fParams.ClippingFar);
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity;
      end;

    pkOrthogonal:
      begin
        glDisable(GL_DEPTH_TEST);
        glDisable(GL_CULL_FACE);
        glOrtho(-(fParams.ViewPort.Left/2 * fZoom),
                (fParams.ViewPort.Left+ fParams.ViewPort.Right)/2 * fZoom,
                -(fParams.ViewPort.Top/2 * fZoom),
                (fParams.ViewPort.Top + fParams.ViewPort.Bottom/2) * fZoom,
                fParams.ClippingNear,
                fParams.ClippingFar);
      end;

  end;
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  gluLookAt(fPosition.X, fPosition.Y, fPosition.Z, fTarget.X, fTarget.Y, fTarget.Z, fUp.X, fUp.Y, fUp.Z);
end;

procedure TCamera.InitFields;
begin
  fZoom := 1.0;
  fPosition := TGlCoord.Create(0, 0, -1);
  fTarget := TGlCoord.Create(0, 0, 0);
  fUp := TGlCoord.Create(0, 1, 0);
  fParams := TCameraParams.Create;
  fParams.FoV := 90; //90º de abertura
  fParams.ClippingFar := 100;
  fParams.ClippingNear := 0.1;
  fKind := pkPerspective;
end;

end.
