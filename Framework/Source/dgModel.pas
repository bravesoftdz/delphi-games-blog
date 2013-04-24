unit dgModel;

interface

uses
  dglOpenGl,
  dgCommonTypes,
  Generics.Collections;

type
  TGLModel = class(TInterfacedObject, IDrawable)
  private
    fName            : string;
    fMaterialFile    : string;
    fVertexes        : TList<TGlCoord>;
    fNormals         : TList<TGlCoord>;
    fTextureCoords   : TList<TGlTextureCoord>;
    fGroups          : TList<TGlGroup>;
    fMaterials       : TList<TGlMaterial>;
    procedure InitFields;
  public
    constructor Create;
    procedure Draw;

    property Name : string read fName write fName;
    property MaterialFile : string read fMaterialFile write fMaterialFile;

    property Vertexes       : TList<TGlCoord> read fVertexes write fVertexes;
    property Normals        : TList<TGlCoord> read fNormals write fNormals;
    property TextureCoords  : TList<TGlTextureCoord> read fTextureCoords write fTextureCoords;
    property Groups         : TList<TGlGroup> read fGroups write fGroups;
    property Materials      : TList<TGlMaterial> read fMaterials write fMaterials;
  end;

implementation

{ TGLModel }

constructor TGLModel.Create;
begin
  inherited;
  InitFields;
end;

procedure TGLModel.Draw;
begin

end;

procedure TGLModel.InitFields;
begin
  fVertexes        := TList<TGlCoord>.Create;
  fNormals         := TList<TGlCoord>.Create;
  fTextureCoords   := TList<TGlTextureCoord>.Create;
  fGroups          := TList<TGlGroup>.Create;
  fMaterials       := TList<TGlMaterial>.Create;
end;

end.
