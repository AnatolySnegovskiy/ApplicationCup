object Form1: TForm1
  Left = 406
  Top = 278
  Width = 240
  Height = 226
  Caption = 'Application Cup'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PopupMenu1: TPopupMenu
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Left = 96
    Top = 72
    object g1: TMenuItem
      Caption = #1040#1091#1076#1080#1086' '#1087#1088#1086#1080#1075#1088#1099#1074#1072#1090#1077#1083#1100
      OnClick = g1Click
    end
    object N1: TMenuItem
      Caption = #1042#1080#1076#1077#1086' '#1087#1088#1086#1080#1075#1088#1099#1074#1072#1090#1077#1083#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1097#1080#1082' '#1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N3Click
    end
  end
end
