object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Delphi ChatGPT interface'
  ClientHeight = 527
  ClientWidth = 558
  Color = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    558
    527)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 59
    Width = 129
    Height = 25
    Caption = 'Gonder'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 24
    Top = 16
    Width = 512
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clGradientInactiveCaption
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 24
    Top = 112
    Width = 337
    Height = 395
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clSkyBlue
    TabOrder = 2
  end
end
