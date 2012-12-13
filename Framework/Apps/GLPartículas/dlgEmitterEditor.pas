unit dlgEmitterEditor;

interface

uses
  dgParticles,

  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, ExtDlgs, Spin;

type
  TEmitterEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    spnWidth: TSpinEdit;
    Label4: TLabel;
    spnHeigth: TSpinEdit;
    ckbVisibleBoundaries: TCheckBox;
    Label1: TLabel;
    spnX: TSpinEdit;
    Label2: TLabel;
    spnY: TSpinEdit;
    Label5: TLabel;
    trkAngleZ: TTrackBar;
    TabSheet2: TTabSheet;
    Label6: TLabel;
    spnImpulse: TSpinEdit;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Label7: TLabel;
    imgTexture: TImage;
    OpenPictureDialog: TOpenPictureDialog;
    procedure ckbVisibleBoundariesClick(Sender: TObject);
    procedure spnWidthChange(Sender: TObject);
    procedure spnHeigthChange(Sender: TObject);
    procedure spnXChange(Sender: TObject);
    procedure trkAngleZChange(Sender: TObject);
    procedure spnImpulseChange(Sender: TObject);
    procedure spnYChange(Sender: TObject);
    procedure imgTextureClick(Sender: TObject);
  private
    fEmitter: TParticleEmitter;
  public
    constructor Create(AOwner: TComponent; AEmitter:TParticleEmitter );
  end;


implementation


{$R *.dfm}


{ TEmitterEditor }

procedure TEmitterEditor.ckbVisibleBoundariesClick(Sender: TObject);
begin
  fEmitter.VisibleBoundary := ckbVisibleBoundaries.Checked;
end;

constructor TEmitterEditor.Create(AOwner: TComponent; AEmitter: TParticleEmitter);
begin
  inherited Create(AOwner);
  fEmitter := AEmitter;
  if Assigned(fEmitter) then
  begin
    ckbVisibleBoundaries.Checked := fEmitter.VisibleBoundary;
    spnX.Value := Round(fEmitter.Center.X);
    spnY.Value := Round(fEmitter.Center.Y);
    spnWidth.Value  := fEmitter.Width;
    spnHeigth.Value := fEmitter.Height;
    spnImpulse.Value := Round(fEmitter.Impulse);
    trkAngleZ.Position := Round(fEmitter.Angle);
  end;
end;

procedure TEmitterEditor.imgTextureClick(Sender: TObject);
var
  textureID : cardinal;
begin
  if OpenPictureDialog.Execute then
  begin
    {
    dgTextures.LoadTexture(OpenPictureDialog.FileName, textureID, false);
    fEmitter.Texture := textureID;
    if fEmitter.Texture > 0 then
    begin
       imgTexture.Picture.LoadFromFile(OpenPictureDialog.FileName);
       imgTexture.Stretch := (imgTexture.Picture.Height > imgTexture.Height) or (imgTexture.Picture.Width > imgTexture.Width);
       imgTexture.Center := not imgTexture.Stretch;
    end;
    }
  end;
end;

procedure TEmitterEditor.spnHeigthChange(Sender: TObject);
begin
  if spnHeigth.Text <> '' then
     fEmitter.Height := spnHeigth.Value;
end;

procedure TEmitterEditor.spnImpulseChange(Sender: TObject);
begin
  if spnImpulse.Text <> '' then
     fEmitter.Impulse := spnImpulse.Value;
end;

procedure TEmitterEditor.spnWidthChange(Sender: TObject);
begin
  if spnWidth.Text <> '' then
     fEmitter.Width := spnWidth.Value;
end;

procedure TEmitterEditor.spnXChange(Sender: TObject);
begin
  if spnX.Text <> '' then
     fEmitter.Center.X := spnX.Value;
end;

procedure TEmitterEditor.spnYChange(Sender: TObject);
begin
  if spnY.Text <> '' then
     fEmitter.Center.Y := spnY.Value;
end;

procedure TEmitterEditor.trkAngleZChange(Sender: TObject);
begin
  fEmitter.Angle := trkAngleZ.Position;
end;

end.


