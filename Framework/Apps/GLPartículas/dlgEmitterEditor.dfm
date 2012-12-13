object EmitterEditor: TEmitterEditor
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSizeToolWin
  Caption = 'Properties'
  ClientHeight = 293
  ClientWidth = 259
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 259
    Height = 293
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      BorderWidth = 3
      Caption = 'Emitter'
      object Label3: TLabel
        Left = 14
        Top = 35
        Width = 28
        Height = 13
        Caption = 'Width'
        FocusControl = spnWidth
      end
      object Label4: TLabel
        Left = 130
        Top = 35
        Width = 31
        Height = 13
        Caption = 'Height'
        FocusControl = spnHeigth
      end
      object Label1: TLabel
        Left = 14
        Top = 7
        Width = 28
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'X'
        FocusControl = spnX
      end
      object Label2: TLabel
        Left = 130
        Top = 7
        Width = 31
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Y'
        FocusControl = spnY
      end
      object Label5: TLabel
        Left = 13
        Top = 88
        Width = 36
        Height = 13
        Caption = 'Z Angle'
      end
      object Label6: TLabel
        Left = 3
        Top = 63
        Width = 39
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Impulse'
        FocusControl = spnImpulse
      end
      object Label7: TLabel
        Left = 6
        Top = 157
        Width = 34
        Height = 13
        Caption = 'Texure'
      end
      object spnWidth: TSpinEdit
        Left = 48
        Top = 32
        Width = 75
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = spnWidthChange
      end
      object spnHeigth: TSpinEdit
        Left = 164
        Top = 32
        Width = 75
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnChange = spnHeigthChange
      end
      object ckbVisibleBoundaries: TCheckBox
        Left = 48
        Top = 114
        Width = 101
        Height = 17
        Caption = 'Visible'
        TabOrder = 2
        OnClick = ckbVisibleBoundariesClick
      end
      object spnX: TSpinEdit
        Left = 48
        Top = 4
        Width = 75
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = spnXChange
      end
      object spnY: TSpinEdit
        Left = 164
        Top = 4
        Width = 75
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnChange = spnYChange
      end
      object trkAngleZ: TTrackBar
        Left = 54
        Top = 85
        Width = 191
        Height = 23
        Ctl3D = True
        LineSize = 0
        Max = 360
        Min = -360
        ParentCtl3D = False
        PageSize = 10
        PositionToolTip = ptBottom
        TabOrder = 5
        OnChange = trkAngleZChange
      end
      object spnImpulse: TSpinEdit
        Left = 48
        Top = 60
        Width = 75
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnChange = spnImpulseChange
      end
      object CheckBox1: TCheckBox
        Left = 48
        Top = 134
        Width = 101
        Height = 17
        Caption = 'Playing'
        TabOrder = 7
        OnClick = ckbVisibleBoundariesClick
      end
      object Panel1: TPanel
        Left = 48
        Top = 157
        Width = 194
        Height = 99
        BevelKind = bkSoft
        BevelOuter = bvNone
        Caption = 'Click to set the texture'
        TabOrder = 8
        object imgTexture: TImage
          Left = 0
          Top = 0
          Width = 190
          Height = 95
          Cursor = crHandPoint
          Align = alClient
          OnClick = imgTextureClick
          ExplicitLeft = 48
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Particles'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 8
    Top = 256
  end
end
