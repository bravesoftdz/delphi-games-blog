unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Jpeg, PNGImage, GIFImg, JvGIF, ExtDlgs;

type
  PShade = ^TShade;
  TShade = record
    Code : byte;
    Intensity : byte;
  end;

  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    imgShades: TImage;
    Panel2: TPanel;
    Button1: TButton;
    cbxFont: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    memOut: TMemo;
    TabSheet2: TTabSheet;
    imgOrigem: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    ckbInvert: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgOrigemDblClick(Sender: TObject);
    procedure cbxFontChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    charW, charH: integer;
    fMustGenerateShades : boolean;
    fGrayAlphaImage: TBitmap;
    fASCIIImage    : array of array of AnsiChar;

    fAnsiCharByIntensity : array[0..254] of AnsiChar;
    fIntensityByAnsiChar : array[0..254] of byte;

    procedure InitShades;
    procedure ConvertSourceImage;
    procedure CreateASCIIImage;
    procedure ShowASCIIImage;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

function SortShadeByItensity(Item1, Item2: Pointer): Integer;
begin
  result := PShade(Item2)^.Intensity - PShade(Item1)^.Intensity;
end;


function RGBToColor(r, g, b: byte): TColor; inline;
begin
  result := (r or (g shl 8) or (b shl 16));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if fMustGenerateShades then
     InitShades;

  ConvertSourceImage;
  CreateASCIIImage;
  ShowASCIIImage;
end;

procedure TForm1.cbxFontChange(Sender: TObject);
begin
  fMustGenerateShades := true;
  memOut.Font.Name := cbxFont.Text;
end;


procedure TForm1.ConvertSourceImage;
var
  x, y : integer;
  pColor : PRGBQuad;
begin
  FreeAndNil(fGrayAlphaImage);
  fGrayAlphaImage:= TBitmap.Create;
  fGrayAlphaImage.PixelFormat := pf32bit;
  fGrayAlphaImage.Width   := imgOrigem.Picture.Width;
  fGrayAlphaImage.Height  := imgOrigem.Picture.Height;
  fGrayAlphaImage.Canvas.Draw(0,0, imgOrigem.Picture.Graphic);
  imgOrigem.Picture.SaveToFile('c:\tmp\teste-original.bmp');
  for y := 0 to fGrayAlphaImage.Height-1 do
  begin
    pColor := fGrayAlphaImage.ScanLine[y];
    for x:=0 to fGrayAlphaImage.Width-1 do
    begin
      pColor^.rgbReserved := (pColor^.rgbRed + pColor^.rgbGreen + pColor^.rgbBlue) div 3;
      inc(pColor);
    end;
  end;
  fGrayAlphaImage.SaveToFile('c:\tmp\teste-grayscale.bmp');
end;

procedure TForm1.CreateASCIIImage;
var
  x, y   : integer;
  pColor : PRGBQuad;
begin
  memOut.Font.Name := cbxFont.Text;
  memOut.Font.Size := 8;
  SetLength(fASCIIImage, fGrayAlphaImage.Width, fGrayAlphaImage.Height);
  for x:=0 to fGrayAlphaImage.Width-1 do
    for y := 0 to fGrayAlphaImage.Height-1 do
      fASCIIImage[x,y]:= AnsiChar(32);

  for y := 0 to fGrayAlphaImage.Height - 1 do
  begin
    pColor := fGrayAlphaImage.ScanLine[y];
    for x := 0 to fGrayAlphaImage.Width - 1 do
    begin
       if pColor^.rgbReserved <> 0 then
         if ckbInvert.Checked then
           fASCIIImage[x,y]:= fAnsiCharByIntensity[255-pColor^.rgbReserved]
         else
           fASCIIImage[x,y]:= fAnsiCharByIntensity[pColor^.rgbReserved];
      Inc(pColor);
    end;
  end;

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
 fMustGenerateShades:= true;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(fGrayAlphaImage);
//  SetLength(fASCIIImage,0);
end;

procedure TForm1.imgOrigemDblClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgOrigem.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm1.InitShades;
var
  bmp : TBitmap;
  i, x, y, pixelCount : integer;
  k, oneUnderPxCount: Double;
  p : PRGBQuad;
  rct : TRect;
begin
  FillChar(fIntensityByAnsiChar, length(fIntensityByAnsiChar), $FF);
  FillChar(fAnsiCharByIntensity, length(fAnsiCharByIntensity), AnsiChar(' '));

  bmp := TBitmap.Create;
  bmp.Canvas.Font.Size := 10;
  bmp.Canvas.Font.Color := clBlack;
  bmp.Canvas.Font.Name := cbxFont.Text;
  bmp.PixelFormat := pf32bit;
  charW := bmp.Canvas.TextWidth('A');
  charH := bmp.Canvas.TextHeight('A');
  bmp.Height := charH;
  bmp.Width  := charW;
  pixelCount := charW * charH;
  oneUnderPxCount := 1/pixelCount;

  bmp.Canvas.Brush.Color := clWhite;
  for i := 0 to high(fIntensityByAnsiChar) do
  begin
    k := 0;
    bmp.Canvas.FillRect(rect(0,0, charW, charH));
    bmp.Canvas.TextOut(0,0, WideChar(i));
    k := 0;
    for y := 0 to bmp.Height-1 do
    begin
      p := PRGBQuad(bmp.ScanLine[y]);
      for x := 0 to bmp.Width-1 do
      begin
         if p^.rgbBlue = 255 then
            k := k + 1;
        Inc(p);
      end;
    end;
    fIntensityByAnsiChar[i] := trunc(( k / pixelCount ) * 255);
    fAnsiCharByIntensity[fIntensityByAnsiChar[i]] := AnsiChar(i);
  end;


  for i:=1 to High(fAnsiCharByIntensity) do
    if (fAnsiCharByIntensity[i] = AnsiChar(' ')) and (i <> 32) then
       fAnsiCharByIntensity[i] := fAnsiCharByIntensity[i-1];

  //gera imagem de exemplo com os toms de cinza por caracter
  FreeAndNil(bmp);
  bmp := TBitmap.Create;
  bmp.PixelFormat := pf24bit;
  bmp.Canvas.Font.Create.Name := cbxFont.Text;
  bmp.Canvas.Font.Size := 9;
  bmp.Height := charH * 2;
  bmp.Width  := (Length(fIntensityByAnsiChar) * charW);
  bmp.Canvas.FloodFill(0, 0, clRed,fsSurface);
  for i := 0 to High(fIntensityByAnsiChar) do
  begin
    rct.Top    := 0;
    rct.Bottom := charH;
    rct.Left   := (i * charW);
    rct.Right  := rct.Left + charW;
    bmp.Canvas.Brush.Color :=clWhite;
    bmp.Canvas.TextOut(rct.Left, 0, AnsiChar(i));
    rct.Top    := charH;
    rct.Bottom := charH * 2;
    bmp.Canvas.Brush.Color := RGBToColor(fIntensityByAnsiChar[i],
                                         fIntensityByAnsiChar[i],
                                         fIntensityByAnsiChar[i]);
    bmp.Canvas.FillRect(rct);
  end;
  imgShades.Top    := 0;
  imgShades.Left   := 0;
  imgShades.Width  := bmp.Width;
  imgShades.Height := bmp.Height;
  imgShades.Picture.Assign(bmp);
  //imgShades.Picture.SaveToFile('c:\tmp\shades.bmp');
  FreeAndNil(bmp);
  fMustGenerateShades := false;
end;


procedure TForm1.ShowASCIIImage;
var
  s : AnsiString;
  x, y : integer;
begin
  PageControl1.ActivePageIndex := 0;
  memOut.Lines.Add('Gerando imagem...');
  memOut.Lines.BeginUpdate;
  memOut.Clear;
  for y := 0 to fGrayAlphaImage.Height - 1 do
  begin
    s := '';
    for x :=0 to fGrayAlphaImage.Width-1 do
       s := s + AnsiChar(fASCIIImage[x,y]);
    memOut.Lines.Add(s);
  end;
  memOut.Lines.EndUpdate;
end;

end.
