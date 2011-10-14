unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,

  OpenGL,
  dgCommonTypes,
  dgParticles,
  uGLGameForm,
  dlgEmitterEditor;

type
  TfrmMain = class(TfrmGL2DTemplate)
  private
    fEmitterEditor: TEmitterEditor;
  protected
    procedure DrawScene; override;
  public
    Emitter: TParticleEmitter;

    procedure InitObjects; override;
    procedure FreeObjects; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


{ TfrmMain }

procedure TfrmMain.DrawScene;
begin
  Emitter.Draw;
end;

procedure TfrmMain.FreeObjects;
begin
  inherited;
  Emitter.Free;
  if Assigned(fEmitterEditor) then begin
     fEmitterEditor.Close;
     FreeAndNil(fEmitterEditor);
  end;

end;

procedure TfrmMain.InitObjects;
begin
  inherited;
  Emitter := TParticleEmitter.Create;
  Emitter.Center.X := XSize div 2;
  Emitter.Center.Y := YSize div 2;

  fEmitterEditor := TEmitterEditor.Create(self, Emitter);
  fEmitterEditor.Show;
end;

end.
