object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 729
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 0
    Top = 0
    Width = 1008
    Height = 729
    Align = alClient
    ExplicitLeft = -8
  end
  object EditVx: TSpinEdit
    Left = 64
    Top = 620
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = EditVxChange
  end
  object EditVy: TSpinEdit
    Left = 64
    Top = 648
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = EditVyChange
  end
  object EditVx2: TSpinEdit
    Left = 128
    Top = 620
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = EditVx2Change
  end
  object EditVy2: TSpinEdit
    Left = 128
    Top = 648
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnChange = EditVy2Change
  end
  object MainTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = MainTimerTimer
    Left = 768
    Top = 456
  end
  object ColorDialog1: TColorDialog
    Left = 560
    Top = 296
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Ini Files|*.ini'
    Left = 768
    Top = 304
  end
  object MainMenu1: TMainMenu
    Left = 416
    Top = 120
    object N1: TMenuItem
      Caption = #1060#1091#1085#1082#1094#1080#1080
      ShortCut = 16471
      object N6: TMenuItem
        Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
        ShortCut = 16462
        OnClick = N6Click
      end
      object N4: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        ShortCut = 16463
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1055#1091#1089#1082
        ShortCut = 16466
        OnClick = N5Click
      end
      object N7: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = N2Click
      end
      object N2: TMenuItem
        Caption = #1042#1099#1081#1090#1080
        ShortCut = 16471
        OnClick = N2Click
      end
    end
    object N3: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ShortCut = 16449
      OnClick = N3Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'ini'
    Filter = 'INI configuration file|*.ini'
    Left = 768
    Top = 232
  end
end
